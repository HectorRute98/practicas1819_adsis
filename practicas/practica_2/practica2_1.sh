#!/bin/bash
#Nombre autor: Diego Marco
#NIP autor: 755232
leer="-"
escribir="-"
ejecutar="-"
OldIFS=$IFS
IFS=$'\t\n' #Aceptar nombre de fichero con espacios
echo -n "Introduzca el nombre del fichero: "
read nombre
if [ ! -e $nombre ];then                          
  echo "$nombre no existe" # caso fichero,socket,directorio,... no existe
else
  if [ -r $nombre ];then
    leer="r"               # caso fichero existe y tiene permiso de lectura
  fi
  if [ -w $nombre ];then
    escribir="w"           #caso fichero existe y tiene permiso de escirtura
  fi
  if [ -x $nombre ];then
    ejecutar="x"          #caso fichero existe y tiene permiso de ejecucion
  fi
  echo "Los permisos del archivo $nombre son: $leer$escribir$ejecutar"
fi
IFS=OldIFS # Reestablezco el valor por defecto
