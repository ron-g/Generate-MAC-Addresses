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
	if egrep -qi '^([a-f0-9]{6}|[a-f0-9:]{8,9})$' <<< "$2"
	then
		OUI="$2"
		OUI="${OUI//:}"
	else
		OUI=$(openssl rand -hex 3)
		printf "That doesn't look like a proper three byte OUI.\nGenerating random one instead.\n${OUI:0:2}:${OUI:2:2}:${OUI:4:2}\n\n" >&2
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
