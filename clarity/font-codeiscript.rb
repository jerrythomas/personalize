cask 'font-codeiscript' do
  version :latest
  sha256 :no_check

  url 'https://github.com/kencrocken/FiraCodeiScript/archive/master.zip'
  name 'Fira Code iScript '
  homepage 'https://github.com/kencrocken/FiraCodeiScript'

  font "#{staged_path}/FiraCodeiScript-Bold.ttf"
  font "#{staged_path}/FiraCodeiScript-Bold.ttf"
  font "#{staged_path}/Script12PitchBT.ttf"
end
