#!/bin/bash
FILES=*.h264
for f in $FILES
do
  echo "Processing $f file..."
  # take action on each file. $f store current file name
  mkvmerge --default-duration 0:30fps $f  -o /raak04/mp055/$f.mkv
done




