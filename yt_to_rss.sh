#!/bin/sh

CHANNEL_ID=$(curl -s "$1" | egrep -o '\"externalId\":\".+?\"' | cut -d: -f2 | tr -d \")
echo "https://www.youtube.com/feeds/videos.xml?channel_id=$CHANNEL_ID"
