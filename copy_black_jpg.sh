#!/bin/bash

rec_nr=020
fin= /NAS/BeeNas/03_ProcessedData/01_gmic-90min-runavg_ghost/black_1920x1080.jpg
start=1
end=2

for i in {$start..$end}
do
    fileNr=$(printf "%04d" $i)
    fout="/NAS/BeeNas/05_compressed_recordings/"$rec_nr"/"$rec_nr"_"$fileNr".jpg"
    echo "${fout}"
    cp $fin $fout
    fileCtr=$((fileCtr+1))
done
