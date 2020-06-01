#!/bin/bash

# get arguments from commandline

recnr=$1
startGapNr=$2
endGapNr=$3

for ((i=$startGapNr;i<=$endGapNr;++i))
#for i in {0..5..1}
do
    nr=$(printf "%04d" $i)
    cp black_1920x1080.jpg $recnr"_"$nr"_0000-00-00_0000.jpg"
    
done