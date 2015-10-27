#!/bin/bash

# change the version bellow, check on bay12games.com/dwarves
# this is for 64bit version Fedora

version='40_24'
dependencies=$(printf 'openal-soft.i686 glibc.i686 mesa-libGLU.i686 gtk2.i686 SDL.i686 SDL_image.i686 SDL_ttf.i686 libcanberra-gtk2.i686 gtk2-engines.i686')

if [ -d /home/$USER/Dwarf\ Fortress ]; then 
  mv /home/$USER/Dwarf\ Fortress /home/$USER/Dwarf\ Fortress\ Backup
  echo "Old folder moved to 'Dwarf Fortress Backup'"; else 
  echo "Old folder not found, proceeding  with installation." 
fi 

mkdir dwarffortress_tmp
cd dwarffortress_tmp
echo "Downloading Dwarf Fortress."
wget http://www.bay12games.com/dwarves/df_$(printf $version)_linux.tar.bz2
tar -xvf df_$(printf $version)_linux.tar.bz2
cp df_linux/df df_linux/df.original
cp ../df df_linux/df
cp ../df df_linux/dwarffortress
sed -i '/cd "${DF_DIR}"/c\cd /home/$USER/Dwarf\\ Fortress/' df_linux/dwarffortress
mkdir /home/$USER/Dwarf\ Fortress/
mv df_linux/* /home/$USER/Dwarf\ Fortress/
echo -e "[Desktop Entry]\nName=Dwarves\nExec=/bin/dwarffortress\nType=Application\nTerminal=false" >> /home/$USER/Dwarf\ Fortress/Dwarves.desktop &&
chmod 754 /home/$USER/Dwarf\ Fortress/Dwarves.desktop
ln -s /home/$USER/Dwarf\ Fortress/Dwarves.desktop /home/$USER/.local/share/applications/
cd ../
rm -r dwarffortress_tmp 

echo "It needs root permission for installing the dependencies and moving the launcher into /bin"
sudo mv -f /home/$USER/Dwarf\ Fortress/dwarffortress /bin/
sudo dnf install $dependencies

echo "Everything should be peachy. Have FUN!"
