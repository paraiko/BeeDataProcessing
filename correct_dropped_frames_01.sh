#!/bin/bash

FILES=*.mkv
o=framecount.csv
i=0
j=0

for f in $FILES
do
  echo "Processing $f file..."
  i=$((i+1))
  # get the framenr from the current file
  frameCt=$(mediainfo --Output="Video;%FrameCount%" $f)

  { echo "$f" | tr "\n" ";"; mediainfo --Output="Video;%FrameCount%" $f; }  >> $o
  
  # fill in the missing frames process the file if > 2 sec is missing (<17940 frames) 
  if (($frameCt<17940 )); then
    echo "filling in missing frames for $f "
    corrFact=$(bc <<<"scale=8; $frameCt / 18000")
    newFps=$(bc <<<"scale=8; $corrFact * 30")
    
    # change the fps of the file to the new value
    stringFps=fps
    mkvmerge --default-duration 0:$newFps$stringFps $f -o $f$newFps.mkv

    # fill in missing frames to 30fps with ffmpeg
    ffmpeg -i $f$newFps.mkv -filter:v fps=fps=30 -c:v libx264 -b:v 17M $f.new.mkv
    #safe the original file
    mv $f $f.orig
    #change the framerate back to 30 fps
    mkvmerge --default-duration 0:30fps $f.new.mkv --fix-bitstream-timing-information 0:1 -o $f

    #cleanup the mess
    rm $f$newFps.mkv
    rm $f.new.mkv
    j=$((j+1))
  fi
done
echo "$j of $i files had dropped frames"




