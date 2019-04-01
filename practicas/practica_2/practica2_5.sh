#!/bin/bash
#Nombre autor: Diego Marco
#NIP autor: 755232

OldIFS=IFS
IFS=$'\t\n' #Aceptar nombre fichero con espacios
echo -n "Introduzca el nombre de un directorio: "
read directorio
num_fich=0 #Contador numero de directorios en $directorio
num_dir=0  #Contador numero de ficheros en $directorio
if [ -d "$directorio" ];then
  #caso existe $directorio
  for contenido in $(find "$directorio" -type d);do       #Itera sobre lista de directorios en $directorio
    num_dir=$((num_dir + 1))
  done
  for contenido in $(find "$directorio" -not -type d);do  #Itera sobre lista de ficheros en $directorio
    num_fich=$((num_fich + 1))
  done
  echo El numero de ficheros y directorios en $directorio es de $num_fich y $((num_dir - 1)), respectivamente
else
  echo "$directorio no es un directorio"
fi
IFS=OldIFS #Actualizo valor por defecto
