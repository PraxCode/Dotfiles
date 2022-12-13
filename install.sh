#!/bin/bash

AUR_HELPER=paru
PAC_PKGS=""
AUR_PKGS=""

# Read the list of packages from a file (one package per line)
while read -r pkg; do
  # check if pkg is available in pacman repository
  if pacman -Ss $pkg > /dev/null; then
      PAC_PKGS="$PAC_PKGS $pkg"
    else
      AUR_PKGS="$AUR_PKGS $pkg"
  fi
done < packages.txt

# Install the pacman packages
if [ -n "$PAC_PKGS" ]; then
  #sudo pacman -S $PAC_PKGS
  echo "Pacman"
fi

# Install the AUR packages (assuming you are using an AUR helper like yay)
if [ -n "$AUR_PKGS" ]; then
  #$AUR_HELPER -S $AUR_PKGS
  echo "AUR"
fi

# Install LunarVim Nightly
#bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh)

# Install Rustup
# curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh


# Create symlinks from config dir to $HOME/.config
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
CONFIG_DIR="$SCRIPT_DIR/config"

for dir in "$CONFIG_DIR"/*/; do
  if [ -d "$HOME/.config/${dir}" ]; then
    mv "$HOME/.config/${dir}" "$HOME/.config/${dir}.old" # Rename existing config files
  fi
  ln -s "$dir" "$HOME/.config/"
done

# Make Fish default shell
#chsh -s $(which fish)

# Prompt the user to confirm the reboot
read -p "Do you want to reboot the system (y/n)? [y] " response

# Set the default response to "y" if no response was entered
if [ -z "$response" ]; then
  response="y"
fi

# Check the user's response
if [ "$response" = "y" ]; then
  # Reboot the system
  reboot
else
  # Do not reboot the system
  echo "Reboot cancelled"
fi

