# Detection of applications and installation


# Mmap installation

if [ ! -x "$(command -v nmap)" ]; then
        echo "[+] nmap not detected...Installing"
        sudo apt-get install nmap -y > installing;rm installing
else
    echo "[+] nmap detected"
     
fi

# Nikto installation

if [ ! -x "$(command -v nikto)" ]; then
        echo "[+] nikto not detected...Installing"
        sudo apt-get install nikto -y > installing;rm installing
else
    echo "[+] nikto detected"
     
fi

# Dirbuster installation

if [ ! -x "$(command -v dirbuster)" ]; then
        echo "[+] dirbuster not detected...Installing"
        sudo apt-get install dirbuster -y > installing;rm installing
else
    echo "[+] dirbuster detected"
     
fi