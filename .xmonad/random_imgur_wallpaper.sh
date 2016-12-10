#!/usr/bin/env bash
URL=$( curl "http://imgur.com/r/catwallpapers/new" | egrep -o "i.imgur.com/[[:alnum:]]+" | cut -c-19 | shuf | head -n1 ).jpg
ID=$( echo $URL | cut -c13-19 )
wget -O /tmp/$ID.jpg $URL

cd ~/.xmonad
rm wallpaper
ln -s /tmp/$ID.jpg wallpaper
feh --no-fehbg --bg-scale wallpaper
