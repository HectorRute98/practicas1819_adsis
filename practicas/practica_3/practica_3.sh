#!/bin/bash
#nombre autor:Diego Marco Beisty
#nip autor: 755232
cat /etc/shadow &> /dev/null
#intento ejecutar cat sobre un fichero protegido como shadow
#Compruebo el estado de salida del comando
if [ $? -eq 0 ];then
  #caso tiene privilegios de administración
  exit 0
else 
  #caso no tiene privilegios de administración
  echo "Este script necesita privilegios de administracion"
  exit 1
fi
