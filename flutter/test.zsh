#!/bin/zsh
#
result=`flutter doctor -v`
failure=`echo $result | grep '^\[✗'`
success=`echo $result | grep '^\[✓'`
warning=`echo $result | grep '^\[!'`
partial=`echo $result | grep '✗'`

# Ignore Android Studio, its not required. VS code or IntelliJ Idea are fine.
count=`echo $failure | wc -l`
if [ $count -gt 0 ]; then
   studio=`echo $failure | grep -i 'android studio' | wc -l`
   if [ $studio -ne 1 -o $count -gt 1 ]; then
      echo $failure
   fi
fi
