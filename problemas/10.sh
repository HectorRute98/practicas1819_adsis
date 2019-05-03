#!/bin/bash
#Evaluar usuarios logeados cuto nombre de usuario tenga al menos
#4 caracteres

who |egrep '^[^ ]{4,}' | cut -d ' ' -f1











#registros en expresiones regulares
#\(pedro\)\1   ---> pedropedro
#\(.\)aa\1     --->baab caac daad waaw

#registros en expresiones regulares extendidas
#(pedro)\1     --->pedropedro
#(.)aa\1       --->baab caac daad waaw

#Detectar dirección de correo
#\w + @ + \w + (\.\w+)

#se repite caracter alfanumerico dos veces
#\w{2}
