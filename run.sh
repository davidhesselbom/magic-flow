#!/bin/bash
export OOC_LIBS=$(dirname `pwd`)
ARGS=""
USE_FILE="umpr.use"
if [[ -e rock_arguments.txt ]]
then
	ARGS=$(cat rock_arguments.txt)
fi
FLAGS=${@:2}
magic source/
magiccode=$?
rock -q +-Wall $ARGS $FLAGS $USE_FILE
exitcode=$?
if [[ $exitcode -eq 0 && $magiccode -eq 0 && -f ./Main ]]
then
./Main 1920,1080 ~/Video/HD\ Pole\ 1.MOV | avplay -f rawvideo -pixel_format gray -video_size 1920x1080 -
fi
exit $exitcode

