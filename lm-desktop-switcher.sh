#!/bin/bash

# Function to display a dialog window for desktop selection
show_desktop_selection_dialog() {
    choice=$(dialog --clear --title "Desktop Environment Selection" \
        --menu "Please select the desktop environment you want to install:" 15 40 8 \
        1 "Gnome" \
        2 "KDE" \
        3 "Xfce" \
        4 "MATE" \
        5 "Cinnamon" \
        6 "i3" \
        7 "awesome" \
        8 "dwm" \
        2>&1 >/dev/tty)
    
    case $choice in
        1) desktop="gnome" ;;
        2) desktop="kde" ;;
        3) desktop="xfce" ;;
        4) desktop="mate" ;;
        5) desktop="cinnamon" ;;
        6) desktop="i3" ;;
        7) desktop="awesome" ;;
        8) desktop="dwm" ;;
        *) echo "Cancelled."; exit 1 ;;
    esac
}

# Function to perform the desktop environment installation
install_desktop_environment() {
    # Remove the previous desktop environment (if exists)
    if [ -x "$(command -v tasksel)" ]; then
        sudo tasksel remove desktop
    else
        sudo apt-get purge --auto-remove '^cinnamon-desktop-environment$' \
                             '^mate-desktop-environment$' \
                             '^xfce4$' \
                             '^xfce4-.*-plugin$' \
                             'libxfce4.*'
    fi

    # Install the chosen desktop environment
    case $desktop in
        gnome) sudo apt-get install gnome ;;
        kde) sudo apt-get install kde-full ;;
        xfce) sudo apt-get install xfce4 ;;
        mate) sudo apt-get install mate-desktop-environment ;;
        cinnamon) sudo apt-get install cinnamon ;;
        i3) sudo apt-get install i3 ;;
        awesome) sudo apt-get install awesome ;;
        dwm) sudo apt-get install dwm ;;
    esac
}

# Main workflow
main() {
    # Check if the 'dialog' package is installed
    if [ ! -x "$(command -v dialog)" ]; then
        echo "Install dialog package. Howto: sudo apt-get install dialog"
        exit 1
    fi

    # Show the dialog window for desktop selection
    show_desktop_selection_dialog

    # Install the chosen desktop environment
    install_desktop_environment

    echo "Desktop environment installation completed. Please restart the system."
}

# Call the main workflow
main
