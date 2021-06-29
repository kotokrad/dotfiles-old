#!/bin/sh

# System tray
if [ -z "$(pgrep trayer)" ] ; then
    trayer --edge top \
           --align right \
           --widthtype request \
           --distancefrom top \
           --distance 1 \
           --height 16 \
           --alpha 0 \
           --transparent true \
           --iconspacing 1 \
           --expand true \
           --tint 0x282c34 &
           # --width 6 \
fi

# Power manager
if [ -z "$(pgrep xfce4-power-manager)" ] ; then
    xfce4-power-manager &
fi

# Taffybar
# if [ -z "$(pgrep taffybar)" ] ; then
#     taffybar &
# fi

# Redshift
if [ -z "$(pgrep redshift-gtk)" ] ; then
    redshift-gtk &
fi

# Telegram
if [ -z "$(pgrep Telegram)" ] ; then
    ~/.telegram/Telegram &
fi

# Autolock
# if [ -z "$(pgrep xautolock)" ] ; then
    # xautolock -time 1 -locker "if ! grep 'RUNNING' /proc/asound/card*/pcm*/sub*/status;then xscreensaver-command -lock; else echo 'Sound on'; fi"
# fi

# Wallpaper
if [ -z "$(pgrep nitrogen)" ] ; then
    nitrogen --restore &
fi

# Screensaver
# if [ -z "$(pgrep xscreensaver)" ] ; then
#     xscreensaver -no-splash &
# fi

# compton
if [ -z "$(pgrep compton)" ] ; then
    compton -b &
fi

# Network Applet
if [ -z "$(pgrep nm-applet)" ] ; then
    nm-applet &
fi

# # Google Drive
# if [ -z "$(pgrep insync)" ] ; then
#     insync start &
# fi
# xbindkeys

xset r rate 250 50
setxkbmap -layout us,ru -option 'grp:ctrl_shift_toggle'
