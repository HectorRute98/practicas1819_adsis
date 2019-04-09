#!/bin/bash
#Nombre autor: Diego Marco
#NIP autor: 755232
#coms: si nombre fichero recibido como parámetro es un fichero regular, muestra su info -rwxr-xr-x
if [ $# -eq 1 ];then
   #caso Nº parámetros correcto
   if [ -f "$1" ];then
     #caso es fichero regular
     chmod u+x "$1"             #añadir permiso de ejecucion del propietario
     chmod g+x "$1"             #añadir permiso de ejecucion del grupo
     stat --format=%A "$1"      #imprimir permisos fichero 
   else
     #caso no es fichero regular
     echo "$1 no existe" 
   fi
else
   #caso Nº parámetros incorrecto
   echo "Sintaxis: practica2_3.sh <nombre_archivo>"
fi
