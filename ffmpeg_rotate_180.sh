#!/bin/bash
FILES=*.mkv
fileCtr=46
rec_nr=001
for f in $FILES
do
  #ffmpeg -vsync 0 -hwaccel_device 0 -hwaccel cuvid -c:v h264_cuvid -i $f -an -vf "hflip,vflip,format=yuv420p" -metadata:s:v rotate=0 -c:v h264_nvenc -rc:v vbr_hq -cq:v 19 -bf:v 3 -b:v 2500k -maxrate:v 2000K -profile:v high r_$f
  ffmpeg -i $f -vf "hflip,vflip,format=yuv420p" -metadata:s:v rotate=0 -codec:v libx264 -codec:a copy r_$f.mkv

done

