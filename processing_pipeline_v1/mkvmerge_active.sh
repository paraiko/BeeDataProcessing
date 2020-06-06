#!/bin/bash

recnr=$1
inputBasePath=/AristaNas/Raak_Raw_Recordings
outputBasePath=/AristaNas/RaakData/01_VideoData/00_ActiveRecordings
#FILES=/NAS/BeeNas/01_RawData/00_rawh264files/$recnr/*.h264

#create the necessary directories if they do not exist
mkdir -p $inputBasePath/$recnr/mkv_converted
mkdir -p $outputBasePath/$recnr
 
#find all h264 files in the top leveldir of the searchpath that are create > 10 minutes ago (prevents inclusion of the active file) 
FILES=`find $inputBasePath/$recnr/*.h264 -maxdepth 0 -mmin +10`

# count the amount of h264 files in the directory.
#h264ct = ls *.h264 | wc -l
#echo $h264ct

for f in $FILES
do
  # take action on each file. $f store current file name
  echo "Processing $f file..."

  #get the filenema without the path and store it in a variable
  fn="$(basename -- $f)"

  #Use mkvmerge to put the h264 file in an mkv container and match the speed of the container to the  recording frames/second
  mkvmerge --default-duration 0:30fps $f  -o $outputBasePath/$recnr/$fn.mkv

  #move the h264 files to another folder so they are not converted again.
  mv $f /AristaNas/Raak_Raw_Recordings/$recnr/mkv_converted/$fn
done
