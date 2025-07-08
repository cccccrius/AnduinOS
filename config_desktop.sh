#!/bin/bash

myloc=$(dirname "$(realpath $0)")

sudo apt install -y gparted nwipe gnome-terminal

sudo \rm $HOME/Bureau/gparted2.desktop 2> /dev/null
sudo \rm /usr/share/applications/gparted2.desktop 2> /dev/null
sudo tee $HOME/Bureau/gparted2.desktop >/dev/null <<'EOF'
[Desktop Entry]
Version=1.0
Name=ADMIN_Gparted
Comment=Gparted
Exec=gnome-terminal -e "bash -c 'sudo gparted'"
#Exec=ptyxis --standalone --execute "sudo sh -c 'gparted'"
Icon=gparted
Terminal=false
Type=Application
Categories=Application;
EOF

sudo cp $HOME/Bureau/gparted2.desktop /usr/share/applications/gparted2.desktop
sudo chown $USER:$USER $HOME/Bureau/gparted2.desktop
sudo chmod +x $HOME/Bureau/gparted2.desktop
sudo chown root:root /usr/share/applications/gparted2.desktop
sudo chmod +x /usr/share/applications/gparted2.desktop


sudo \rm $HOME/Bureau/nwipe.desktop 2> /dev/null
sudo \rm /usr/share/applications/nwipe.desktop 2> /dev/null
sudo tee $HOME/Bureau/nwipe.desktop >/dev/null <<'EOF'
[Desktop Entry]
Version=1.0
Name=ADMIN_Nwipe
Comment=Nwipe
Exec=gnome-terminal -e "bash -c 'sudo nwipe'"
#Exec=ptyxis --standalone --execute "sudo sh -c 'nwipe'"
Icon=utilities-terminal
Terminal=false
Type=Application
Categories=Application;
EOF

sudo cp $HOME/Bureau/nwipe.desktop /usr/share/applications/nwipe.desktop
sudo chown $USER:$USER $HOME/Bureau/nwipe.desktop
sudo chmod +x $HOME/Bureau/nwipe.desktop
sudo chown root:root /usr/share/applications/nwipe.desktop
sudo chmod +x /usr/share/applications/nwipe.desktop

sudo mkdir /usr/share/icons/my_icons/
value=$(<$myloc/updater.png.txt)
base64 -d <<< "$value" > /tmp/updater.png
sudo mv /tmp/updater.png /usr/share/icons/my_icons/

sudo \rm $HOME/Bureau/mise_a_jour.desktop 2> /dev/null
sudo \rm /usr/share/applications/mise_a_jour.desktop 2> /dev/null
sudo tee $HOME/Bureau/mise_a_jour.desktop >/dev/null <<'EOF'
[Desktop Entry]
Version=1.0
Name=ADMIN_mise_a_jour
Comment=ADMIN_mise_a_jour
Exec=gnome-terminal -e "bash -c 'sudo apt update -y && sudo apt upgrade -y && flatpak update -y'"
#Exec=ptyxis --standalone --execute "sudo sh -c 'apt update -y && apt upgrade -y && flatpak update -y'"
Icon=/usr/share/icons/my_icons/updater.png
Terminal=false
Type=Application
Categories=Application;
EOF

sudo cp $HOME/Bureau/mise_a_jour.desktop /usr/share/applications/mise_a_jour.desktop
sudo chown $USER:$USER $HOME/Bureau/mise_a_jour.desktop
sudo chmod +x $HOME/Bureau/mise_a_jour.desktop
sudo chown root:root /usr/share/applications/mise_a_jour.desktop
sudo chmod +x /usr/share/applications/mise_a_jour.desktop
