#!/bin/sh

echo "Updating"
sudo dnf update -y


echo "Enabling RPM Fusion"
sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

echo "Enabling Flatpak"
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak update

sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'

echo "Updating once again..."
sudo dnf update -y

###
# Install base packages and applications
###

echo "Installing Software"
sudo dnf install -y gnome-extensions-app gnome-tweaks neofetch git gnome-shell-extension-dash-to-dock gnome-tweaks htop mpv telegram-desktop virt-manager yt-dlp vim akmod-nvidia xorg-x11-drv-nvidia-cuda code steam

echo "Installing google chrome"
sudo dnf config-manager --set-enabled google-chrome
sudo dnf install -y google-chrome-stable

# Virtual Machines
sudo systemctl enable --now libvirtd

echo "Installing flatpak Discord"
flatpak install -y discord


#Recovering maximize, minimize buttons
gsettings set org.gnome.desktop.wm.preferences button-layout ":minimize,maximize,close"

#The user needs to reboot to apply all changes.
echo "Please Reboot to apply all changes" && exit 0
