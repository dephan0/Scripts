#!/bin/bash

set -e

read -r -p "Do you wish to create a zip archive of each directory inside itself? [y/n]: " answer

if ! [[ $answer =~ ^([yY][eE][sS]|[yY])$ ]]; then
	exit 1
fi

DIR_LIST=$(echo */ | tr -d '/') # delete slashes at the end
EXCLUDES=(".vscode*" "main.dSYM*" ".DS_Store*")
ARCHIVE_NAME="Szymon_Hankus"

echo "( excludes: ${EXCLUDES[@]} )"

# ANSI color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

for dir in $DIR_LIST; do
	# create a subshell to change to directory
	(
	cd "$dir" # jump to each directory

	if [[ -f "./${ARCHIVE_NAME}.zip" ]]; then
		printf "${RED}${dir}/${ARCHIVE_NAME}.zip${NC} already exists.\n" 
	else
		printf "Creating ${GREEN}${dir}/${ARCHIVE_NAME}.zip${NC}...\n"

		zip -r "$ARCHIVE_NAME".zip . -x "${EXCLUDES[@]}" | awk '{print "\t"$0}'
		printf "\n"
	fi
	) 

done
