#!/bin/sh

START=$(date +%s)

sh $*

RETURN_CODE=$?

END=$(date +%s)

TOTAL=$((END - START))

echo Total time: $TOTAL
echo Return value from "$($0)": $RETURN_CODE

exit $RETURN_CODE
