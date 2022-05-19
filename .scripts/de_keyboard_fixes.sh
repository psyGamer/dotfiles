#!/bin/sh

### This scripts "fixes" a few isses when using a german keyboard.

# Set german keyboard layout
setxkbmap de

## Comment out the following lines if you don't want to use those changes

# Use CapsLock as AltGr
xmodmap -e "keycode 66 = ISO_Level3_Shift"
# Use ScrollLock as CapsLock
xmodmap -e "keycode 78 = Caps_Lock"
