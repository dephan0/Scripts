#!/bin/sh

# PICTURE_DIR can be chosen (argument $1)
PICTURE_DIR="${1:-$HOME/.local/share/backgrounds}"
ALREADY_USED="$PICTURE_DIR/already_used"
[ ! -f "$ALREADY_USED" ] && touch "$ALREADY_USED"

# A random picture from the PICTURE_DIR, which is not in the already_used file
get_new_random () {
	local pictures="$(find "$PICTURE_DIR" -type f \( -name '*.png' -o -name '*.jpg' \) -exec realpath {} \;)"
	local not_used="$({ echo "$pictures"; cat "$ALREADY_USED"; } | sort | uniq -u)"  # Get only the files which appear
																					 # in $pictures and not in alread_used.
																					 # Won't work if already_used is tampered with.

	if [ -z "$not_used" ]; then  # Image base exhausted. Everything in already_used
		local random="$(cat "$ALREADY_USED" | head --lines=-1 | shuf -n1)"  # get a random line from already_used (which now contains 
																			# every picture) but exclude the last one (to avoid 
																			# repeating backgrounds)
		echo $random > $ALREADY_USED  # reset the already_used file
	else
		local random="$(echo "$not_used" | shuf -n1)"
		echo $random >> $ALREADY_USED
	fi

	echo $random
}


main () {
	local new="$(get_new_random)"
	gsettings set org.gnome.desktop.background picture-uri "file://$new"
	# echo $new
}

main
