#!/bin/bash
#Presentar una lista de procesos de la siguiente forma:
# 1) pid1  cmd1
# 2) pid2  cmd2
# Pedir al usuario un numero y matar el proceso correspondiente
# de la lista

# Se podria hacer un bucle que usa ps, salta primera linea, coge primera columna y ultima
# pero se puede formatear la salida del comando y asi nos ahorramos trabajo
# man ps, OUTPUT FORMAT CONTROL --> ps -o pid= -o comm=

#guardamos en lista la salida del comando
lista=$(ps -o pid= -o comm=)
cont=1
echo "$lista" | while read linea #esta construccion permite iterar linea a linea y no palabra a palabra
# read lee pid1 y cmd1 de echo e itera, lee pid2 y cmd2 de echo e itera
#probar "$lista" sin ""
do 
  echo $cont\) $linea #hay que escapar el parentesis con "" o \
  cont=$((cont+1))
done 

echo -n "Dame un numero: "
read numero

cont=1
echo "$lista" | while read linea
do 
  if [ $cont -eq $numero ];then #el if trabaja sobre condiciones de salida de comandos, no sobre condiciones
    kill $linea #PROBLEMA: linea = pid cmd, QUIERO QUITAR CMD   
    #salgo del buce con break, pero mucho mejor con exit, salida correcta 0
    exit 0
  fi
  cont=$((cont+1))
done 
exit 1 #estado de salida 1, ejecucion incorrecta del script



#1) de donde saco la informacion
#2) muchas veces los comandos me dejan filtrar la informacion
#3) uso de variables que contienen lineas y quiero procesar linea a linea--> echo "$lista" | while read linea
#4) estandarizar las salidas exit 0, o exit 1



# alternativa a 3) con for
#OldIFS=IFS
#IFS=$'\n'
#for linea in $lista
#do 
#-------------------MAL------------------------------
#  echo $linea | read pid cmd  # echo comando interno y pipe crea un subproceso donde ejecuta read, guarda en pid y cms DEL SUBPROCESO HIJO
#  echo $pid                   #pid es un string vacio, esta variable es del PROCESO PADRE
#  echo $cmd                   #cmd es un string vacio, esta variable es del PROCESO PADRE
#------------------------------------------------------
#done
#IFL=OldIFS
