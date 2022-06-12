#!/bin/bash

#OUI='58656e'
iter=0

if [ "$1" == '' ]
then
	NumOfMacsToGenerate=1
else
	NumOfMacsToGenerate=$1
fi

if [ "$2" == '' ]
then
	OUI='58656e'
else
	if egrep -qi '^[a-f0-9]{6}$' <<< "$2"
	then
		OUI="$2"
	else
		printf "That doesn't look like a proper three byte OUI.\nGenerating random one instead.\n" >&2
		OUI=$(openssl rand -hex 3)
	fi
fi

RANDMACS=$( openssl rand -hex $(( NumOfMacsToGenerate * 3 )) )

while [ $iter -lt $NumOfMacsToGenerate ]
do
	offst=$(( iter * 6 ))
	MACADDRESS="${OUI}${RANDMACS:${offst}:6}"
	MACADDRESS="${MACADDRESS,,}"
	printf "${MACADDRESS:0:2}:${MACADDRESS:2:2}:${MACADDRESS:4:2}:${MACADDRESS:6:2}:${MACADDRESS:8:2}:${MACADDRESS:10:2}\n"
	iter=$((iter + 1))
done
