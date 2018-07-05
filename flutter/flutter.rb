class Flutter < Formula
  desc 'Build beautiful native apps in record time.'
  homepage "https://flutter.io"
#  version ':latest'
#  sha256 :no_check
  #head "https://github.com/flutter/flutter.git"
  url "https://github.com/flutter/flutter.git",
      :using => :git,
      :tag => "v0.5.6",
      :branch => "master",
      :revision => "472bbccf756e7954af2a81d2c8abc46d65a570af"

  option "without-visual-studio-code", "Disable Visual Studio Code."
  option "with-android-studio", "Enable Android Studio."
  option "with-intellij-idea-ce", "Enable IntelliJ Idea CE."

  depends_on java: '8'
  depends_on "libimobiledevice"
  depends_on "ideviceinstaller"
  depends_on "ios-deploy"
  depends_on "cocoapods"
  depends_on "mas"

  def as_variable(variable, value)
     return "export #{variable}=#{value}"
  end

  def update_profile(prefix, filenames)
    cwd=`pwd`
    Dir.chdir(ENV['HOME'])

    filenames.each do |filename|

      text = File.file?(filename) ? File.read(filename): ""

      if text =~ /flutter.env/
         replace = text.gsub(/(source ).+(\/flutter.env)/, "\\1#{prefix}\\2")
      else
         replace = text << "source #{prefix}/flutter.env"
      end
      File.open(filename, "w") { |file| file.puts replace }
    end
    Dir.chdir(cwd)
  end

  def install
    # Flutter needs to be in a full git clone of its repository in order to run.
    # Thankfully, that's included in the tarball/zip, so just copy the contents:

    # Create a brewfile for the non formula dependencies
    casks = [
      'cask "java8"',
      'cask "android-sdk"',
      'cask "android-ndk"',
      'cask "intel-haxm"',
      'mas "XCode", id: 497799835'
    ]

    if build.with? "visual-studio-code"
       casks.push('cask "visual-studio-code"')
    end

    if build.with? "android-studio"
       casks.push('cask "android-studio"')
    end

    if build.with? "intellij-idea-ce"
       casks.push('cask "intellij-idea-ce"')
    end

    File.open('Brewfile', "w") { |file| file.puts casks }

    # Create an environment variables file
    File.open("flutter.env", "w") do |file|
      file.puts [
        #as_variable("PATH", "$HOME/.jenv/bin:$PATH"),
        #'eval "$(jenv init -)"',
        as_variable("JAVA_HOME", '`/usr/libexec/java_home -v 1.8`'),
        as_variable("ANDROID_NDK_HOME", "/usr/local/share/android-ndk"),
        as_variable("ANDROID_SDK_HOME", "/usr/local/share/android-sdk"),
        as_variable("ANDROID_HOME", "$ANDROID_SDK_HOME"),
        as_variable("PATH", "${PATH}:$HOME/Applications/flutter/bin"),
        as_variable("PATH", "${PATH}:$ANDROID_HOME/tools"),
        as_variable("PATH", "${PATH}:$ANDROID_HOME/platform-tools")
      ]
    end

    # Create a script which
    # Uses the environment variables
    # Updates the sdkmanager dependencies
    # Installs additional non brew dependencies
    # Accepts all android licenses
    IO.write "flutter-cfg.sh", <<~EOS
      #!/bin/zsh

      cd #{prefix}
      brew bundle install
      source flutter.env
      sdkmanager --update
      yes | sdkmanager --licenses

      sdkmanager "tools"
      sdkmanager "platform-tools"
      sdkmanager "build-tools;27.0.3"
      sdkmanager "platforms;android-27"
      sdkmanager "extras;android;m2repository"
      sdkmanager "extras;google;m2repository"
      sdkmanager "patcher;v4"

      pip install six

      echo "Accept XCode license. Sudo login"
      sudo xcodebuild -license accept
      sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
      # Open Xcode to install additional components
      simctl=`xcrun simctl --version 2>&1 | grep "PROGRAM:simctl" | wc -l | tr -d ' '`
      if [ $simctl -eq 0 ]; then
         open /Applications/XCode.app
      fi

      vscode=`cat Brewfile | grep visual-studio-code | wc -l | tr -d ' '`
      if [ $vscode -eq 0 ]; then
         code --install-extension dart-code.flutter
      fi

      pod setup
      flutter doctor -v
      cd -
    EOS

    cp_r ".", prefix
    chmod "+x", prefix/"flutter-cfg.sh"

  end

  def post_install
    # Something about Homebrew's post-install process removes write permissions
    # and Flutter writes to bin/cache, particularly .lockfile, so reenable
    # write permissions on the cache folder
    #chmod_R "u+w", prefix/"bin/cache"
    # See https://github.com/Homebrew/homebrew-core/issues/17098#issuecomment-386031418
    #add_to_profile(prefix, ['.zprofile', '.profile'])
    puts([
      "Flutter has been installed.",
      "Use the commands below to install dependencies.",
      "Sign into Mac App store to install XCode. \n\n",
      "   mas signin <user@icloud.com> \n",
      "   #{prefix}/flutter-cfg.sh\n\n",
      "Add to your profile:\n\n",
      "   source #{prefix}/flutter.env\n"
    ])

  end

  test do
    # system "flutter", "--version"

    # This doesn't work because Flutter uses shlock on macos, which doesn't
    # work with the `brew test` environment. My guess is that `brew test` runs
    # flutter with limited permissions. Flutter is set to run shlock and sleep
    # until it succeeds, so `brew test --verbose flutter` results in:
    #
    # shlock: open(/usr/local/Cellar/flutter/0.3.1-beta/bin/cache/shlock53833): Operation not permitted
    # shlock: open(/usr/local/Cellar/flutter/0.3.1-beta/bin/cache/shlock53835): Operation not permitted
    # shlock: open(/usr/local/Cellar/flutter/0.3.1-beta/bin/cache/shlock53837): Operation not permitted
    # ...etc. forever
    #
    # So just assert that it exists:

    assert_predicate "#{bin}/flutter", :exist?

  end
end
