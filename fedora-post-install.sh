#!/bin/sh

echo "Intial dnf and firmware updates"
sudo dnf upgrade --refresh -y
sudo dnf check
sudo dnf autoremove -y
sudo fwupdmgr get-devices
sudo fwupdmgr refresh --force
sudo fwupdmgr get-updates
sudo fwupdmgr update -y \


#I added some flags to the dnf conf file to speed it up
echo 'fastestmirror=1' | sudo tee -a /etc/dnf/dnf.conf \
echo 'max_parallel_downloads=10' | sudo tee -a /etc/dnf/dnf.conf \
echo 'deltarpm=true' | sudo tee -a /etc/dnf/dnf.conf \
cat /etc/dnf/dnf.conf \



echo "Adding additional rpmfusion free & nonfree repos"
sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-"$(rpm -E %fedora)".noarch.rpm -y
sudo dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-"$(rpm -E %fedora)".noarch.rpm -y

sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
sudo dnf update -y

echo "Installing flatpak (needed for certain shitware)"
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo -y

echo "Updating dnf repos once again..."
sudo dnf upgrade --refresh -y

#Enable the Google Chrome repo
sudo dnf install fedora-workstation-repositories
sudo dnf config-manager --set-enabled google-chrome -y

sudo dnf install -y \
neofetch \
git `#VCS done right` \
google-chrome-stable \ 
gnome-shell-extension-dash-to-dock `#dash for gnome` \
gnome-tweaks `#Your central place to make gnome like you want` \
htop `#Cli process monitor` \
mpv `#The best media player (with simple gui)` \
telegram-desktop `#Chatting, with newer openssl and qt base!` \
virt-manager `#A gui to manage virtual machines` \
yt-dlp `#Allows you to download and save youtube videos but also to open their links by dragging them into mpv!` \
vim `#the better vim` \
akmod-nvidia `#install nvidia driver` \
xorg-x11-drv-nvidia-cuda \
code \
google-chrome-stable \

#Install flatpak Discord because RPMF Discord not working right now :(
flatpak install flathub com.discordapp.Discord

#Recovering maximize, minimize buttons
gsettings set org.gnome.desktop.wm.preferences button-layout ":minimize,maximize,close"



#The user needs to reboot to apply all changes.
echo "Please Reboot" && exit 0
