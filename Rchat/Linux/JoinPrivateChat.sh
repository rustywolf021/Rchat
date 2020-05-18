#!/bin/bash
lgreen="\e[92m"
lred="\e[91m"
nc="\e[39m"
lyellow="\e[1;33m"
chatname="$USER"
date=$(date)

function exitprogram()
{
	echo ""
	echo -e $lgreen"Aight bet..."
	echo -e $lred"cya soon XD"
	exit 0
}

function checkroot()
{
	if [ $(id -u) != "0" ]; then
		echo ""
		echo You need to be root to run this script...
		echo Please start R.Deauth with [sudo ./start.sh]
		exit
	else
		echo YAY your root user!
		sleep 1
		clear
	fi
}

function ncatinstalled()
{
	nmaptool=`which nmap`
	if [[ "$?" != "0" ]]; then
		echo -e $lred"Nmap not found need to install..."
		echo -e $lgreen""
		read -p "Would you like to install Nmap? (y / n): " installnmap
		if [[ $installnmap == "y" ]]; then
			echo "Installing nmap"
			sudo apt-get update
			sudo apt-get upgrade
			sudo apt-get nmap
		fi
		if [[ $installnmap == "n" ]]; then
			echo -e $lgreen"You need nmap..."
			exit 0
		fi
	fi
	ncattool=`which ncat`
	if [[ "$?" != "0" ]]; then
		echo -e $lred"Ncat not found need to install..."
		echo -e $lgreen""
		read -p "Would you like to install Ncat? (y / n): " installncat
		if [[ $installncat == "y" ]]; then
			echo "Installing ncat"
			sudo apt-get update
			sudo apt-get upgrade
			sudo apt-get ncat
		fi
		if [[ $installnmap == "n" ]]; then
			echo -e $lgreen"You need Ncat..."
			exit 0
		fi
	fi
}

clear
trap exitprogram EXIT
checkroot
ncatinstalled
clear
echo -e $lgreen"All tools installed..."
sleep 2
while :
do
clear
echo -e $lgreen"Username:" $lred" $chatname" $lgreen""
echo ""
echo "1) Join session"
echo ""
echo "2) Set username"
echo ""
echo "e) exit"
read -p "-->> " menu1
if [[ $menu1 == "1" ]]; then
	clear
	echo -e $lgreen""
	clear
	read -p "Enter chat ip or domain: " ipordomain
	echo ""
	read -p "Enter chat port: " port
	echo ""
	echo "Connecting..."
	echo ""

	while :
	do
		echo $chatname Joined the chat $date | ncat $ipordomain $port
		echo $chatname Joined the chat $date
		echo Type something...
		
		echo -e $lgreen""
		
		while true; do
			read message
			echo -e "$chatname: $message"
		done | ncat $ipordomain $port
	done
fi
if [[ $menu1 == "2" ]]; then
	read -p "Enter chatname: " chatname
	echo $chatname > chatname.txt
	if [[ $chatname == "" ]]; then
		echo -e $lred"You must have a name..."
		sleep 2
		chatname="$USER"
	fi
fi
if [[ $menu1 == "e" ]]; then
	exit 0
fi





done