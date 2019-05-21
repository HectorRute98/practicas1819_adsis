#!/bin/bash
#Autor: Diego Marco 
#Nip:755232

grupo=$(sudo vgscan)
existe=$(echo $grupo | grep "$1")
if [-z "$existe"];then
	echo "No existe el vg $1"
	exit 1
else
	for particion in "$@";do
		sudo pvcreate "$particion"
		sudo vgextend "$1 $particion"
	done
fi
exit
