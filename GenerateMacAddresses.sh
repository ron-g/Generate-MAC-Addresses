#!/bin/bash

OUI='58656e'
iter=0

if [ "$1" == '' ]
then
	NumOfMacsToGenerate=1
else
	NumOfMacsToGenerate=$1
fi

RANDMACS=$( openssl rand -hex $(( NumOfMacsToGenerate * 3 )) )

while [ $iter -lt $NumOfMacsToGenerate ]
do
	offst=$(( iter * 3 ))
	MACADDRESS="${OUI}${RANDMACS:${offst}:6}"
	printf "${MACADDRESS:0:2}:${MACADDRESS:2:2}:${MACADDRESS:4:2}:${MACADDRESS:6:2}:${MACADDRESS:8:2}:${MACADDRESS:10:2}\n"
	iter=$((iter + 1))
done