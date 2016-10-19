#!/bin/bash

# configuration. run "xinput list" to see ids for your devices.
touchscreen_device=12
stylus_device=13

# code. only change this if you know what you are doing.
while [ 1 ]
do
  state=`xinput query-state "$stylus_device" | grep -c "ValuatorClass Mode=Absolute Proximity=In"`

  if [ "$state" -ne 0 ];then
    echo "Disabling touchscreen, device $touchscreen_device"
    xinput --disable $touchscreen_device
  else
    echo "Enabling touchscreen, device $touchscreen_device"
    xinput --enable $touchscreen_device
  fi
  sleep 0.1
done

