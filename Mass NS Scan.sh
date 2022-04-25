#!/usr/bin/env bash

function banner(){
	
       	echo ""
	echo ""
	echo ""	
       	echo ""
	 echo " ___      ___       __        _________  _________       ____      ____  _________       _________  _________       __       ____      ____"
	 echo "|###\    /###|     /##\      |#########||#########|     |#####\   |####||#########|     |#########||#########|     /##\     |#####\   |####|"
	 echo "|####\  /####|    /####\     |###______||###______|     |######\  |####||###______|     |###______||#########|    /####\    |######\  |####|"
	 echo "|############|   /###^##\    |#########||#########|     |#######\ |####||#########|     |#########||####|        /###^##\   |#######\ |####|"
	 echo "|####|\/|####|  /####_###\   |______###||______###|     |####\###\|####||______###|     |______###||####|____   /####_###\  |####\###\|####|"
	 echo "|####|  |####| /####/ \###\  |#########||#########|     |####|\########||#########|     |#########||#########| /####/ \###\ |####|\########|"
	 echo "|####|  |####|/####/   \###\ |_________||_________|     |####| \#######||_________|     |_________||#########|/####/   \###\|####| \#######|"
	 echo ""
	 echo ""
	 echo ""
	 echo "Written by Rainer Kennedy | @Rainer_InfoSec"
	 echo ""
	 echo ""
	 echo ""

 }

function help() {
        echo "Usage: $0 "
	echo "Arg1= First 3 octets of IP"
	echo "Arg2= Last octect of IP - Scan start IP"
	echo "Arg3= Last octect of IP - End of scan IP"
        echo ""
	echo "Example usage: $0 192.168.0 1 255"
	echo "This will then scan 192.168.0.1 - 192.168.0.255"
	exit 1
}

case $1 in
	-h| --help) help;
esac

if [[ -f "found.txt" ]]
then
	rm found.txt
fi

ipFirstThreeOctets=$1
startOctet=$2
lastOctet=$3

banner

for i in $(eval echo "{$startOctet..$lastOctet}")
do      
	current="$ipFirstThreeOctets.$i"
	#echo "$ipFirstThreeOctets.$i"
	result=$(nslookup "$ipFirstThreeOctets.$i" 2>/dev/null)
	if [[ $? == 1 ]]
	then
		echo "[+] Domain found for $current!"
		echo $result | awk '{print $4}' | sed 's/.$//' >> found.txt
	fi
done
