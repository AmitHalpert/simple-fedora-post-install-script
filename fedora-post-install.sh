#! /bin/bash
# ./fedora-post-install.sh

HEIGHT=25
WIDTH=100
CHOICE_HEIGHT=4
BACKTITLE="Fedora post-install script by AmitHalpert"
MENU_MSG="Please select one of following options:"

# Check for updates
sudo dnf upgrade --refresh
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
    3 "Reboot"
    4 "Quit"
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
            sudo systemctl reboot
        ;;

        4) 
            echo "Please Reboot to apply all changes" && exit 0
        ;;

    esac
done
