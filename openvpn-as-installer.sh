#!/bin/bash

# Author:	Keith Patton 2014
# Brief:	A BASH script to automatically download
# 		and install OpenVPN Access Server

##################################
red='\033[01;31m'
cyan='\033[01;96m'
green='\033[01;32m'
NC='\033[00m' # No Color

pause()
{
 OLDCONFIG=`stty -g`
 stty -icanon -echo min 1 time 0
 dd count=1 2>/dev/null
 stty $OLDCONFIG
}
#################################


#--------------
# Intro message
#--------------

echo '\n######################################################'
echo ' Running script to automatically download and install'
echo ' OpenVPN Access Server and exctract certs for use.'
echo '######################################################\n'
sleep 2

#-------------------------------
# Download OpenVPN Access Server
#-------------------------------

echo ${cyan}Downloading OpenVPN Access Server v2.0.7${NC}
sleep 2
wget http://swupdate.openvpn.org/as/openvpn-as-2.0.7-Ubuntu13.i386.deb
if [ $? -eq 0 ]
  then
    sleep 1
    echo ${green}[OK]${NC}"\n"
    sleep 2
  else
    echo ${red}[failed]${NC}"\n" 1>&2
fi

#------------------------------
# Install OpenVPN Access Server
#------------------------------

if [ $? -eq 0 ]
then
echo ${cyan}Installing OpenVPN Access Server${NC}
sleep 2
dpkg -i openvpn-as-2.0.7-Ubuntu13.i386.deb
if [ $? -eq 0 ]
  then
    sleep 1
    echo ${green}[OK]${NC}"\n"
    sleep 2
  else
    echo ${red}[failed]${NC}"\n" 1>&2
fi
fi

#------------------------------
# Install OpenVPN Access Server
#------------------------------

if [ $? -eq 0 ]
then
echo ${cyan}Installtion successful - deleting DEB file${NC}
sleep 2
rm -f openvpn-as-2.0.7-Ubuntu13.i386.deb
if [ $? -eq 0 ]
  then
    sleep 1
    echo ${green}[OK]${NC}"\n"
    sleep 2
  else
    echo ${red}[failed]${NC}"\n" 1>&2
fi
fi

#-----------------------------
# Create openvpn user password
#-----------------------------

echo "\n"${cyan}== CREATE A PASSWORD FOR OPENVPN ADMIN ==${NC}"\n"
passwd openvpn
if [ $? -eq 0 ]
  then
    sleep 1
    echo ${green}[OK]${NC}"\n"
    sleep 2
  else
    echo ${red}[failed]${NC}"\n" 1>&2
fi

#-------------------------------------------------------------------------
# Prompt user to visit OpenVPN client interface in order to generate certs
#-------------------------------------------------------------------------

if [ $? -eq 0 ]
then
echo ${red}Please log into the above OpenVPN Client Interface to have certs generated (press ENTER when ready)${NC}
pause $"Press [Enter] once you have visited web interface to exctract certs..."
fi

#-------------------------------------------
# Move to openvpn directory to extract certs
#-------------------------------------------

if [ $? -eq 0 ]
then
echo ${cyan}moving to OpenVPN directory to extract certs${NC}
cd /usr/local/openvpn_as/scripts
if [ $? -eq 0 ]
  then
    sleep 1
    echo ${green}[OK]${NC}"\n"
    sleep 2
  else
    echo ${red}[failed]${NC}"\n" 1>&2
fi
echo ${cyan}Making certs directory${NC}
mkdir ./certs
if [ $? -eq 0 ]
  then
    sleep 1
    echo ${green}[OK]${NC}"\n"
    sleep 2
  else
    echo ${red}[failed]${NC}"\n" 1>&2
fi
fi

#------------------------------------------------------------------
# Extract the certs once the user has visited the OpenVPN interface
#------------------------------------------------------------------

echo ${cyan}Extracting certs...${NC}
sh sacli -a openvpn -o certs --cn openvpn get5
if [ $? -eq 0 ]
then
sleep 1
echo ${green}[OK]${NC}
sleep 2
echo Certs saved in /usr/local/openvpn_as/scripts/certs
sleep 2
echo ${green}[SCRIPT COMPLETED]${NC}
else
echo ${red}[failed]${NC}
fi
