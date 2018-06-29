#!/usr/bin/env zsh
brew tap homebrew/cask
brew cask install homebrew/cask-versions/java8

brew install --HEAD libimobiledevice
brew install ideviceinstaller
brew install ios-deploy
brew install cocoapods
pip install six
pod setup

sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer

#export PATH=$ANDROID_HOME/build-tools/$(ls $ANDROID_HOME/build-tools | sort | tail -1):$PATH
brew cask install android-sdk
brew cask install android-ndk
brew cask install intel-haxm

sdkmanager "tools"
sdkmanager "platform-tools"
sdkmanager "build-tools;27.0.3"
sdkmanager "platforms;android-27"
sdkmanager "extras;android;m2repository"
sdkmanager "extras;google;m2repository"
sdkmanager "patcher;v4"

touch ~/.zprofile
echo 'export ANDROID_NDK_HOME=/usr/local/share/android-ndk' >> ~/.zprofile
echo 'export ANDROID_SDK_ROOT=/usr/local/share/android-sdk' >> ~/.zprofile
echo 'export ANDROID_HOME=$ANDROID_SDK_ROOT' >> ~/.zprofile
echo 'export PATH=${PATH}:$HOME/Applications/flutter/bin' >> ~/.zprofile
echo 'export PATH=${PATH}:$ANDROID_HOME/tools'>> ~/.zprofile
echo 'export PATH=${PATH}:$ANDROID_HOME/platform-tools' >> ~/.zprofile
source ~/.zprofile

flutter doctor --android-licenses

#sdkmanager --update
code --install-extension dart-code.flutter

result=`flutter doctor -v`
failure=`echo $result | grep '^\[✗'`
success=`echo $result | grep '^\[✓'`
warning=`echo $result | grep '^\[!'`
partial=`echo $result | grep '✗'`

# Ignore Android Studio, its not required. VS code or IntelliJ Idea are fine.
count=`echo $failure | wc -l`
if [ $count -gt 0 ]; then
   studio=`echo $failure | grep -i 'android studio' | wc -l`
   if [ $studio -ne 1 || $count -gt 1 ]; then
      echo $failure
   fi
fi

# Ignore VS code warning. Flutter does not detect the plugin
# Ignore connected devices, you may have none
count=`echo $warning | wc -l`
if [ $count -gt 2 ]; then
   vscode=`echo $warning | grep -i 'vs code' | wc -l`
   device=`echo $warning | grep -i 'connected device' | wc -l`
   count=`expr $count - $vscode - $device`
   if [ $count -gt 0 ]; then
      echo $warning
   fi
fi
