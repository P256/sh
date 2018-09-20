#
# https://www.softether-download.com/files/softether/v4.25-9656-rtm-2018.01.15-tree/Windows/SoftEther_VPN_Client/softether-vpnclient-v4.25-9656-rtm-2018.01.15-windows-x86_x64-intel.exe
#
yum -y install gcc zlib-devel openssl-devel readline-devel ncurses-devel

#
curl -O https://github.com/SoftEtherVPN/SoftEtherVPN_Stable/archive/v4.25-9656-rtm.tar.gz

#
curl -O https://www.softether-download.com/files/softether/v4.25-9656-rtm-2018.01.15-tree/Source_Code/softether-src-v4.25-9656-rtm.tar.gz
#
./configure
#
make
make install
