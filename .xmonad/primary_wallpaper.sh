#!/bin/bash
cd ~/.xmonad/
rm wallpaper
ln -s wallpaper_primary wallpaper

feh --no-fehbg --bg-scale wallpaper
