#!/bin/sh

if mkdir new_dir; then
	echo "Directory created"
else
	echo "Failed to make new directory"
fi
