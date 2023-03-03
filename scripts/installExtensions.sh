#! /bin/bash

echo "Installing my extensions, includes AppIndicator and SoundOutputDeviceChooser"
sudo dnf install gnome-shell-extension-appindicator gnome-shell-extension-sound-output-device-chooser xprop -y
notify-send "Installed AppIndicator and SoundOutputDeviceChooser. Re-login and go to Extensions to enable it"
read -rp "Press any key to continue" _