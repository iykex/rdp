#! /bin/bash
# Instance for Remote Desktop Protocol
echo "••••••••••••••••••••••••••••••••••••••••••••••••••"
echo "Make Instance Ready for Remote Desktop Protocol"
echo "••••••••••••••••••••••••••••••••••••••••••••••••••"
echo " "
echo "install setup file..."
echo " "
sudo apt-get update
rm -rf win2022 win2022.img win2022.gz ngrok ngrok.zip ng.sh > /dev/null 2>&1
echo "Download Windows Server Image/ISO"
wget -O win2022.gz https://archive.org/download/windows2022/windows2022.gz
echo "Download completed!"

clear
echo "•••••••••"
echo "> SETUP •"
echo "•••••••••"
echo "File extraction beings,"
echo "and Do not think that it's froken!"
echo "Please wait..."
gunzip win2022.gz
echo "Extraction completed!"
mv win2022 win2022.img
echo "clean up!"

clear
echo "•••••••••••••"
echo "> NGROK SETUP"
echo "•••••••••••••"
rm -rf ngrok ngrok.zip ng.sh > /dev/null 2>&1
echo "======================="
echo "Download ngrok"
echo "======================="
wget -O ngrok.zip https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip > /dev/null 2>&1
unzip ngrok.zip > /dev/null 2>&1
read -p "Paste Ngrok Authtoken: " CRP
./ngrok authtoken $CRP 
echo "   > NGROK SETUP <   "
echo "••••••••••••••••••••••••••••••••••••••••••••••••••"
echo choose ngrok region
echo "••••••••••••••••••••••••••••••••••••••••••••••••••"
echo "us - United States (Ohio)"
echo "eu - Europe (Frankfurt)"
echo "ap - Asia/Pacific (Singapore)"
echo "au - Australia (Sydney)"
echo "sa - South America (Sao Paulo)"
echo "jp - Japan (Tokyo)"
echo "in - India (Mumbai)"
read -p "choose ngrok region: " CRP
./ngrok tcp --region $CRP 3388 &>/dev/null &
echo Downloading files from setup files
sudo apt-get install qemu-system-x86 -y
echo "Please wait..."
echo " "
echo "Starting Windows..."
qemu-system-x86_64 -hda win2022.img -m 8G -smp cores=4 -net user,hostfwd=tcp::3388-:3389 -net nic -object rng-random,id=rng0,filename=/dev/urandom -device virtio-rng-pci,rng=rng0 -vga vmware -nographic &>/dev/null &
echo "..."

clear
b='\033[1m'
r='\E[31m'
g='\E[32m'
c='\E[36m'
endc='\E[0m'
enda='\033[0m'
# Branding

printf """$c$b
 

███╗░░░███╗██████╗░██╗░░░██╗██╗░░░██╗██████╗░░██████╗  ██████╗░██████╗░██████╗░
████╗░████║██╔══██╗██║░░░██║╚██╗░██╔╝██╔══██╗██╔════╝  ██╔══██╗██╔══██╗██╔══██╗
██╔████╔██║██████╔╝╚██╗░██╔╝░╚████╔╝░██████╦╝╚█████╗░  ██████╔╝██║░░██║██████╔╝
██║╚██╔╝██║██╔══██╗░╚████╔╝░░░╚██╔╝░░██╔══██╗░╚═══██╗  ██╔══██╗██║░░██║██╔═══╝░
██║░╚═╝░██║██║░░██║░░╚██╔╝░░░░░██║░░░██████╦╝██████╔╝  ██║░░██║██████╔╝██║░░░░░
╚═╝░░░░░╚═╝╚═╝░░╚═╝░░░╚═╝░░░░░░╚═╝░░░╚═════╝░╚═════╝░  ╚═╝░░╚═╝╚═════╝░╚═╝░░░░░
 by: mr•vybes | nanavybes 
           •••••••         
$endc$enda""";
echo " "
echo "RDP INFORMATION"
echo "••••••••••••••••••••••••••••••••••••••••••••••••••"
echo RDP Address:
curl --silent --show-error http://127.0.0.1:4040/api/tunnels | sed -nE 's/.*public_url":"tcp:..([^"]*).*/\1/p'
echo "•••••••••••••••••••••••••"
echo "Username: Administrator"
echo "Password: Lingg@H0sting"
echo "•••••••••••••••••••••••••"
echo "••••••••••••••••••••••••••••••••••••••••••••••••••"
echo "Don't closse this Tab"
echo "Wait 1 - 3 minut to finish booting,"
echo "before you connect in any external RDP software"
echo " "
echo "NOTE : This RDP can run up to 50 hours!"
echo "••••••••••••••••••••••••••••••••••••••••••••••••••"

sleep 43200