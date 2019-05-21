#!/bin/bash
#Autor: Diego Marco 
#Nip:755232

if [ ! $# -eq 1 ];then
	echo "Numero de parametros incorrecto: "
	echo "./practica5_parte2.sh <IP>"
	exit 1
else
	#discos duros disponibles y sus tamaños en bloques
	ssh -i ~/.ssh/id_as_ed25519 as@"$1" 'sudo sfdisk -s'
	#Las particiones y sus tamaños
	ssh -i ~/.ssh/id_as_ed25519 as@"$1" 'sudo sfdisk -l'
	#Información montaje de sistemas de ficheros (salvo tmpfs)
	ssh -i ~/.ssh/id_as_ed25519 as@"$1" 'sudo df -hT | grep -v "^tmpfs"'
fi
exit 0
