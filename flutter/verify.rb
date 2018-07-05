_IDEACE_ = 'intellij-idea-ce'
_VSCODE_ = 'visual-studio-code'
_STUDIO_ = 'android-studio'

prefix=`brew info flutter | grep Cellar | cut -f1 -d' '`

result=`flutter doctor -v`.split("\n")
success = result.select {|line| line =~ /^\[✓/ }
failure = result.select {|line| line =~ /^\[✗/ }
warning = result.select {|line| line =~ /^\[!/ }
partial = result.select {|line| line =~ /✗/ }

content = File.read("#{prefix}/Brewfile")

# The three editor dependencies can fail if not included
expected_fail = 3
actual_fail = 0
# Validate VS Code was installed, if it was selected
if content =~ /#{_VSCODE_}/
   match = success.select { |line| line =~ /VS Code/ }
   if match.length != 1
      actual_fail += 1
   end
   expected_fail -= 1
end

# Validate Idea CE was installed, if it was selected
if content =~ /#{_IDEACE_}/
   if success =~ /IntelliJ/
      actual_fail += 1
   end
   expected_fail -= 1
end

# Validate Android Studio was installed, if it was selected
if content =~ /#{_STUDIO_}/
   if success =~ /Android Studio/
      actual_fail += 1
   end
   expected_fail -= 1
end

if failure.length > expected_fail | actual_fail > 0
    puts("Some dependencies were not installed properly.\n")
    puts(result)
end
