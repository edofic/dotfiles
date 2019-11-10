#!/usr/bin/env bash

function restart {
  pkill "$1"
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

ensure xscreensaver -no-splash

# workaround for taffybar dbus bug
DBUS_SESSION_BUS_ADDRESS=$(echo $DBUS_SESSION_BUS_ADDRESS | grep -Eo "^[^,]+") restart taffybar

restart nm-applet

ensure volumeicon

ensure clipit

ensure blueman-applet

ensure gpg-agent "--daemon --pinentry-program $(which pinentry)"

xset -dpms # turn off screen sleep
xset r rate 250 30 # keyboard repeat rate
xsetroot -cursor_name left_ptr
