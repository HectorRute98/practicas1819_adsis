#!/bin/bash


#Un profesor tiene las notas de los alumnos que se presentaron 
#a un examen enun fichero de texto. Cada línea está compuesta 
#por el nombre y apellido del alumno, un espacio y su calificación,
#que siempre será apto o no apto. Desea que para cada línea del 
#texto se genere lo siguiente: mailto:direccion@unizar.esbody: 
#nombre apellido nota. Presentados: n, aprobados: m.Además si no 
#se pasa ningún parametro (el fichero de texto con los nombres y calificaciones) 
#muestre un texto de ayuda. 




TOTAL=$(wc -l $1 | cut -f1 -d' ')
NOAPTOS=$(egrep -c 'no apto$' $1)
APTOS=$(($TOTAL - $NOAPTOS))

sed -r 's/^(\w)(\w*) +(\w*) +(.*)/mailto: \1\3@unizar.es Body: \1\2 \3 \4. Presentados: '$TOTAL', Aprobados\/ '$APTOS'/' $1
#problema, necesito añadir variable TOTAL APTOS.. en una ecxpresion
#regular de sed. Pero sed tiene comillas simples!!!!
