#!/bin/bash
# Listar el contenido de un directorio en orden decrecientede tamaño  ls -l | sort

ls -l | sort -d -k 5 -r
#-k 5, indica columna 5
# -r indica reverse
#
