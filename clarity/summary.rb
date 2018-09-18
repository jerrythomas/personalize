require 'yaml'
require 'optparse'

options = {}
options[:depth] = 2

OptionParser.new do |opts|
  opts.banner = "Usage: summary [options]"

  opts.on("-d", "--depth DEPTH", "Number of levels for the table of contents.") do |v|
    options[:depth] = v.to_i
  end

  opts.on("-h", "--help", "Prints this help") do
    puts opts
    exit
  end
end.parse!

config = YAML.load_file('book.json')

root = "."
unless config['root'].nil? || config['root'].empty?
  root = config['root']
end

files = Dir.glob("#{root}/**/*.{md}").sort()

summary = Array.new
summary.push("\# #{config['title']}\n\n")

files.each { |file|

  data = File.readlines(file)
             .grep(/^#/)

  if (data.length == 0) then
    title = File.basename(file, ".md")
                .gsub(/\d+/, '')
                .gsub('-', ' ')
                .strip
                .capitalize
    summary.push("* [#{title}](#{file})")
  else
    data.each { |line|
      tokens = line.chomp.split(' ', 2)

      if (tokens[0].length <= options[:depth]) then
        indent = '  ' * (tokens[0].length - 1)
        href = tokens[1].downcase().gsub(' ', '-')

        summary.push ("#{indent}* [#{tokens[1]}](#{file}\##{href})")
      end
    }
  end
  #puts (toc)
  #puts (data)

}

File.open("SUMMARY.md", "w+") do |f|
  f.puts(summary)
end
