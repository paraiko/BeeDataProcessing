#!/bin/bash
FILES=*.mkv
for f in $FILES
do
  echo "Processing $f file..."
  # take action on each file. $f store current file name
  mkvmerge --default-duration 0:25fps $f  -o $f.25.mkv
done




