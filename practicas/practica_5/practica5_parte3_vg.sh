#!/bin/bash
#--------------------------------------------------------------------------------------------
#Autor: Diego Marco 
#Nip:755232
#Comentarios: Extiende un grupo volumen existente con una o mas particiones
#Comprobación script: vgdisplay -> Se ha ampliado la capacidad del grupo volumen
#                      pvs -o+pv_used para comprobar los volumenes fisicos del grupo volume
#---------------------------------------------------------------------------------------------
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
#caso existe el grupo volumen
volumen="$1" #guardo el grupo volumen
shift #Elimino primer elemento de la lista (grupo volumen)
for particion in "$@";do
	#creo el volumen fisico
	sudo pvcreate "$particion"
	#extiendo el grupo volumen con el volumen fisico
	sudo vgextend "$volumen" "$particion"
done
exit 0
