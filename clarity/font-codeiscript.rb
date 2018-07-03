cask 'font-codeiscript' do
  version :latest
  sha256 :no_check

  url do
    require 'open-uri'
    file = open('https://github.com/kencrocken/FiraCodeiScript/archive/master.zip')
              #.open
              #.read.scan(%r{href="([^"]+.zip)"}).flatten.first
    IO.copy_stream(file,"latest.zip")
     #         puts(file.to_s)
  end
  name 'Fira Code iScript '
  homepage 'https://github.com/kencrocken/FiraCodeiScript'

  font 'FiraCodeiScript-Bold.ttf'
  font 'FiraCodeiScript-Bold.ttf'
  font 'Script12PitchBT.ttf'
end
