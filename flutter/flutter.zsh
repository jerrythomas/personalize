#!/usr/bin/env zsh

brew bundle install

sudo xcodebuild -license accept
sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
# Open Xcode to install additional components
simctl=`xcrun simctl --version 2>&1 | grep "PROGRAM:simctl" | wc -l | tr -d ' '`
if [ $simctl -eq 0 ]; then
   open /Applications/XCode.app
fi

# todo: handle already existing entries
jdk8=`/usr/libexec/java_home -v 1.8`
touch ~/.zshrc
echo 'export PATH="$HOME/.jenv/bin:$PATH"' >> ~/.zshrc
echo 'eval "$(jenv init -)"' >> ~/.zshrc
echo 'export JAVA_HOME=`/usr/libexec/java_home -v 1.8`' >> ~/.zshrc

jenv add $jdk8
jenv global 1.8

source ~/.zshrc

# todo: handle already existing entries in zprofile
touch ~/.zprofile
echo 'export ANDROID_NDK_HOME=/usr/local/share/android-ndk' >> ~/.zprofile
echo 'export ANDROID_SDK_ROOT=/usr/local/share/android-sdk' >> ~/.zprofile
echo 'export ANDROID_HOME=$ANDROID_SDK_ROOT' >> ~/.zprofile
echo 'export PATH=${PATH}:$HOME/Applications/flutter/bin' >> ~/.zprofile
echo 'export PATH=${PATH}:$ANDROID_HOME/tools'>> ~/.zprofile
echo 'export PATH=${PATH}:$ANDROID_HOME/platform-tools' >> ~/.zprofile
source ~/.zprofile

pip install six
pod setup

sdkmanager --update
yes | sdkmanager --licenses # accept all licenses

sdkmanager "tools"
sdkmanager "platform-tools"
sdkmanager "build-tools;27.0.3"
sdkmanager "platforms;android-27"
sdkmanager "extras;android;m2repository"
sdkmanager "extras;google;m2repository"
sdkmanager "patcher;v4"

flutter upgrade
#yes | flutter doctor --android-licenses

code --install-extension dart-code.flutter

result=`flutter doctor -v`
failure=`echo $result | grep '^\[✗'`
success=`echo $result | grep '^\[✓'`
warning=`echo $result | grep '^\[!'`
partial=`echo $result | grep '✗'`

# Ignore Android Studio, its not required. VS code or IntelliJ Idea are fine.
count=`echo $failure | wc -l | tr -d ' '`
if [ $count -gt 0 ]; then
   studio=`echo $failure | grep -i 'android studio' | wc -l | tr -d ' '`
   if [ $studio -ne 1 -o $count -gt 1 ]; then
      echo $failure
   fi
fi

# Ignore VS code warning. Flutter does not detect the plugin
# Ignore connected devices, you may have none
count=`echo $warning | wc -l | tr -d ' '`
if [ $count -gt 2 ]; then
   vscode=`echo $warning | grep -i 'vs code' | wc -l |tr -d ' '`
   device=`echo $warning | grep -i 'connected device' | wc -l | tr -d ' '`
   count=`expr $count - $vscode - $device`
   if [ $count -gt 0 ]; then
      echo $warning
   fi
fi
