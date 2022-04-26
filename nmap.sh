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
# Hydra installation

if [ ! -x "$(command -v hydra)" ];then
        echo "[+] hydra not detected...Installing"
        sudo apt-get install hydra -y > installing;rm installing
else
    echo "[+] hydra detected"
     
fi
# Medusa installation

if [ ! -x "$(command -v medusa)" ];then
        echo "[+] medusa not detected...Installing"
        sudo apt-get install medusa -y > installing;rm installing
else
    echo "[+] medusa detected"
     
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

# Function DeepScan

function deepscan () {

#Variables
echo -e "$OKRED Set hostname or IP $RESET"
read target
TARGET="$target"
USER_FILE="usernames.txt"
PASS_FILE="/usr/share/wordlists/metasploit/burnett_top_1024.txt"
MIN_PASS="pass.txt"
DIRB_DIR="/usr/share/dirbuster/wordlists/directory-list-1.0.txt"
SNMP_STRINGS="/usr/share/seclists/Miscellaneous/wordlist-common-snmp-community-strings.txt"

#Colors
OKBLUE='\033[94m'
OKRED='\033[91m'
OKGREEN='\033[92m'
OKORANGE='\033[93m'
RESET='\e[0m'


#Starting the process
echo -e "$OKRED Scan away with DeepScan.$RESET"

echo -e "$OKORANGE Usage ./DeepScan.sh target-ip-address or url ...$RESET"


#Scannig to xml file, then grep the open ports
#Explanation -sS   -sV  --open   -p-   -oX
nmap -sS -T5 -sV -A --open -p- $TARGET -oX $TARGET.xml
port_21=`grep 'portid="21"' $TARGET.xml | grep open`
port_22=`grep 'portid="22"' $TARGET.xml | grep open`
port_25=`grep 'portid="25"' $TARGET.xml | grep open`
port_80=`grep 'portid="80"' $TARGET.xml | grep open`
port_110=`grep 'portid="110"' $TARGET.xml | grep open`
port_111=`grep 'portid="111"' $TARGET.xml | grep open`
port_135=`grep 'portid="135"' $TARGET.xml | grep open`
port_139=`grep 'portid="139"' $TARGET.xml | grep open`
port_161=`grep 'portid="161"' $TARGET.xml | grep open`
port_162=`grep 'portid="162"' $TARGET.xml | grep open`
port_443=`grep 'portid="443"' $TARGET.xml | grep open`
port_445=`grep 'portid="445"' $TARGET.xml | grep open`
port_2121=`grep 'portid="2121"' $TARGET.xml | grep open`
port_3306=`grep 'portid="3306"' $TARGET.xml | grep open`
port_3389=`grep 'portid="3389"' $TARGET.xml | grep open`
port_8080=`grep 'portid="8080"' $TARGET.xml | grep open`

if [ -z "$port_80" ];
	then
		echo -e "$OKRED + -- --=[Port 80 closed... skipping.$RESET"
	else
		echo -e "$OKORANGE + -- --=[Port 80 opened... running tests...$RESET"
		nikto -host $TARGET
		davtest -url http://$TARGET/
		nmap -p80 --script=http-adobe-coldfusion-apsa1301 --script=http-affiliate-id --script=http-apache-negotiation --script=http-apache-server-status --script=http-aspnet-debug --script=http-auth-finder --script=http-auth --script=http-backup-finder --script=http-brute --script=http-coldfusion-subzero  --script=http-config-backup --script=http-default-accounts --script=http-frontpage-login --script=http-iis-short-name-brute --script=http-iis-webdav-vuln --script=http-methods --script=http-method-tamper --script=http-passwd --script=http-phpmyadmin-dir-traversal --script=http-php-version --script=http-put --script=http-robots.txt --script=http-server-header --script=http-shellshock --script=http-title --script=http-userdir-enum --script=http-vuln-cve2006-3392 --script=http-vuln-cve2009-3960 --script=http-vuln-cve2010-0738 --script=http-vuln-cve2010-2861 --script=http-vuln-cve2011-3192 --script=http-vuln-cve2011-3368 --script=http-vuln-cve2012-1823 --script=http-vuln-cve2013-0156 --script=http-vuln-cve2013-6786 --script=http-vuln-cve2013-7091 --script=http-vuln-cve2014-2126 --script=http-vuln-cve2014-2127 --script=http-vuln-cve2014-2128 --script=http-vuln-cve2014-2129 --script=http-vuln-cve2014-3704 --script=http-vuln-cve2014-8877 --script=http-vuln-cve2015-1427 --script=http-vuln-cve2015-1635 $TARGET
	fi


if [ -z "$port_443" ];
	then
		echo -e "$OKRED + -- --=[Port 443 closed... skipping.$RESET"
	else
		echo -e "$OKORANGE + -- --=[Port 443 opened... running tests...$RESET"
		nmap -p443 --script=http-adobe-coldfusion-apsa1301 --script=http-affiliate-id --script=http-apache-negotiation --script=http-apache-server-status --script=http-aspnet-debug --script=http-auth-finder --script=http-auth --script=http-backup-finder --script=http-brute --script=http-coldfusion-subzero  --script=http-config-backup --script=http-default-accounts --script=http-frontpage-login --script=http-iis-short-name-brute --script=http-iis-webdav-vuln --script=http-methods --script=http-method-tamper --script=http-passwd --script=http-phpmyadmin-dir-traversal --script=http-php-version --script=http-put --script=http-robots.txt --script=http-server-header --script=http-shellshock --script=http-title --script=http-userdir-enum --script=http-vuln-cve2006-3392 --script=http-vuln-cve2009-3960 --script=http-vuln-cve2010-0738 --script=http-vuln-cve2010-2861 --script=http-vuln-cve2011-3192 --script=http-vuln-cve2011-3368 --script=http-vuln-cve2012-1823 --script=http-vuln-cve2013-0156 --script=http-vuln-cve2013-6786 --script=http-vuln-cve2013-7091 --script=http-vuln-cve2014-2126 --script=http-vuln-cve2014-2127 --script=http-vuln-cve2014-2128 --script=http-vuln-cve2014-2129 --script=http-vuln-cve2014-3704 --script=http-vuln-cve2014-8877 --script=http-vuln-cve2015-1427 --script=http-vuln-cve2015-1635 $TARGET
		nikto -host $TARGET --port 443
		davtest -url https://$TARGET/
		nmap  -p443 -script=ssl-heartbleed $TARGET	
	fi

if [ -z "$port_8080" ];
	then
		echo -e "$OKRED + -- --=[Port 8080 closed... skipping.$RESET"
	else
		echo -e "$OKORANGE + -- --=[Port 8080 opened... running tests...$RESET"
		nmap -p8080 --script=http-adobe-coldfusion-apsa1301 --script=http-affiliate-id --script=http-apache-negotiation --script=http-apache-server-status --script=http-aspnet-debug --script=http-auth-finder --script=http-auth --script=http-backup-finder --script=http-brute --script=http-coldfusion-subzero  --script=http-config-backup --script=http-default-accounts --script=http-frontpage-login --script=http-iis-short-name-brute --script=http-iis-webdav-vuln --script=http-methods --script=http-method-tamper --script=http-passwd --script=http-phpmyadmin-dir-traversal --script=http-php-version --script=http-put --script=http-robots.txt --script=http-server-header --script=http-shellshock --script=http-title --script=http-userdir-enum --script=http-vuln-cve2006-3392 --script=http-vuln-cve2009-3960 --script=http-vuln-cve2010-0738 --script=http-vuln-cve2010-2861 --script=http-vuln-cve2011-3192 --script=http-vuln-cve2011-3368 --script=http-vuln-cve2012-1823 --script=http-vuln-cve2013-0156 --script=http-vuln-cve2013-6786 --script=http-vuln-cve2013-7091 --script=http-vuln-cve2014-2126 --script=http-vuln-cve2014-2127 --script=http-vuln-cve2014-2128 --script=http-vuln-cve2014-2129 --script=http-vuln-cve2014-3704 --script=http-vuln-cve2014-8877 --script=http-vuln-cve2015-1427 --script=http-vuln-cve2015-1635 $TARGET
		nikto -host $TARGET --port 8080
		davtest -url http://$TARGET:8080/
	fi


if [ -z "$port_21" ];
	then
		echo -e "$OKRED + -- --=[Port 21 closed... skipping.$RESET"
	else
		echo -e "$OKORANGE + -- --=[Port 21 opened... running tests...$RESET"
		nmap -A -sV -sC -T5 -p21 --script="ftp-*" $TARGET
	fi

if [ -z "$port_25" ];
	then
		echo -e "$OKRED + -- --=[Port 25 closed... skipping.$RESET"
	else
		echo -e "$OKORANGE + -- --=[Port 25 opened... running tests...$RESET"
		nmap -A -sV -sC -T5 -p25 --script="smtp-vuln-*" $TARGET
		smtp-user-enum -M VRFY -U $USER_FILE -t $TARGET 
		smtp-user-enum -M EXPN -U $USER_FILE -t $TARGET 
		smtp-user-enum -M RCPT -U $USER_FILE -t $TARGET 
	fi


if [ -z "$port_161" ];
then
	echo -e "$OKRED + -- --=[Port 161 closed... skipping.$RESET"
else
	echo -e "$OKORANGE + -- --=[Port 161 opened... running tests...$RESET"
	for a in `cat $SNMP_STRINGS`; do snmp-check -t $TARGET -c $a; done;
	nmap -sU -p 161 --script="snmp*" $TARGET
fi

if [ -z "$port_162" ];
then
	echo -e "$OKRED + -- --=[Port 162 closed... skipping.$RESET"
else
	echo -e "$OKORANGE + -- --=[Port 162 opened... running tests...$RESET"
	for a in `cat $SNMP_STRINGS`; do snmp-check -t $TARGET -c $a; done;
	nmap -A -p 162 --script="snmp*" $TARGET
fi

if [ -z "$port_110" ];
then
	echo -e "$OKRED + -- --=[Port 110 closed... skipping.$RESET"
else
	echo -e "$OKORANGE + -- --=[Port 110 opened... running tests...$RESET"
	nmap -A -sV -T5 --script="pop3--capabilities" --script="pop3-ntlm-info" -p 110 $TARGET
fi

if [ -z "$port_111" ];
then
	echo -e "$OKRED + -- --=[Port 111 closed... skipping.$RESET"
else
	echo -e "$OKORANGE + -- --=[Port 111 opened... running tests...$RESET"
	showmount -a $TARGET
	showmount -d $TARGET
	showmount -e $TARGET
fi

if [ -z "$port_135" ];
then
	echo -e "$OKRED + -- --=[Port 135 closed... skipping.$RESET"
else
	echo -e "$OKORANGE + -- --=[Port 135 opened... running tests...$RESET"
	rpcinfo -p $TARGET
	nmap -A -p 135 -T5 --script="rpc*" $TARGET
fi


if [ -z "$port_445" ];
	then
		echo -e "$OKRED + -- --=[Port 445 closed... skipping.$RESET"
			if [ -z "$port_139" ];
				then
			echo -e "$OKRED + -- --=[Port 139 closed... skipping.$RESET"
				else
			echo -e "$OKORANGE + -- --=[Port 139 opened... running tests...$RESET"
			enum4linux -a $TARGET
			nmap -p139 $TARGET --script="smb-vuln*"	
			fi
	else
		echo -e "$OKORANGE + -- --=[Port 445 opened... running tests...$RESET"
		enum4linux -a $TARGET
		nmap -p445 $TARGET --script="smb-vuln*"	
	fi

if [ -z "$port_2121" ];
then
	echo -e "$OKRED + -- --=[Port 2121 closed... skipping.$RESET"
else
	echo -e "$OKORANGE + -- --=[Port 2121 opened... running tests...$RESET"
	nmap -A -sV -T5 --script="ftp-*" -p2121 $TARGET
	fi

if [ -z "$port_3306" ];
then
	echo -e "$OKRED + -- --=[Port 3306 closed... skipping.$RESET"
else
	echo -e "$OKORANGE + -- --=[Port 3306 opened... running tests...$RESET"
	nmap -A -sV --script="mysql*" -p 3306 $TARGET
	mysql -u root -h $TARGET -e 'SHOW DATABASES; SELECT Host,User,Password FROM mysql.user;'
fi

echo -e "$OKGREEN + -- -- Starting UDP Scan .$RESET"
us -H -mU -Iv $TARGET -p 1-65535

if [ -z "$port_21" ];
	then
		echo -e "$OKRED + -- --=[Port 21 closed... skipping brute force.$RESET"
	else
		echo -e "$OKORANGE + -- --=[Port 21  start brute force......$RESET"
		medusa -h $TARGET -U $USER_FILE -P $MIN_PASS -e ns -M ftp -v 1	
	fi

if [ -z "$port_22" ];
	then
		echo -e "$OKRED + -- --=[Port 22 closed... skipping brute force.$RESET"
	else
		echo -e "$OKORANGE + -- --=[Port 22 opened...  start brute force...$RESET"
		medusa -h $TARGET -U $USER_FILE -P $MIN_PASS -e ns -M ssh -v 1
	fi


if [ -z "$port_445" ];
	then
		echo -e "$OKRED + -- --=[Port 445 closed... skipping brute force.$RESET"
	else
		echo -e "$OKORANGE + -- --=[Port 445 opened...  start brute force...$RESET"
		medusa -h $TARGET -U $USER_FILE -P $MIN_PASS -e ns -M SMBNT -v 1
		echo -e "$OKRED + -- -- If anon login allowed use the nmap brute force below...$RESET"
		#nmap -p445 --script=smb-brute --script-args smblockout=true,userdb=$USER_FILE,passdb=$MIN_PASS $TARGET
	fi

if [ -z "$port_3389" ];
	then
		echo -e "$OKRED + -- --=[Port 3389 closed... skipping brute force.$RESET"
	else
		echo -e "$OKORANGE + -- --=[Port 3389 opened...  start brute force...$RESET"
		rdesktop $TARGET &
		medusa -h $TARGET -U $USER_FILE -P $MIN_PASS -e ns -M RDP -v 1
	fi

if [ -z "$port_80" ];
	then
		echo -e "$OKRED + -- --=[Port 80 closed... skipping extensive directory browsing.$RESET"
	else
		echo -e "$OKORANGE + -- --=[Port 80 opened... running extensive directory browsing...$RESET"
		dirb http://$TARGET/ $DIRB_DIR -w -r
	fi


if [ -z "$port_443" ];
	then
		echo -e "$OKRED + -- --=[Port 443 closed... skipping extensive directory browsing.$RESET"
	else
		echo -e "$OKORANGE + -- --=[Port 443 opened... running extensive directory browsing...$RESET"
		dirb https://$TARGET:443/ $DIRB_DIR -w -r
	fi

if [ -z "$port_8080" ];
	then
		echo -e "$OKRED + -- --=[Port 8080 closed... skipping extensive directory browsing.$RESET"
	else
		echo -e "$OKORANGE + -- --=[Port 8080 opened... running extensive directory browsing...$RESET"
		dirb http://$TARGET:8080/ $DIRB_DIR -w -r
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

# Deepscan not activated, remove hashtag to activate function hydra
# deepscan