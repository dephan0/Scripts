#!/usr/bin/env bash
# Compresses a pdf (consisting mostly of bitmap images) using GhostScript
# https://askubuntu.com/questions/113544/how-can-i-reduce-the-file-size-of-a-scanned-pdf-file
set -eo pipefail

info_exit () {
	echo "Usage: compress_pdf.sh [-l level] input_file [output_file]"
	echo "level - numeric value ranging from 1 to 3. 1 = lowest compression, 3 = highest compression"
	exit 1
}


compress_pdf () {
	local level_labels=('/printer' '/ebook' '/screen')
	local level_label="${level_labels[$(($1 - 1))]}"
	local input_file=$2
	local output_file=$3
	gs \
	-sDEVICE=pdfwrite \
	-dCompatibilityLevel=1.4 \
	-dPDFSETTINGS="$level_label" \
	-dNOPAUSE -dQUIET -dBATCH \
	-sOutputFile="$output_file" \
	"$input_file"
	# -dPDFSETTINGS has the following options:
	# /screen (72 dpi)
	# /ebook (150 dpi)
	# /printer (300 dpi)
	# /default 
}

# parse options
while getopts ':l:' option; do
	case "$option" in
		l)
			[[ "$OPTARG" =~ ^[1-3]$ ]] || info_exit
			LEVEL="$OPTARG"
			;;
		*)
			info_exit
			;;
	esac
done

[[ -z "$LEVEL" ]] && LEVEL=2  # default level is 2

shift $((OPTIND - 1))  # shift arguments past the options

if [[ $# -eq 0 ]]; then
	info_exit
elif [[ $# -eq 1 ]]; then  # If there's only one argument, create a temporary file
	compress_pdf "$LEVEL" "$1" tmp
	mv tmp "$1"
else
	compress_pdf "$LEVEL" "$1" "$2"
fi
