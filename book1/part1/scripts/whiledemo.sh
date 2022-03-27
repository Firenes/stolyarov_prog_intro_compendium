#!/bin/sh

I=1
while [ $I -le 100 ]; do
	echo $I
	I=$(( I+1 ))
done
