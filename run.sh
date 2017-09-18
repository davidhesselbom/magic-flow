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
rock -q +-Wall $ARGS $FLAGS $USE_FILE
exitcode=$?
if [[ $exitcode -eq 0 && -f ./Main ]]
then
avconv -i ~/Video/UMPR\ Videos/HD\ Pole\ 1.MOV -f rawvideo -pix_fmt yuv420p -| ./Main |  avplay -f rawvideo -pix_fmt gray -s 1920x1080 -
fi
exit $exitcode

