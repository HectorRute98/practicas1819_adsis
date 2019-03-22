#!/bin/bash
#Contar ficheros

for file in $(ls)
do
 cont=$(expr $cont + 1) 
done 
echo $cont

#expansion de variables $var
#expansion de comandos $( )
#expansion aritmetica $(( ))
#expansion de nombres de ficheros *,?...

#ORDEN DE EVALUACION
#  1 E/S
#  2 expansion de variables
#  3 expansion de nombres de ficheros

#OPCION2: mala, hace pipe pero parte derecha no es proceso        
#cont=0
#ls | while read file
#do 
#  cont=$(( $cont + 1 ))
#  echo $cont
#done


   
