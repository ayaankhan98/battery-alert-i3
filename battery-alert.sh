#! /bin/bash

battery_files="/sys/class/power_supply/BAT1"
battery_status=$(cat "${battery_files}/status")
capacity=$(cat "${battery_files}/capacity")

#echo "${capacity}"

# if battery is discharging and capacity is less than 15% show an alert
if [[ "${battery_status}"=="Discharging" && ${capacity} -le 15 ]];
then
  echo "Battery Alert - ${capacity}%"
  notify-send \
    "Low Battery"\
    "Remaning - ${capacity}%"
  canberra-gtk-play -f "/usr/local/bin/battery-alert/low-battery.wav"
elif [[ "${battery_status}"=="Charging" && ${capacity} -eq 100 ]];
then
  echo "Battery Full - ${capacity}%"
  notify-send \
    "Full Charged - ${capacity}%"\
    "Remove Charging Adapter"
  canberra-gtk-play -f "/usr/local/bin/battery-alert/full-battery.wav"
fi
