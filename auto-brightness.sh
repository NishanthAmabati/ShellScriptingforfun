# Developed a shell script to dynamically adjust screen brightness based on the time of day.

# # version : 1.0 | date : April 12th, 2024

#!/usr/bin/bash

# max: 5000, min: 3000

sudo su
brightnessfile="/sys/class/backlight/intel_backlight/brightness"
currentbrightness="$(cat $brightnessfile)"

pm () {
        if [[ $currentbrightness -gt 3000 ]]; then
                for (( i=$currentbrightness; i>=3000; i-=300 )); do
                        echo $i > /sys/class/backlight/intel_backlight/brightness
                        sleep 0.5 
                done
        fi
}

am () {
        if [[ $currentbrightness -lt 3000 ]]; then
                for (( i=$currentbrightness; i<=5000; i+=300 )); do
                        echo $i > /sys/class/backlight/intel_backlight/brightness
                        sleep 0.5 
                done
        fi
}

# check AM or PM and call 
if [[ $(date +%p) == "AM" ]]; then am; else pm; fi
