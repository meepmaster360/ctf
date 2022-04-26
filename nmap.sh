#!/bin/bash
# Author: meepmaster
# Date: 19-04-2022
# Description: Enumeration


# Color variables 

RED="\033[1;31m"
GREEN="\033[1;32m"
NOCOLOR="\033[0m"

# Colors 2 variables

r='\e[1;31m'
g='\e[1;32m'
y='\e[1;33m'
b='\e[1;34m'
c='\e[1;36m'
w='\e[0;38m'
e='\e[0m'


# Time variable

RIGHT_NOW=$(date +"%x %r %z")
TIME_STAMP="Updated $RIGHT_NOW by $USER"

# User root check

function user() {
	if [ $(id -u) != "0" ];then
		echo -e "\n$r[!]$e Please run this script with root user!"
		exit 1
	fi
}

# Internet connection check

function connect() {
	ping -c 1 -w 3 google.com > /dev/null 2>&1
	if [ "$?" != 0 ];then
		echo -e "\n$r[!]$e This script needs an active internet connection!"
		exit 1
	fi
}

# Update Upgrade Cleaning

function update_upgrade () {
	# System update/upgrade
	echo -e "${GREEN}Starting Update && Upgrade.${NOCOLOR}";sleep 1
	echo
	sudo dpkg --configure -a
	sudo apt-get install -f
	sudo apt update --fix-missing
	sudo apt-get upgrade -y
	sudo apt full-upgrade -y
	sudo apt-get dist-upgrade -y
	echo
	echo -e "${GREEN}Update and Upgrade finished.${NOCOLOR}";sleep 1

	# System cleaning
	echo -e "${GREEN}Starting Cleaning.${NOCOLOR}";sleep 1
	echo
	sudo apt-get --purge autoremove
	sudo apt-get autoclean
	sudo apt-get clean
	echo
	echo -e "${GREEN}Cleaning finished.${NOCOLOR}";sleep 1
	echo
	echo -e "${GREEN}Be light, be Yourself...${NOCOLOR}"
    echo
    echo
}

# IP

function IP () {
	IP_SISTEMA=`hostname -I`
	echo -e "\n$g[!]$e Your IP is: $IP_SISTEMA"
}

function app_install () {

# Nmap installation	

	if [ ! -x "$(command -v nmap)" ];then
        echo "[+] nmap not detected...Installing"
        sudo apt-get install nmap -y > installing;rm installing
else
    echo "[+] nmap detected"
     
fi

# Nikto installation

if [ ! -x "$(command -v nikto)" ];then
        echo "[+] nikto not detected...Installing"
        sudo apt-get install nikto -y > installing;rm installing
else
    echo "[+] nikto detected"
     
fi

# Dirbuster installation

if [ ! -x "$(command -v dirbuster)" ];then
        echo "[+] dirbuster not detected...Installing"
        sudo apt-get install dirbuster -y > installing;rm installing
else
    echo "[+] dirbuster detected"
     
fi
echo
sleep 2

}


# Call the functions

user
connect
app_install
update_upgrade
IP

echo
echo -e "\n$b[!]$e $TIME_STAMP"
echo
echo
