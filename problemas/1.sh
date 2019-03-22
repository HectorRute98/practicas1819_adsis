#!/bin/bash
#for file in $(ls)
#do echo $file
#done

#PROBLEMA: un fichero ej 2.txt lo tratara como dos palabras distintas:
# ej1.txt
# ej
# 2.txt

#SOLUCION1: menos estandar
#modificar IFS=$' \t\n'

#oldIFS=$IFS
#IFS=' \t\n'
#for file in $(ls)
#do
#  echo $file
#done
#IFS=$oldIFS

#SOLUCION2: mas estandar
ls | ehile rad file
do 
	echo $file
done
