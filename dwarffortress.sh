#!/bin/bash

# BEFORE RUNNING THIS SCRIPT CHECK THE GAME VERSION IN bay12games.com/dwarves
# AND CHANGE IT BELLOW ACCORDINGLY.

# this script will download and 'install' dwarffortress for Fedora
# it will change some files to search in data/art for .bmp instead of .png
# the install location will be /home/$USER in a folder called 'Dwarf Fortress'
# it will move any existing 'Dwarf Fortress' folder to 'Dwarf Fortress Backup'
# it will create a script to launch dwarffortress in /bin/dwarffortress

version='40_24'
dependencies=$(printf 'openal-soft.i686 glibc.i686 mesa-libGLU.i686 gtk2.i686 SDL.i686 SDL_image.i686 SDL_ttf.i686 libcanberra-gtk2.i686 gtk2-engines.i686')

if [ -d /home/$USER/Dwarf\ Fortress ]; then 
  mv /home/$USER/Dwarf\ Fortress /home/$USER/Dwarf\ Fortress\ Backup && 
  echo "Old folder moved to 'Dwarf Fortress Backup'"; else 
  echo "Old folder not found, procceding with installation." 
fi 

mkdir dwarffortress_tmp
cd dwarffortress_tmp &&
echo "Downloading Dwarf Fortress."
wget http://www.bay12games.com/dwarves/df_$(printf $version)_linux.tar.bz2 &&
tar -xvf df_$(printf $version)_linux.tar.bz2 &&
cp df_linux/df df_linux/dwarffortress
chmod 754 df_linux/dwarffortress
sed -i '/cd "${DF_DIR}"/c\cd /home/$USER/Dwarf\\ Fortress/' df_linux/dwarffortress
sed -i -e 's/png/bmp/g' df_linux/data/init/init.txt
sed -i -e 's/mouse.png/mouse.bmp/g' df_linux/libs/Dwarf_Fortress
mkdir /home/$USER/Dwarf\ Fortress/ &&
mv df_linux/* /home/$USER/Dwarf\ Fortress/ &&
cd ../
rm -r dwarffortress_tmp

echo "Everything moved. Installing dependencies now."
echo "It needs root permission for installing the dependencies and moving the launcher into /bin"
sudo mv /home/$USER/Dwarf\ Fortress/df_linux/dwarffortress /bin/
sudo dnf install $dependencies

echo "Everything should be peachy. Have FUN!"
