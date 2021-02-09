#!/bin/bash

#  copy-frameworks.sh
#  MovieTrack
#
#  Created by Marcio Garcia on 31/05/20.
#  Copyright © 2020 oxltech.com. All rights reserved.

counter=0

echo ${SCRIPT_INPUT_FILE_COUNT}
while (( $counter < ${SCRIPT_INPUT_FILE_COUNT} ))
do
    imputFile="SCRIPT_INPUT_FILE_$counter"
    outputFile="SCRIPT_OUTPUT_FILE_$counter"
    echo ${!imputFile}
    echo ${!outputFile}
    cp -rf ${!imputFile} ${!outputFile}
    counter=$(( counter+1 ))
done
