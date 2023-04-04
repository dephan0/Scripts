#!/bin/sh

# PICTURE_DIR can be chosen
PICTURE_DIR="${1:-$HOME/.local/share/backgrounds}"

# A random picture from the PICTURE_DIR
get_random () {
	local random="$(find "$PICTURE_DIR" -type f \( -name '*.png' -o -name '*.jpg' \) -exec realpath {} \; | shuf -n1)"

	echo $random
}

# A random picture from the PICTURE_DIR, which is not the same as the current wallpaper
get_different_random () {
	local current="$(gsettings get org.gnome.desktop.background picture-uri)"
	# trim the leading 'file:// and the trailing ' to get just the path
	current="${current#\'file://}"  
	current="${current%\'}" 

	local random="$(get_random)"
	while [ "$random" = "$current" ]; do  # keep randomising until you get a new file
		random="$(get_random)"
	done

	echo $random
}


main () {
	local new="$(get_different_random)"
	gsettings set org.gnome.desktop.background picture-uri "file://$new"
}

main
