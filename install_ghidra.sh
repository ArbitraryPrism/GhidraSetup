#!/bin/bash

# Install JDK...
printf "\n\n[+] Installing OpenJDK...\n\n"
sudo apt update
sudo apt install openjdk-21-jdk -y

# Get Ghidra file... 
printf "\n\n[+] Getting Ghidra...\n\n"
Latest_Ghidra_Version=$(wget https://github.com/NationalSecurityAgency/ghidra/releases/latest 2>&1 | grep Location: | grep -Eo 'https://[^ >]+' | head -1 | awk -F/  '{print $NF}')
Latest_Ghidra=$(wget -qO- https://github.com/NationalSecurityAgency/ghidra/releases/expanded_assets/$Latest_Ghidra_Version 2>&1 | grep -Eo 'ghidra_.*zip')
wget -O ~/Downloads/ghidra.zip https://github.com/NationalSecurityAgency/ghidra/releases/download/$Latest_Ghidra_Version/$Latest_Ghidra
mkdir ~/Applications
# FolderName=$(unzip -qql ~/Downloads/ghidra.zip | head -n1 | awk '{print $4}')
FolderName=Ghidra
unzip ~/Downloads/ghidra.zip -d ~/Applications
mv ~/Applications/$(unzip -qql ~/Downloads/ghidra.zip | head -n1 | awk '{print $4}') Ghidra

# Update the image...
printf "[+] Getting the icon image...\n\n"
wget -O ~/Applications/${FolderName}/support/ghidra.png https://github.com/ArbitraryPrism/GhidraSetup/raw/main/ghidra.png

# Set up the desktop file...
printf "\n\n[+] Creating desktop file...\n\n"
mkdir -p ~/.local/share/applications/
wget -O ~/.local/share/applications/ghidra.desktop https://raw.githubusercontent.com/ArbitraryPrism/GhidraSetup/main/ghidra.desktop
chmod +x ~/.local/share/applications/ghidra.desktop

# Now update the .desktop file...
printf "\n\n[+] Updating desktop file...\n\n"
ExecutePath=~/Applications/${FolderName}/ghidraRun
IconPath=~/Applications/${FolderName}/support/ghidra.png
GhidraPath=~/Applications/${FolderName}/
sed -i "s@ExecPath@$ExecutePath@g" ~/.local/share/applications/ghidra.desktop
sed -i "s@IconPath@$IconPath@g" ~/.local/share/applications/ghidra.desktop
sed -i "s@GhidraPath@$GhidraPath@g" ~/.local/share/applications/ghidra.desktop

# Remove the zip file...
printf "\n\n[+] Removing zip file...\n\n"
rm ~/Downloads/ghidra.zip
