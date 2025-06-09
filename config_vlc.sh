#!/bin/bash

myloc=$(dirname "$(realpath $0)")

sudo apt install -y vlc vlc-l10n

sudo mkdir /usr/share/icons/my_icons/
value=$(<$myloc/vlc.png.txt)
base64 -d <<< "$value" > /tmp/vlc.png
sudo mv /tmp/vlc.png /usr/share/icons/my_icons/

sudo sed -i 's|Icon=.*|Icon=/usr/share/icons/my_icons/vlc.png|' /usr/share/applications/vlc.desktop
