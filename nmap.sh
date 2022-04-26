#!/bin/bash
# Author: meepmaster
# Date: 19-04-2022
# Description: Enumeration


# Color variables 
RED="\033[1;31m"
GREEN="\033[1;32m"
NOCOLOR="\033[0m"


# Time

RIGHT_NOW=$(date +"%x %r %z")
TIME_STAMP="Updated $RIGHT_NOW by $USER"

# User root

function user() {
	if [ $(id -u) != "0" ]; then
		echo -e "\n$r[!]$e Please run this script with root user!"
		exit 1
	fi
}

# Internet connection

function connect() {
	ping -c 1 -w 3 google.com > /dev/null 2>&1
	if [ "$?" != 0 ]; then
		echo -e "\n$r[!]$e This script needs an active internet connection!"
		exit 1
	fi
}

# Update Upgrade

function update_upgrade () {
	# System update/upgrade
	echo -e "${GREEN}Starting Update && Upgrade.${NOCOLOR}"
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

# Call the functions

user
connect
update_upgrade

echo $TIME_STAMP
echo