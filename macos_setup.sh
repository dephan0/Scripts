#!/usr/bin/env bash
set -eo pipefail

echo "Disabling the chime on startup..."
sudo nvram StartupMute=%01 && echo "Done."

echo "Removing the 'recents' section from the dock..."
defaults write com.apple.dock 'show-recents' -bool 'false' && echo "Done."


# DOCK SETUP
echo "Setting up the dock..."
dock_item_plist () {
		local path="$1"
	    printf '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>%s</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>', "$path" 
}
app_paths=( 
"/System/Applications/Calendar.app/"
"/System/Applications/Reminders.app/"
"/Applications/Telegram.app/"
"/Applications/Spotify.app/"
"/Applications/Visual Studio Code.app/"
"/Applications/iTerm.app/"
"/Applications/Safari.app/"
)
defaults delete com.apple.dock 'persistent-apps'
for path in "${app_paths[@]}"; do
	defaults write com.apple.dock 'persistent-apps' -array-add "$(dock_item_plist "$path")"
done

defaults write com.apple.dock 'showhidden' -bool 'true' # dim the icons of the hidden apps
defaults write com.apple.dock 'mineffect' -string 'scale' # use the 'scale' animation when minimizing windows

# setup autohiding behavior 
defaults write com.apple.dock 'autohide' -bool 'true'
defaults write com.apple.dock 'autohide-delay' -float '0.0'
defaults write com.apple.dock 'autohide-time-modifier' -float '0.4'
echo "Done."


