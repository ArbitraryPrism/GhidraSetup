#!/bin/bash

# Install JDK...
printf "\n\n[+] Installing Java JDK...\n\n"
sudo apt update
sudo apt install openjdk-17-jdk

# Get Ghidra file... Change version if required...
printf "\n\n[+] Getting Ghidra...\n\n"
wget -O ~/Downloads/ghidra.zip https://github.com/NationalSecurityAgency/ghidra/releases/download/Ghidra_10.2.3_build/ghidra_10.2.3_PUBLIC_20230208.zip
FolderName=$(unzip -qql ghidra.zip | head -n1 | awk '{print $4}')
unzip ~/Downloads/ghidra.zip -d ~/

# Update the image...
printf "[+] Getting the icon image...\n\n"
wget -O ~/${FolderName}support/ghidra.png https://github.com/ArbitraryPrism/GhidraSetup/raw/main/ghidra.png

# Set up the desktop file...
printf "\n\n[+] Creating desktop file...\n\n"
mkdir -p ~/.local/share/applications/
wget -O ~/.local/share/applications/ghidra.desktop https://raw.githubusercontent.com/ArbitraryPrism/GhidraSetup/main/ghidra.desktop
chmod +x ~/.local/share/applications/ghidra.desktop

# Now update the .desktop file...
printf "\n\n[+] Updating desktop file...\n\n"
ExecutePath=~/${FolderName}ghidraRun
IconPath=~/${FolderName}support/ghidra.png
GhidraPath=~/${FolderName}
sed -i "s@ExecPath@$ExecutePath@g" ~/.local/share/applications/ghidra.desktop
sed -i "s@IconPath@$IconPath@g" ~/.local/share/applications/ghidra.desktop
sed -i "s@GhidraPath@$GhidraPath@g" ~/.local/share/applications/ghidra.desktop

# Remove the zip file...
printf "\n\n[+] Removing zip file...\n\n"
rm ~/Downloads/ghidra.zip
