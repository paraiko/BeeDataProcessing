#!/bin/bash
FILES=*.mkv
fileCtr=46
rec_nr=001
for f in $FILES
do
    in=$f
    fileNr=$(printf "%03d" $fileCtr)
    fout="/media/paraiko/Seagate/"$rec_nr"/compr_"$rec_nr"_"$fileNr".mkv"
    echo "${fout}"
    ffmpeg -vsync 0 -hwaccel_device 0 -hwaccel cuvid -c:v h264_cuvid -i $in -an -c:v h264_nvenc -rc:v vbr_hq -cq:v 19 -bf:v 3 -b:v 2500k -maxrate:v 2000K -profile:v high $fout

    fileCtr=$((fileCtr+1))
done
