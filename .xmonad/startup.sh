#!/usr/bin/env bash

function restart {
  pkill "$1"
  $@ > /dev/null &
}

function ensure {
  pgrep $1 || $1 $2 &
}

function set_wallpaper {
  feh --no-fehbg --bg-fill $1
}

mkdir -p /tmp/temp

set_wallpaper ~/.xmonad/wallpaper

restart trayer --edge top --align right --widthtype request --expand true --SetDockType true --SetPartialStrut true --transparent true --alpha 0 --tint 0x1A1918 --expand true --heighttype pixel --height 30 --monitor 1 --padding 1

ensure xscreensaver -no-splash

restart nm-applet


ensure volumeicon

ensure clipit

ensure blueman-applet

ensure gpg-agent "--daemon --pinentry-program $(which pinentry)"

xset -dpms # turn off screen sleep
xset r rate 250 30 # keyboard repeat rate
xsetroot -cursor_name left_ptr
