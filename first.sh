#!/bin/bash


opensslbin=$(which openssl)
if [ -z "$opensslbin" ] ; then
	echo Error, openssl is not found 
	exit 1
fi

function genrsa()
{
	if [ -z "$1" ] ;then
		read -p "Key Size [2048]: " keysize
		if [ -z "$keysize" ] ; then
			keysize=2048
		fi
	else
		keysize=$1
	fi

	echo "key size $keysize selected"
	
	while [ -z "$outputfile" ]; do
		read -e -p "Filename output (tab complete works): " outputfile
		if [ -a "$outputfile" ] ; then
			read -p "$outputfile already exists. Do you wish to overwite it? (y/n) "  confirmdelete
			if [ "$confirmdelete" = "n" ]; then
				outputfile=""
			fi
		fi
	done
	
	openssl genrsa -out "$outputfile" $keysize
}

function gencsr ()
{
	
		read  -e -p "Key File (tab complete works): " keyfile
		


}

printmenu()
{
echo "
Generate RSA Key
		 [2048] 			(1a)
		 [4096]				(1b)
		 [specify]			(1c)
Split pub Key from private
Verify keys					(3)
Generate cert
		CSR Request			(4)
		Sign with CA
		Self Signed
View CSR Details
View Certificate Details

Generate CA					
"
}

while :
do
	printmenu
	read -p "Option: " option
	case $option in
		"1a")
			genrsa 2048;;
		"1b")
			genrsa 4096;;
		"1c")
			genrsa;;
		"2")
			splitkey;;
		*) echo invalid option;;
	esac
done


