#!/bin/bash
#A partir del fichero /etc/services obtener una lista 
#ordenada alfabéticamente en todos los servicios, 
#eliminando todos los comentarios y líneas en blanco
sed -r -e '/^#.*/d' -e '/^ *$/d' -e 's/^(\w+).*/\1/' /etc/services
#quito comentarios, quito lineas en blanco, me quedo con primera
# columna
