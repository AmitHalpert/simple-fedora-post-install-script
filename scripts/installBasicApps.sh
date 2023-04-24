#! /bin/bash
# ./scripts/installBasicApps.sh


echo -e "The script will install the following packages: \n gnome-extensions-app clang gnome-tweaks neofetch git gnome-shell-extension-dash-to-dock gnome-tweaks htop mpv \n telegram-desktop virt-manager yt-dlp neovim code steam discord npm java-11-openjdk-devel.x86_64"
while true; do
    read -rp "do you want to install all the packages above? [y/N]: " yn
    
    case $yn in
    [Yy]*) 
        echo "Installing basic apps"

        # ENABLE REPOS
        echo "Enabling RPM Fusion"
        sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

        echo "Enabling Flatpak"
        flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
        flatpak update
        
        sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
        sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'

        echo "Updating once again..."
        sudo dnf update -y
        
        # Enable Google Chrome repository
        sudo dnf config-manager --set-enabled google-chrome
        sudo dnf makecache

        ###
        # Install base applications
        ###
        sudo dnf install google-chrome-stable gnome-extensions-app clang gnome-tweaks neofetch gnome-shell-extension-dash-to-dock gnome-tweaks htop mpv telegram-desktop virt-manager yt-dlp vim code steam discord npm java-11-openjdk-devel.x86_64 -y

        # Set text editor
        git config --global core.editor "vim"

        sudo systemctl enable --now libvirtd

        break
    ;; 

    *) 
        echo "Aborted"
        break
    ;;
    esac
done

read -rp "Press any key to continue" _
