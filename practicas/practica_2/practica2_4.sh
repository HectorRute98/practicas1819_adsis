#!/bin/bash
#Nombre autor: Diego Marco
#NIP autor: 755232
#coms: muestra al usuario si primer caracter pulsado es una letra, numero o carácter especial

#Leo primer caracter introducido de stdin
echo -n "Introduzca una tecla: "
read -n1 caracter
#Leo el resto de caracteres para que el usuario inserte \n
read linea
case $caracter in
  [[:alpha:]])
    #caso primer caracter es alfanumerico
    echo "$caracter es una letra" ;;
  [[:digit:]])
    #caso primer caracter es numerico
    echo "$caracter es un numero" ;;
  *) 
    #caso primer caracter es caracter especial
    echo "$caracter es un caracter especial" ;;
esac


