#!/bin/bash
cd ~/.xmonad
echo in dir
FILE=$( readlink wallpaper )
echo $FILE | grep "/tmp/" || exit # already savede
NAME=$( basename $FILE )


echo gonna copy
cp $FILE ~/Pictures/wallpapers/

echo copied 

echo rm all the links
rm wallpaper wallpaper_primary ||

echo link
ln -s ~/Pictures/wallpapers/$NAME wallpaper_primary

echo show it 
./primary_wallpaper.sh
