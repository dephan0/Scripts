#!/bin/bash

# parses options n and t, so that they both hav to have an optarg
# e.g -t 2 -n 1
while getopts "n:t:" option; do
	printf "opt: %s, optarg: %s\n" "$option" "$OPTARG";
done
