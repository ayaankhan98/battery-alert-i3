#! /bin/bash

echo "Setting up dirs"
mkdir -p $HOME/.config/systemd/user/
mkdir -p /usr/local/bin/battery-alert

echo "Copying service and timers"
cp ./battery-alert.service ~/.config/systemd/user/battery-alert.service
cp ./battery-alert.timer ~/.config/systemd/user/battery-alert.timer

echo "Copying alert script"
cp ./battery-alert.sh /usr/local/bin/battery-alert/battery-alert.sh
echo "Copying notification sound"
cp ./low-battery.wav /usr/local/bin/battery-alert/low-battery.wav
cp ./full-battery.wav /usr/local/bin/battery-alert/full-battery.wav

echo "Enabling services"
systemctl --user daemon-reload
systemctl --user start battery-alert.service

systemctl --user start battery-alert.timer
systemctl --user enable battery-alert.timer

echo "exiting..."
