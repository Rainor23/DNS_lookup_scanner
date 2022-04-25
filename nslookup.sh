#!/usr/bin/env bash

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

for i in $(eval echo "{$startOctet..$lastOctet}")
do
	current="$ipFirstThreeOctets.$i"
	#echo "$ipFirstThreeOctets.$i"
	result=$(nslookup "$ipFirstThreeOctets.$i" 2>/dev/null)
	if [[ $? == 1 ]]
	then
		echo "Domain not found for $current"
	else
		echo "Domain found for $current!"
		echo $result | awk '{print $4}' | sed 's/.$//' >> found.txt
	fi
done
