#!/bin/bash
#Función factorial
#   *iterativo
#   *recursivo

factorial_iter() {
    contador=$1
    result=1
    while [ $contador -gt 0 ];do
      result=$((result * contador))
      contador=$((contador - 1 ))
    done
}
factorial_recur() {
    if [ $1 -eq 0 ];then
      echo 1 # en vez de return usamos echo
    else
      echo $(($1 * $(factorial_recur $(($1 - 1)))))
    fi     
}
#---------llamamos funcion iterativa---------------
factorial_iter 5
echo $result iterativo
#---------llamamos funcion recursiva---------------
echo $(factorial_recur 5) recursivo

