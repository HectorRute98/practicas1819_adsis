#!/bin/bash
#Nombre autor: Diego Marco
#NIP autor: 755232

if [ $# -eq 1 ];then
   #caso Nº parametros correcto
   if [ -f "$1" ];then
     #caso es fichero regular
     chmod u+x "$1"             #añadir permiso de ejecucion del propietario
     chmod g+x "$1"             #añadir permiso de ejecucion del grupo
     stat --format=%A "$1"      #imprimir permisos fichero 
   else
     echo "$1 no existe" 
   fi
else
   echo "Sintaxis: practica2_3.sh <nombre_archivo>"
fi
