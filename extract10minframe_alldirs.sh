#!/bin/bash

DIRS=$(find . -type d -mindepth 1 -maxdepth 1)
for dir in $DIRS ; do
    echo $dir
    cd $dir
    ls
    recname=${PWD##*/}  #get only the dir name form the whole path (here the recording name)
    FILES=*.mkv
    fileCtr=0
    for f in $FILES ; do
        ffmpeg -ss 00:00:01 -i $f -vframes 1 -q:v 1 $f.jpg 
    done
    echo $recname_%04d.png
    cd ..
done


