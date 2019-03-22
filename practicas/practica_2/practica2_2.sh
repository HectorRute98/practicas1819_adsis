#!/bin/bash
#Nombre autor: Diego Marco
#NIP autor: 755232

for param in "$@";do   # parte los string segun los delimitadores definidos en IFS=' \t\n'
  #"$@": bucle for itera entre los elementos de la lista ej:["ho la.txt","fichero.py"], 2 iteraciones
  #(no hace caso a los espacios en los nombres de fichero)
  if [ -f "$param" ];then
    #pasamos "$param" entre comillas al comando test para que los espacios no tengan valor especial
    more "$param"                    #CASO ES UN FICHERO REGULAR    
    #pasamos "$param" entre comillas al comando more para que los espacios no tengan valor especial
  else
    echo "$param no es un fichero" #CASO NO ES UN FICHERO REGULAR
  fi
done



#---------------------------------------$*,"$*",$@ y "$@"----------------------------------------------
#./script fich| ero1.txt fichero2.txt
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

