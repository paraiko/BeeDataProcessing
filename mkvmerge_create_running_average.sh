#!/bin/bash
FILES=*.mkv
fileCtr=0

for f in $FILES
do
  if [ $fileCtr -eq 0 ] 
  then
   file0=$f
  elif [ $fileCtr -eq 1 ]
  then
    file1=$f
  elif [ $fileCtr -eq 2 ]
  then
    file2=$f
  elif [ $fileCtr -eq 3 ]
  then
    file3=$f
  elif [ $fileCtr -eq 4 ]
  then
    file4=$f
  elif [ $fileCtr -eq 5 ]
  then
    file5=$f
  elif [ $fileCtr -eq 6 ]
  then
    file6=$f
  elif [ $fileCtr -eq 7 ]
  then
    file7=$f
    mkvmerge -o output.mkv $file0 +$file1 +$file2 +$file3 +$file4 +$file5 +$file6 +$file7
    gmic -average_video output.mkv,0,-1,900 -n 0,255 -o $f.jpg
    rm output.mkv   
    fileCtr=0
  fi
done
