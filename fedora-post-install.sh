#! /bin/bash
# ./fedora-post-install.sh

HEIGHT=25
WIDTH=100
CHOICE_HEIGHT=4
BACKTITLE="Fedora post-install script by AmitHalpert"
MENU_MSG="Please select one of following options:"

# Enable minimize and maximize buttons
gsettings set org.gnome.desktop.wm.preferences button-layout ":minimize,maximize,close"


# Check for updates
sudo dnf update -y
sudo dnf autoremove -y
sudo fwupdmgr get-devices
sudo fwupdmgr refresh --force
sudo fwupdmgr get-updates
sudo fwupdmgr update -y

# Install some tools required by the script
sudo dnf install axel deltarpm unzip -y

# Check if we have dialog installed
# If not, install it
if [ "$(rpm -q dialog 2>/dev/null | grep -c "is not installed")" -eq 1 ]; 
then
    sudo dnf install -y dialog
fi

OPTIONS=(
    1 "Install basic apps"
    2 "install WhiteSur-Dark Theme"
    3 "install Extensions"
    4 "install Codecs"
    5 "Reboot"
    6 "Quit"
)

while true; do
    CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE - Main menu $(lscpu | grep -i "Model name:" | cut -d':' -f2- - )" \
                --title "$TITLE" \
                --nocancel \
                --menu "$MENU_MSG" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)
    clear
    case $CHOICE in 
        1) 
            scripts/installBasicApps.sh
        ;;
       
        2) 
            scripts/installWhiteSurDarkTheme.sh
        ;;

        3) 
            scripts/installExtensions.sh
        ;;

        4) 
            scripts/installCodecs.sh
        ;;

        5)
            sudo systemctl reboot
        ;;

        6) 
            RED='\033[0;31m'
            NC='\033[0m'
            echo -e "${RED}Please Reboot to apply all changes${NC}" && exit 0
        ;;

    esac
done
