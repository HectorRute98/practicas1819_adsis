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
if [ -z "$existe" ];then
	#caso no existe el grupo volumen
	echo "No existe el grupo volumen $1"
	exit 1
fi >&2
volumen="$1" #guardo el grupo volumen
shift #Elimino primer elemento de la lista (grupo volumen)
for particion in "$@";do
	#creo el volumen fisico
	sudo pvcreate "$particion"
	#extiendo el grupo volumen con el volumen fisico
	sudo vgextend "$volumen" "$particion"
done
exit 0
