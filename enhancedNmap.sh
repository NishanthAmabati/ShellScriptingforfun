# I have developed a custom Nmap script that significantly enhances scan speed. The script employs a unique approach by first conducting a basic Nmap scan across all ports. Once this initial scan is 
# completed, it then automatically initiates an Aggressive Nmap scan (-A) individually on each port identified during the initial scan.

# This method dramatically reduces the time consumed compared to directly using the Nmap -A flag for an entire scan. By targeting the Aggressive scan only on specific ports that require deeper 
# analysis, the script efficiently optimizes the scanning process without compromising the quality of the results.

# With this custom Nmap script, I have been able to achieve faster and more effective scanning, making it a valuable tool for any cybersecurity enthusiast or penetration tester looking to streamline 
# their reconnaissance process.

#!/usr/bin/bash

# usage: ./enhancednmap.sh <target_ip>

# check if syntax is correct
# check if the right amount of arguments were provided
if [ $# -eq 1 ] 
then
	# REGEX to check if ip addr is valid  
	if [[ $1 =~ ^[0-9]+\.+[0-9]+\.+[0-9]+\.+[0-9]+$ ]]
	then
		echo "starting scan..."
	else
		echo -e "ip address is inncorrect\nPlease enter a valid ip address\nexample: 192.168.1.3"
		exit 1 # if not convey the same and exit script
	fi
else
	echo "Please enter an ip address"
	echo "syntax : ./enhancedNmap.sh <ip>"
	exit 1
fi

# creating a file in the /tmp dir to store initial scan results
file="/tmp/ports`date +%a%b%Y%s`.txt"

# performing an nmap scan and grepping out only the ports
# on which a certain service is running 
nmap -sS -T4 -p- $1 | grep ^[0-9] | cut -d "/" -f 1 >> $file

# reading the scan and appending ports to $file
lineNum=1
while read line; do
	ports[$lineNum]=$line
	lineNum=$((lineNum + 1))
done < $file

# finally, performing an aggressive nmap scan(-A flag) on only ports
# where a certain service is running
for ((port=1; port<=${#ports[@]}; port++))
do
	echo "Sacnning aggresively for port ${ports[port]}..."
	nmap -T4 -p ${ports[port]} -A $1
	echo "-------------------------------------------------"
done
