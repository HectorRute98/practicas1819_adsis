#!/bin/bash
#Autor: Diego Marcob
#Nip: 755232
#Adaptado a salida estandar de los comandos en las máquinas #virtuales
echo -n "Nº usuarios: "
uptime | cut -d "," -f 2 | cut -d " " -f 3
echo -n "carga media de trabajo:"
uptime | cut -d ":" -f 5
echo -n "Memoria ocupada: "
free --mega | grep Mem | sed -E 's/\s+/ MB;/g' | cut -d ";" -f 3
echo -n "Memoria libre: "
free --mega | grep Mem | sed -E 's/\s+/ MB;/g' | cut -d ";" -f 4
echo -n "Swap utilizado: "
free --mega | grep Swap | sed -E 's/\s+/ MB;/g' | cut -d ";" -f 3
echo -n "Número de puertos abiertos: "
netstat -ut | wc -l
echo -n "Conexiones establecidas: "
netstat -ut | grep ESTABLISHED$ | wc -l
echo -n "número de programas en ejecución: "
ps --no-headers -u $USER | wc -l

