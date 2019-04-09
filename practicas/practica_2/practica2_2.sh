#!/bin/bash
#Nombre autor: Diego Marco
#NIP autor: 755232
#coms: recibe varios nombres de archivo como parámetros y valida si son ficheros regulares

for param in "$@";do   
  # bucle for parte los string segun los delimitadores definidos en IFS=' \t\n'
  #"$@": bucle for itera entre los elementos de la lista ej:["ho la.txt","fichero.py"], 2 iteraciones
  #(no hace caso a los espacios en los nombres de fichero)
  if [ -f "$param" ];then
    #caso fichero regular
    #pasamos "$param" entre comillas al comando test para que los espacios no tengan valor especial
    more "$param"                     
    #pasamos "$param" entre comillas al comando more para que los espacios no tengan valor especial
  else
    #caso fichero no regular
    echo "$param no es un fichero" 
  fi
done



#---------------------------------------$*,"$*",$@ y "$@"----------------------------------------------
#./script fich\ ero1.txt fichero2.txt
#$@ guarda los parametros en una lista,(separadores por defecto definidos en IFS)
        #for var in $@;do
        #  echo $var
        #done
        # _________________
        #|fich             |
        #|ero1.txt         |    <-- stdout
        #|fichero2.txt     |
        #|_________________|
        #
        #for var in "$@";do
        #  echo $var
        #done
        # _________________
        #|fich ero1.txt    |     
        #|fichero2.txt     |
        #|_________________|
        #
#$* guarda los parametros en un string
        #for var in $*;do
        #  echo $var
        #done
        # _________________
        #|fich             |
        #|ero1.txt         |    
        #|fichero2.txt     |
        #|_________________|
        #
        #for var in "$*";do
        #  echo $var
        #done
        # _______________________________
        #|fich ero1.txt fichero2.txt     |
        #|_______________________________|
        #

