#!/bin/bash
FILES=*.mkv
fileCtr=0
for f in $FILES
  do
  ffmpeg -ss 00:00:01 -i $f -vframes 1 -q:v 1 $f.jpg
done
