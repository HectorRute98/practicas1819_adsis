#!/bin/bash
#Obtener una tabla de usuarios del sistema con dos columnas separadas por un espacio "nombre.usuario UID"
#y ordenarlo por UID

cut -f1,3 /etc/passwd -d':' | sort -k2 -n -t':' | tr : ' '
# -f de field en cut, igual que -k en sort
#se especifica separador en todos los comandos necesario
# tr sustitulle los ':' por ' '
