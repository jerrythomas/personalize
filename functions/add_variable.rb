require 'fileutils'
# add a variable to the config file
def add_variable(filename, variables, values)
    index = 0
    data = File.read(filename)
    variables.each do |variable|
        if data =~ /#{variable}=/
            data = data.gsub(/(.+#{variable}=).+/, "\\1#{values.at(index)}")
        else
            data << "export #{variable}=#{values.at(index)}"
        end
        index = index + 1
    end

    File.open(filename, "w") { |file| file.puts data }
end
