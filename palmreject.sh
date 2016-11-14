#!/bin/bash

# configuration. run "xinput list" to see ids for your devices.
touchscreen_device=12
stylus_device=13
disable_timeout=20


last_state=-1
timer=0

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

# code follows. only change this if you know what you are doing.
while [ 1 ]
do
  state=`xinput query-state "$stylus_device" | grep -c "ValuatorClass Mode=Absolute Proximity=In"`

  if [ "$state" -ne "$last_state" ] || [ "$timer" -lt $((disable_timeout+1)) ];then
    if [ "$state" -ne 0 ];then
      echo "Disabling touchscreen, device $touchscreen_device"
      timer=$((disable_timeout+1))
      xinput --disable $touchscreen_device
    elif [ "$timer" -eq $((disable_timeout+1)) ]; then
      timer=0
    elif [ "$timer" -lt "$disable_timeout" ]; then
      timer=$((timer+1))
    else
      echo "Enabling touchscreen, device $touchscreen_device"
      timer=$((disable_timeout+1))
      xinput --enable $touchscreen_device
    fi
  fi
  last_state=$state
  sleep 0.1
done

