#!/bin/bash
FILES=*.mkv
for f in $FILES
do
  echo "Processing $f file..."
  # take action on each file. $f store current file name
  ffmpeg -i $f -ss 00:00:01.000 -vframes 1 10minjpg/$f.jpg
done




