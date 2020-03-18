#!/bin/sh

#requires amd driver from xf86-video-amdgpu
#unless you replace amd-xorg.conf 
#with modeset.xorg.conf on the line below.

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

echo 'Removing nvidia prime setup......'

rm -rf /etc/X11/xorg.conf.d/99-nvidia.conf
rm -rf /etc/modprobe.d/99-nvidia.conf
rm -rf /etc/modules-load.d/99-nvidia.conf
rm -rf /usr/local/bin/optimus.sh

sleep 1
echo 'Setting amd only mode.......'
cp /etc/switch/amd/amd-xorg.conf /etc/X11/xorg.conf.d/99-amd.conf
cp /etc/switch/amd/amd-modprobe.conf /etc/modprobe.d/99-amd.conf
cp /etc/switch/amd/no-optimus.sh /usr/local/bin/optimus.sh
sleep 1

echo 'enabling disable-nvidia.service'
systemctl -q enable disable-nvidia.service
sleep 1
echo 'Done! After reboot you will be using amd only mode with the nvidia gpu disabled.'

