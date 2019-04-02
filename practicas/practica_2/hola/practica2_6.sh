#!/bin/bash
#Nombre autor: Diego Marco
#NIP autor: 755232
#-----------------------------------busco directorios con mismo patron-------------------------
dirs=$(find $HOME -name bin???)
if [ -z "$dirs" ];then 
  #caso ningun directorio con mismo patron
  ruta=$(mktemp -d $HOME/binXXX)
  echo "Se ha creado el directorio $ruta"
else
  #caso uno o mas directorios con mismo patron
  ruta=$(stat -c "%n,%Y" $dirs | sort -n -t , -k 2 | grep -o ".*," | tr -d "," | head -n 1)
  #1.stat -> directorios y tiempo última modificación:                           directorio1,45 \n directorio2,32
  #2.sort -> directorios ordenados, menor tiempo desde última modificacion       directorio2,32 \n directorio1,45
  #3.grep -> Hago matching con la ruta del directorio                            directorio2, \n directorio1,
  #4.tr   -> elimino la coma del final                                           directorio2 \n directorio1
  #5.head -> Me quedo con la primera linea                                       directorio2
fi
echo "Directorio destino de copia: $ruta"
#-----------------------------------copio ficheros a directorio temporal------------------------
   contador=0
for var in $(ls);do
  if [ -f "$var" ] && [ -x "$var" ];then
    cp "$var" "$ruta"
    echo "./"$var" ha sido copiado a $ruta"
   contador=$(($contador + 1))
  fi
done
if [ $contador -eq 0 ];then
  #caso ningún archivo ejecutable en el directorio actual
  echo "No se ha copiado ningun archivo"
else
  #caso $contador archivos ejecutables en el directorio actual
  echo "Se han copiado $contador archivos"
fi
#rm -r "$ruta"

