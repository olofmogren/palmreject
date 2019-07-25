#!/bin/bash

# Bash shell script for palm rejection with stylus pens in Linux or similar systems with xinput and bash
# Copyright (C) 2017  Olof Mogren <olof@mogren.one>

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# configuration. run "xinput list" to see your devices.
touchscreen_device_name='N-trig DuoSense' # e.g.'FTSC'
stylus_device_name='N-trig DuoSense'      # e.g. 'Wacom'
stylus_device_specifier='Pen'
enable_timeout=10 # 10 = 2 seconds
verbose=false     # true to print disable/enable ops

# code follows. only change this if you know what you are doing.
device_type='pointer'

# find out device ids from xinput:
touchscreen_device=$(xinput --list | grep "$touchscreen_device_name" | grep "$device_type" | grep -v "$stylus_device_specifier" | grep -Po '(?<=id\=)[0-9]+')

stylus_device=""

#loop to find the stylus (some does not appear until used)
echo "Waiting to find the stylus..."
while [ -z "$stylus_device" ]; do
  stylus_device=$(xinput --list | grep "$stylus_device_name" | grep "$device_type" | grep "$stylus_device_specifier" | grep -Po '(?<=id\=)[0-9]+')
  sleep 2
done
echo "Found stylus with ID'='$stylus_device"

last_state=-1
timer=0

# main loop:
while [ 1 ]; do
  state=$(xinput query-state "$stylus_device" | grep -c "ValuatorClass Mode=Absolute Proximity=In")

  if [ "$state" -ne "$last_state" ] || [ "$timer" -lt $((enable_timeout + 1)) ]; then
    if [ "$state" -ne 0 ]; then
      if [ "$verbose" = true ]; then
        echo "Disabling touchscreen, device $touchscreen_device"
      fi
      timer=$((enable_timeout + 1))
      xinput --disable $touchscreen_device
    elif [ "$timer" -eq $((enable_timeout + 1)) ]; then
      timer=0
    elif [ "$timer" -lt "$enable_timeout" ]; then
      timer=$((timer + 1))
    else
      if [ "$verbose" = true ]; then
        echo "Enabling touchscreen, device $touchscreen_device"
      fi
      timer=$((enable_timeout + 1))
      xinput --enable $touchscreen_device
    fi
  fi
  last_state=$state
  sleep 0.1
done
