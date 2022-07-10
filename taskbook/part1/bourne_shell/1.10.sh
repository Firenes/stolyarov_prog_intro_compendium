#!/bin/sh

N=$1
M=$2

for ((I=0;I<M;I++)); do
	printf '%s' "$((N + I))"
    if [ I != $((M-1)) ]; then
        printf " "
    fi
done

printf "\n"
