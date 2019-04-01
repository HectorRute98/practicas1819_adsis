#!/bin/bash
#Nombre autor: Diego Marco
#NIP autor: 755232
leer="-"
escribir="-"
ejecutar="-"
OldIFS=$IFS
IFS=$'\t\n' #Aceptar nombre de fichero con espacios,(elimino separador <espacio>)
echo -n "Introduzca el nombre del fichero: "
read nombre
if [ ! -e $nombre ];then                          
  echo "$nombre no existe" # caso fichero,socket,directorio,... no existe
else
  echo -n "Los permisos del archivo $nombre son: "
  stat --format=%A $nombre | cut -c 2-4
fi
IFS=OldIFS # Reestablezco el valor por defecto
