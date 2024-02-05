#!/bin/bash

#---------------------------------------------
# Script to Automate The Intial Recon Phase
#---------------------------------------------

# Colors
	Red=$'\e[1;31m'
	Green=$'\e[1;32m'
	Orange=$'\e[1:33m'
	Blue=$'\e[1;34m'
	Purple=$'\e[1;35m'
	White=$'\e[0m'

# Create Markdown file 
	subl -b Notes.md 

# Create folder for basic scans
	mkdir Basic_Scans

# Format the file
	echo 'Notes 
------------------------------------------------------ 
	IPs:
		- 
		-
		-


	Findings:
		-
		-
		- 




	Credentials:
		-
		- 
		- 




	' >> Notes.md

# Artwork
	echo '
     /  /\         /  /\         /  /\         /  /\         /  /\    
    /  /::\       /  /::\       /  /::\       /  /::\       /  /::|   
   /  /:/\:\     /  /:/\:\     /  /:/\:\     /  /:/\:\     /  /:|:|   
  /  /::\ \:\   /  /::\ \:\   /  /:/  \:\   /  /:/  \:\   /  /:/|:|__ 
 /__/:/\:\_\:\ /__/:/\:\ \:\ /__/:/ \  \:\ /__/:/ \__\:\ /__/:/ |:| /\
 \__\/~|::\/:/ \  \:\ \:\_\/ \  \:\  \__\/ \  \:\ /  /:/ \__\/  |:|/:/
    |  |:|::/   \  \:\ \:\    \  \:\        \  \:\  /:/      |  |:/:/ 
    |  |:|\/     \  \:\_\/     \  \:\        \  \:\/:/       |__|::/  
    |__|:|~       \  \:\        \  \:\        \  \::/        /__/:/   
     \__\|         \__\/         \__\/         \__\/         \__\/    
	'

# Get IP Address 
	read -p 'Enter the IP Address: '$Green IP
	echo"" $Blue
	echo $IP >> Notes.md

# Nmap Portion 
	echo $Purple
	echo "----------------------- Basic Nmap Scan --------------------------"
	echo $White
	nmap -A -sV -sC -vv $IP -oN Scan.txt 
	echo""
	mv Scan.txt Basic_Scans

# GoBuster Scan
	echo $Purple
	echo "----------------------- GoBsuter Scan --------------------------"	
	echo	$White
	gobuster dir -u $IP -w /usr/share/seclists/Discovery/Web-Content/directory-list-2.3-medium.txt -x php,txt,html,bak,css,js,cgi,py,sh

# Nikto Portion
	echo $Orange
	echo "----------------------- Nikto Scan --------------------------"
	echo $White
	nikto -h $IP -output nikto.txt
	mv nikto.txt Basic_Scans


# FFUF Portion "optional"
	read -p 'Do you want to Fuff '$Green ANS
	if [ $ANS = yes ]
	then
		echo $Red
		echo "----------------------- FFUF Scan --------------------------"
		echo $White
		ffuf -c -w /usr/share/seclists/Discovery/Web-Content/directory-list-2.3-medium.txt -u http://$IP/FUZZ -recursion -r -t 50 -o ffuf.txt
		echo ""
		mv ffuf.txt Basic_Scans
	else 
		echo "Okay!"
	fi
		









