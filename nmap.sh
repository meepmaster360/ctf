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

function hydra() {
clear
echo "******************************"
echo Welcome to Nmap-Hydra Script :
echo "******************************"
echo
echo -n "Enter the Network you want to scan (Ex. 10.0.0.1/8,10.0.0.1-200): "
read v1
echo -n "Enter Service name (Ex: ftp or ssh or http-get or http-form-post ): "
read v5
echo -n "Enter Port you want to scan (Ex. 21 OR 22 OR 80 etc.): "
read v2
echo -n  "Enter File name in which your targets IP will be copied (for default file i.e. nmaphydrafile.txt press 'd'): "
read v
if [ $v == d ]
then
	var=nmaphydrafile.txt
else var=$v
fi
echo
echo Be Patient !!! We are scanning live hosts for your network ...
nmap -p $v2 -oG nmaphydrafile1 $v1 > /dev/null
cat nmaphydrafile1 | grep $v2/open | awk '{print $2}' >$var
rm nmaphydrafile1
echo -n "Do you want to use (D)efault username-wordlist or enter (M)anually : "
read v10;
if [ $v10 == D -o $v10 == d ]
then
	v3=usernames.txt

else
 echo -n Enter location of usernames wordlist :
 read v3
fi
echo -n "Do you want to use (D)efault password-wordlist or enter (M)anually : "
read v11;
if [ $v11 == D -o $v11 == d ]
then
	v4=pass.txt
else
 echo -n Enter location of password wordlist :
 read v4
fi
echo -n "Enter File name where cracked username passwords will be saved (for default file i.e. nmaphydrafile2.txt press 'd'): "
read v7
if [ $v7 == d ]
then
	var2=nmaphydrafile2.txt
else var2=$v7
fi


clear
echo Your command is ready : 
echo
echo "hydra -L $v3 -P $v4 -s $v2 -o $var2 -M $var $v5 "
echo
echo -n "Do you want to continue (y/n) ?"
read v6
clear
if [ $v6 == y -o $v6 == Y ]
then
hydra -L $v3 -P $v4 -s $v2 -o $var2 -M $var $v5
else 
	echo -n Press q to exit or r to continue :
	read v6
	if [ $v6 == q -o $v6 == Q ]
	then
	exit
else func
fi
fi
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

sleep 5
# Hydra not activated, remove hashtag to activate function hydra
# hydra