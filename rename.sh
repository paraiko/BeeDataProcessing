#!/bin/bash
FILES=*.mkv
fileCtr=201
rec_nr=023
for f in $FILES
do
    in=$f
    fileNr=$(printf "%03d" $fileCtr)
    fout="/NAS/BeeNas/05_compressed_recordings/"$rec_nr"/ren/compr_"$rec_nr"_"$fileNr".mkv"
    echo "${fout}"
    mv $f $fout
    fileCtr=$((fileCtr+1))
done
