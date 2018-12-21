#!/usr/bin/env ruby -w

require 'uri'
require 'fileutils'
require 'optparse'
require '../functions/add_variable'

global = FALSE
remove = FALSE
prompt = nil

OptionParser.new do |opts|
    opts.banner = "Usage: prezto [options]"
    opts.on('--global', 'Configure prezto for all users') do
      global = TRUE
    end
    opts.on('--remove', 'Remove prezto') do
        remove = TRUE
      end
    opts.on('-p [ARG]', '--prompt [ARG]', "Specify the prompt style to be used") do |v|
      prompt = v
    end
    opts.on('-h', '--help', 'Display this help') do
      puts opts
      exit
    end
end.parse!

git_url = "https://github.com/sorin-ionescu/prezto.git"

# Use the etc configurations for global
if global
    zdotdir = ENV['ZDOTDIR'] || "/usr/local"
    #system("mkdir -p #{zdotdir}")
    #system("chmod o+w #{zdotdir}")
    prefix = "/etc/"
else
    zdotdir = ENV['ZDOTDIR'] || ENV['HOME']
    prefix = "#{zdotdir}/."
end
prezto = "#{zdotdir}/.zprezto"
zshrc = "#{prefix}zshrc"

# Create configuration files or append existing ones
def ref_runcoms_scripts(filenames, srcpath, destpath, destfile = nil)
    filenames.each do |file|
        dest = (destfile == nil)? "#{destpath}#{file}":"#{destpath}#{destfile}"
        unless File.file?("#{dest}") && File.read("#{dest}") =~ /runcoms\/#{file}/
            open("#{dest}", 'a') { |f|
                f.puts "source #{srcpath}/runcoms/#{file}"
            }
        end
    end
end

# Switch zdotdir base with the home variable
def use_home_instead_of_zdotdir(filenames)
    filenames.each do |filename|
        text = File.read(filename)
        replace = text.gsub(/(.+)ZDOTDIR:-\$(.+)/, "\\1\\2")
        File.open(filename, "w") { |file| file.puts replace }
    end
end

# Remove call to config files. Delete if empty file results
def cleanup(filenames, patterns)
    filenames.each do |filename|
        if File.file?(filename)
            content = File.readlines(filename)
            patterns.each do |pattern|
            content = content.reject {|line|
                            line =~ /#{pattern}/
                        }
            end
            if content.empty?
                system("rm #{filename}")
            else
                File.open(filename, "w") { |f| content.each { |line| f.puts line } }
            end
        end
    end
end

# Clean up mode. Removing presto
if (remove)
    filenames = ["zlogin", "zlogout", "zshenv", "zshrc" ,"zprofile"]
    filenames.each { |s| s.prepend("#{prefix}") }
    cleanup(filenames, ["source .+runcoms\/z.+","^export ZDOTDIR=", "^export HISTFILE="])
    if File.directory?(prezto)
        system("rm -r #{prezto}")
    end
else
    if File.directory?(prezto)
        #system("cd #{prezto} && git fetch --recurse-submodules")
    else
        system("git clone --recursive #{git_url} #{prezto}")
    end
    FileUtils.cp("clarity.zsh", "#{prezto}/runcoms/")
    
    # use $HOME instead of ${ZDOTDIR:-$HOME} for zcompdump
    use_home_instead_of_zdotdir(["#{prezto}/runcoms/zlogin"])

    add_variable(zshrc, ["ZDOTDIR"],["#{zdotdir}"])

    ref_runcoms_scripts(["zlogin", "zlogout", "zshenv", "zprofile"],
                        "#{prezto}",
                        "#{prefix}")
    ref_runcoms_scripts(["zpreztorc", "zshrc", "clarity.zsh"],
                        "#{prezto}",
                        "#{prefix}",
                        "zshrc")

    # Add the clarity theme
    FileUtils.cp("prompt_clarity_setup", "#{prezto}/modules/prompt/functions/")

    # Switch the prompt theme to the one specified
    unless prompt.nil?
        zpreztorc = "#{prezto}/runcoms/zpreztorc"
        text = File.read(zpreztorc)
        replace = text.gsub(/(^zstyle.+ theme).+/, "\\1 '#{prompt}'")
        File.open(zpreztorc, "w") { |file| file.puts replace }
    end
end
system("chmod o-w #{zshrc}")
