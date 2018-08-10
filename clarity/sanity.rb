require 'fileutils'
require 'json'

def addPersistentApp(app)
  xml = [
    "<dict>",
    "<key>tile-data</key>",
    "<dict>",
    "<key>file-data</key>",
    "<dict>",
    "<key>_CFURLString</key><string>#{app}</string>",
    "<key>_CFURLStringType</key>",
    "<integer>0</integer>",
    "</dict>",
    "</dict>",
    "</dict>"
  ]
  cmd = "defaults write com.apple.dock persistent-apps -array-add \'#{xml.join('')}\'"

  puts cmd
end

def dockApps(setting)
  if setting['key'] == "persistent-apps"
    puts "defaults write com.apple.dock persistent-apps -array"

    setting['value'].each do |app|
      addPersistentApp(app)
    end
  end
end

def apply(domains)
  domains.each do |target|
    app = target["app"]

    target["settings"].each do |setting|
      case setting['type']
      when 'string'
        key = "'#{setting['key']}'"
        value = "'#{setting['value']}'"
      when 'array'
        dockApps(setting)
      else
        key = setting['key']
        value = setting['value']
      end
      puts "defaults write #{app} #{key} -#{setting["type"]} #{value}"
    end

    if target.key?("post-cmd")
      puts target["post-cmd"]
    end
  end
end

text = File.read('mac-settings.json')
config = JSON.parse(text)

apply(config)
