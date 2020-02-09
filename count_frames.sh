#!/bin/bash
FILES=*.mkv
o="framects.csv"
for f in $FILES
do
  echo " processing $f.."
  { echo "$f" | tr "\n" ";"; mediainfo --Output="Video;%FrameCount%" $f; }  >> $o
done 

