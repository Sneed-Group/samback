#!/bin/bash

# Neat splash.
echo ""                                            
echo "  mmmm                mmmmm                m     "
echo " mm      mmm    mmm   m    m  mmm    mmm   m   m "
echo " mmmmm  m   m  m m m  mmmmm  m   m  m   m  m mm  "
echo "     mm mmmmm  m m m  m    m mmmmm  m      mmm   "
echo " mmmmm      m  m m m  mmmmmm     m   mmmm  m  mm "
echo "          THE Simple Cloning Automated Tool, MAN!"
echo "                                 Version 2.2024a"

# Get the currently booted HDD
root_device=$(df / | grep -Eo '^/dev/[^[:space:]]+')

# Extract the HDD from the root device
booted_hdd=$(echo "$root_device" | sed 's/[0-9]*$//' | sed 's/\/dev\///g')

# Find first other connected HDD of same size
other_hdd=$(lsblk -o NAME,SIZE -d | grep "$(lsblk -o SIZE -n /dev/$booted_hdd | head -n 1)"| grep -v "$booted_hdd" | awk '{print $1}' | head -n 1)

echo "<SAMBACK> [MSG]: Currently booted HDD (from): $booted_hdd"
echo "<SAMBACK> [MSG]: Same size HDD that is NOT the currently booted device (to): $other_hdd"

if [ ! "$other_hdd" == "" ]; then

# Here we pretend to clone our boot drive to our other drive
echo "<SAMBACK> [MSG]: Cloning booted /dev/$booted_hdd to /dev/$other_hdd... (This may take awhile, will run in background)"
else
echo "<SAMBACK> [ERR]: No drive of same size as boot device found!"
exit 1
fi

echo "This has been a dry run of SamBack."