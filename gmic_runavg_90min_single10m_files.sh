#!/bin/bash

recnr=051
#FILES=/NAS/BeeNas/01_RawData/00_rawh264files/$recnr/*.h264
inputpath="/NAS/BeeNas/03_ProcessedData/01_ghost_gmic_90min_runavg/00_ghost_jpg/$recnr"
outputpath="$inputpath/90min_runavg"
fileCtr=0

#find all jpgfiles in the top leveldir of the inputpath 
FILES=`find $inputpath/$recnr/*.mkv -maxdepth 0`

# count the amount of jpg files in the directory.
jpgct=`find $inputpath/$recnr/*.mkv -maxdepth 0 | wc -l`

# count the amount of running_avg files in the output directory.
runavgct=`find $outputpath/$recnr/*.jpg -maxdepth 0 | wc -l`

#jpgct = ls *.h264 | wc -l
echo $jpgct
echo $runavgct

for f in $FILES
do
  if [ $fileCtr -ge $jpgct ]
  then
    echo "Processing $f file..." 
    # take action on each file. $f store current file name
  
    #get the filenema without the path and store it in a variable
    fn="$(basename -- $f)"
    
    nr=$(printf "%04d" $fileCtr)
    gmic -average_video $f,0,-1,600 -n 0,255 -o $outputpath/$recnr/$fn"_"$nr.jpg

    #Use mkvmerge to put the h264 file in an mkv container and match the speed of the container to the  recording frames/second
    #mkvmerge --default-duration 0:30fps $f  -o /AristaNas/RaakData/01_VideoData/00_ActiveRecordings/$recnr/$fn.mkv

    #move the h264 files to another folder so they are not converted again.
    #mv $f /AristaNas/Raak_Raw_Recordings/$recnr/mkv_converted/$fn
  fi
  fileCtr=$((fileCtr+1))
done

