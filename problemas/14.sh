#!/bin/bash
#Obtener la fecha con formato mes día, año
#ESTA MAL, ARREGLAR
date | sed -r 's/^[^ ]* +([^ ]+) ([^ ]+).*([0-9]+$/\1 \2, \3/' texto  
