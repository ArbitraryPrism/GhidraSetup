#!/bin/bash

# Install JDK...
printf "\n\n[+] Installing Java JDK...\n\n"
sudo apt update
sudo apt install openjdk-17-jdk

# Get Ghidra file... Change version if required...
printf "\n\n[+] Getting Ghidra...\n\n"
wget -O ~/ghidra.zip https://github.com/NationalSecurityAgency/ghidra/releases/download/Ghidra_10.2.2_build/ghidra_10.2.2_PUBLIC_20221115.zip
FolderName=$(unzip -qql ghidra.zip | head -n1 | awk '{print $4}')
unzip ~/ghidra.zip

# Update the image...
printf "[+] Getting the icon image...\n\n"
wget -O ~/$FolderName/support/ghidra.png https://github.com/ArbitraryPrism/GhidraSetup/raw/main/ghidra.png

# Set up the desktop file...
printf "\n\n[+] Creating desktop file...\n\n"
mkdir -p ~/.local/share/applications/
wget -O ~/.local/share/applications/ghidra.desktop https://raw.githubusercontent.com/ArbitraryPrism/GhidraSetup/main/ghidra.desktop
chmod +x ~/.local/share/applications/ghidra.desktop

# Now update the .desktop file...
printf "\n\n[+] Updating desktop file...\n\n"
ExecutePath=~/${FolderName}ghidraRun
IconPath=~/${FolderName}support/ghidra.png
sed -i "s@ExecPath@$ExecutePath@g" ~/.local/share/applications/ghidra.desktop
sed -i "s@IconPath@$IconPath@g" ~/.local/share/applications/ghidra.desktop

# Remove the zip file...
printf "\n\n[+] Removing zip file...\n\n"
rm ~/ghidra.zip
