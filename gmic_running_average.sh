#!/bin/bash
FILES=*.mkv
fileCtr=0
for f in $FILES
do
  if [ $fileCtr -eq 0 ] 
  then
    file0=$f
    gmic -average_video $file0,0,-1,300 -n 0,255 -o $f.jpg
  elif [ $fileCtr -eq 1 ]
  then
    file1=$f
    mkvmerge -o output.mkv $file0 +$file1
    gmic -average_video output.mkv,0,-1,300 -n 0,255 -o $f.jpg
    rm output.mkv
  elif [ $fileCtr -eq 2 ]
  then
    file2=$f
    mkvmerge -o output.mkv $file0 +$file1 +$file2
    gmic -average_video output.mkv,0,-1,600 -n 0,255 -o $f.jpg
    rm output.mkv
  elif [ $fileCtr -eq 3 ]
  then
    file3=$f
    mkvmerge -o output.mkv $file0 +$file1 +$file2 +$file3
    gmic -average_video output.mkv,0,-1,600 -n 0,255 -o $f.jpg
    rm output.mkv
  elif [ $fileCtr -eq 4 ]
  then
    file4=$f
    mkvmerge -o output.mkv $file0 +$file1 +$file2 +$file3 +$file4
    gmic -average_video output.mkv,0,-1,600 -n 0,255 -o $f.jpg
    rm output.mkv
  elif [ $fileCtr -eq 5 ]
  then
    file5=$f
    mkvmerge -o output.mkv $file0 +$file1 +$file2 +$file3 +$file4 +$file5
    gmic -average_video output.mkv,0,-1,600 -n 0,255 -o $f.jpg
    rm output.mkv
  elif [ $fileCtr -eq 6 ]
  then
    file6=$f
    mkvmerge -o output.mkv $file0 +$file1 +$file2 +$file3 +$file4 +$file5 +$file6
    gmic -average_video output.mkv,0,-1,600 -n 0,255 -o $f.jpg
    rm output.mkv
  elif [ $fileCtr -eq 7 ]
  then
    file7=$f
    mkvmerge -o output.mkv $file0 +$file1 +$file2 +$file3 +$file4 +$file5 +$file6 +$file7
    gmic -average_video output.mkv,0,-1,600 -n 0,255 -o $f.jpg
    rm output.mkv
  elif [ $fileCtr -eq 8 ]
  then
    file8=$f
    mkvmerge -o output.mkv $file0 +$file1 +$file2 +$file3 +$file4 +$file5 +$file6 +$file7 +$file8
    gmic -average_video output.mkv,0,-1,600 -n 0,255 -o $f.jpg
    rm output.mkv  
  else
    file0=$file1
    file1=$file2
    file2=$file3
    file3=$file4
    file4=$file5
    file5=$file6
    file6=$file7
    file7=$file8
    file8=$f
    echo "ct: $fileCtr, f7: $file7, -f: $f"
    mkvmerge -o output.mkv $file0 +$file1 +$file2 +$file3 +$file4 +$file5 +$file6 +$file7 +$file8
    gmic -average_video output.mkv,0,-1,600 -n 0,255 -o $f.jpg
    rm output.mkv
  fi
  fileCtr=$((fileCtr+1))
done
