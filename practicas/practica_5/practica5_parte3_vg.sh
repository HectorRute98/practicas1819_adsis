#!/bin/bash
#Autor: Diego Marco 
#Nip:755232

if [ $# -lt 2 ];then
	#caso numero de parametros incorrecto
	echo "$0 <grupo volumen <particion> {particion}"
	exit 1
fi >&2
#numero de parametros correcto
grupo=$(sudo vgscan)
existe=$(echo $grupo | grep "$1")
if [-z "$existe"];then
	#caso no existe el grupo volumen
	echo "No existe el grupo volumen $1"
	exit 1
fi >&2
for particion in "$@";do
	sudo pvcreate "$particion"
	sudo vgextend "$1 $particion"
done
exit 0
