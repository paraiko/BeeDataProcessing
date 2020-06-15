#!/bin/bash

recNr=$1
#FILES=/NAS/BeeNas/01_RawData/00_rawh264files/$recNr/*.h264
inputPath="/NAS/BeeNas/03_ProcessedData/01_ghosting/00_ghost_avg-10m_jpg"
outputPath="/NAS/BeeNas/03_ProcessedData/01_ghosting/01_ghost_ravg-90m_jpg"
tempPath="/NAS/BeeNas/03_ProcessedData/01_ghosting/temp/ravg-90m"
fileCtr=0

#create output directories if they do not exist.
mkdir -p $outputPath/$recNr
mkdir -p $tempPath/$recNr

#find all jpgfiles in the top leveldir of the inputPath 
FILES=`find $inputPath/$recNr/*.jpg -maxdepth 0`

# count the amount of input jpg files in the directory.
jpgCt=`find $inputPath/$recNr/*.jpg -maxdepth 0 | wc -l`

# count the amount of already processed jpg files in the directory.
ravgCt=`find $outputPath/$recNr/*.jpg -maxdepth 0 | wc -l`
# increase ravgCt with 8 to compensate for the first skipped 8 files in the average
#ravgCt=$((ravgCt+8))

#Set the filecounter
fileCtr=0

#jpgCt = ls *.h264 | wc -l
echo "jpg count: $jpgCt; runavgct: $ravgCt"

for f in $FILES
do
    #echo "Processing $f file..." 
    # take action on each file. $f store current file name
  
    #get the filenema without the path and store it in a variable
    fn="$(basename -- $f)"

    if [ $fileCtr -ge $ravgCt ]
    then

        if [ $fileCtr -lt 8 ] 
        then

            nr=$(printf "%04d" $fileCtr)
            cp $f $tempPath/$recNr/$nr.jpg
            gmic -average_files $tempPath/$recNr/????.jpg,0,-1,1 -n 0,255 -o $outputPath/$recNr/$fn
        else

            nr=$(printf "%04d" $fileCtr)
            cp $f $tempPath/$recNr/$nr.jpg
            firstFile=$((fileCtr-8))
            firstFile=$(printf "%04d" $firstFile)

            gmic -average_files $tempPath/$recNr/????.jpg,0,-1,1 -n 0,255 -o $outputPath/$recNr/$fn
            rm $tempPath/$recNr/$firstFile.jpg
            ####gmic -average_files output.mkv,0,-1,600 -n 0,255 -o $f.jpg
        fi
    fi
    fileCtr=$((fileCtr+1))
done
