#!/bin/bash

recnr=$1
#FILES=/NAS/BeeNas/01_RawData/00_rawh264files/$recnr/*.h264
inputpath="/NAS/BeeNas/01_RawData/00_ActiveRecordings"
outputpath="/NAS/BeeNas/03_ProcessedData/01_ghost_gmic_90min_runavg/00_ghost_10m_jpg"
fileCtr=0

#create output directories if they do not exist.
mkdir -p $outputpath/$recnr

#find all mkvfiles in the top leveldir of the searchpath that are create > 30 minutes ago (prevents inclusion of the active file) 
FILES=`find $inputpath/$recnr/*.mkv -maxdepth 0`

# count the amount of MKV files in the directory.
mkvct=`find $inputpath/$recnr/*.mkv -maxdepth 0 | wc -l`

# count the amount of gmicghosted files in the directory.
jpgct=`find $outputpath/$recnr/*.jpg -maxdepth 0 | wc -l`

#mkvct = ls *.h264 | wc -l
echo $mkvct
echo $jpgct

for f in $FILES
do
  if [ $fileCtr -ge $jpgct ]
  then
    echo "Processing $f file..." 
    # take action on each file. $f store current file name
  
    #get the filenema without the path and store it in a variable
    fn="$(basename -- $f)"
    
    nr=$(printf "%04d" $fileCtr)
    gmic -average_video $f,0,-1,300 -n 0,255 -o $outputpath/$recnr/$fn"_"$nr.jpg

    #Use mkvmerge to put the h264 file in an mkv container and match the speed of the container to the  recording frames/second
    #mkvmerge --default-duration 0:30fps $f  -o /AristaNas/RaakData/01_VideoData/00_ActiveRecordings/$recnr/$fn.mkv

    #move the h264 files to another folder so they are not converted again.
    #mv $f /AristaNas/Raak_Raw_Recordings/$recnr/mkv_converted/$fn
  fi
  fileCtr=$((fileCtr+1))
done
