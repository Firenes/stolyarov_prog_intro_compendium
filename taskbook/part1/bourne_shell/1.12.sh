#!/bin/sh

#Little description:
#This script accept in parameters launching another script with parameters
#We tracking start time of starting current string
#Starting script from parameters with $*
#End tracking ending time of nested script
#And printing total time after ending nested string

START=$(date +%s)

sh $*

END=$(date +%s)

TOTAL=$((END - START))

echo Total time: $TOTAL
