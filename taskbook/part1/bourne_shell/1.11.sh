#!/bin/sh

FILES_COUNT=$(ls | wc -l)

for((I=0;I<FILES_COUNT;I++)); do
	printf "@"
done

printf "\n"
