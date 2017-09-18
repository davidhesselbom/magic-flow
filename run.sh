#!/bin/bash
export OOC_LIBS=$(dirname `pwd`)
ARGS=""
USE_FILE="umpr.use"
if [[ -e rock_arguments.txt ]]
then
	ARGS=$(cat rock_arguments.txt)
fi
FLAGS=${@:2}

rock -q +-Wall $ARGS $FLAGS $USE_FILE
exitcode=$?
if [[ $exitcode -eq 0 && -f ./Main ]]
then
	cat data | ./Main
	exitcode=$?
fi
exit $exitcode
