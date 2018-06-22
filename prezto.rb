#!/usr/bin/env ruby -w

require 'uri'
require 'fileutils'
require 'optparse'

global = FALSE
prompt = nil

OptionParser.new do |opts|
    opts.banner = "Usage: prezto [options]"
    opts.on('--global', 'Configure prezto for all users') do 
      global = TRUE
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
    zdotdir = ENV['ZDOTDIR'] || "/usr/local/prezto"
    system("mkdir -p #{zdotdir}")
    system("chmod o+w #{zdotdir}")
    prefix = "/etc/"
else 
    zdotdir = ENV['ZDOTDIR'] || ENV['HOME']
    prefix = "#{zdotdir}/."
end
prezto = "#{zdotdir}/.zprezto"
zshrc = "#{prefix}zshrc"

if File.read(zshrc) =~ /ZDOTDIR/
    text = File.read(zshrc)
    replace = text.gsub(/(.+ZDOTDIR=).+/, "\\1#{zdotdir}")
    File.open(zshrc, "w") { |file| file.puts replace }
else
    open(zshrc, 'a') { |f|
        f.puts "export ZDOTDIR=#{zdotdir}"
    }
#   system("echo 'export ZDOTDIR=#{zdotdir}' >> #{zshrc}")
end

# Update if present else clone the repo
if File.directory?("#{prezto}")  
   #system("cd #{prezto} && git fetch --recurse-submodules")
else
   system("git clone --recursive #{git_url} #{prezto}")
end

# Add the configuration files
filenames = ["zlogin", "zlogout", "zshenv"]
filenames.each do |file|
    unless File.file?("#{prefix}#{file}")
        open("#{prefix}#{file}", 'a') { |f|
            f.puts "source #{prezto}/runcoms/#{file}"
        }
       #system("echo 'source #{prezto}/runcoms/#{file}' > #{prefix}#{file}")
    end
end

# Append to zshrc
filenames = ["zpreztorc", "zshrc"]
filenames.each do |file|
    # avoid repeating the appended line
    unless File.read(zshrc) =~ /runcoms\/#{file}/
        open(zshrc, 'a') { |f|
            f.puts "source #{prezto}/runcoms/#{file}"
        }
    end
end
puts("updated #{zshrc}")

system("chmod o-w #{zshrc}")
zprofile = "#{prefix}zprofile"
unless File.read(zprofile) =~ /runcoms\/zprofile/
    open(zprofile, 'a') { |f|
       f.puts "source #{prezto}/runcoms/zprofile"
    }
end

# Add the clarity theme
FileUtils.cp("themes/prompt_clarity_setup", "#{prezto}/modules/prompt/functions/")

# Switch the prompt theme to the one specified
unless prompt.nil?
    zpreztorc = "#{prezto}/runcoms/zpreztorc"
    text = File.read(zpreztorc)
    replace = text.gsub(/(^zstyle.+ theme).+/, "\\1 '#{prompt}'")
    File.open(zpreztorc, "w") { |file| file.puts replace }
end