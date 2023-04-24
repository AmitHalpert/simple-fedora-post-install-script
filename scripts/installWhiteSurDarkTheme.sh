#! /bin/bash
# ./scripts/installWhiteSurDarkTheme.sh
while true; do
    read -rp "do you want to install all the packages above? [y/N]: " yn
    
    case $yn in
    [Yy]*) 
        echo "Installing WhiteSur-Dark theme"
        
        
        TMPDIR=$(mktemp -d)
        git clone https://github.com/vinceliuice/WhiteSur-gtk-theme $TMPDIR && $TMPDIR/install.sh
        gsettings set org.gnome.desktop.interface gtk-theme 'WhiteSur-Dark' 
        gsettings set org.gnome.desktop.wm.preferences theme 'WhiteSur-Dark'
        notify-send "Installed WhiteSur-Dark theme"
        read -rp "Press any key to continue" _
        
        break
    ;; 

    *) 
        echo "Aborted"
        break
    ;;
    esac
done

read -rp "Press any key to continue" _
