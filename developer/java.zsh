#!/bin/zsh

jdk8_home=`/usr/libexec/java_home -v 1.8`
ver=`$jdk8_home/bin/java -version 2>&1 | grep version | cut -f3 -d" " | sed s/\"//g | sed s/_/\./g`
count=`jenv versions | grep "$ver" | wc -l | tr -d ' '`

if [ $count -eq 0 ]; then
    jenv add $jdk8_home
fi
jenv global 1.8
