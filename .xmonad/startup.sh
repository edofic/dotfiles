#!/usr/bin/env bash

function restart {
  killall "$1"
  START="$1 $2"
  `$START > /dev/null &`
}

function ensure {
  pgrep $1 || $1 $2 &
}

function set_wallpaper {
  feh --no-fehbg --bg-fill $1
}

mkdir -p /tmp/temp

set_wallpaper ~/.xmonad/wallpaper

# ensure cinnamon-screensaver

restart trayer "--edge top --align right --SetDockType true --SetPartialStrut true  --expand true --width 20 --transparent true --tint 0x191970 --height 12"

ensure nm-applet

# ensure redshift-gtk

xset -dpms # turn off screen sleep
xset r rate 250 30 # keyboard repeat rate
xsetroot -cursor_name left_ptr
