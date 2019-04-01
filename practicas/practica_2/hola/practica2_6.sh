#!/bin/bash
#Nombre autor: Diego Marco
#NIP autor: 755232

#--------------------------creo fichero temporal----------------------------------------------
file=$(mktemp -d $HOME/binXXX)
echo "Se ha creado el directorio $file"
#--------------------------Compruebo que es el directorio destino-----------------------------
echo "Directorio destino de copia: $file"
#--------------------------Cuento ficheros ejecutables----------------------------------------
contador=0
for var in $(ls);do
  if [ -x $var ] && [ -f $var ];then
    contador=$(($contador + 1))
  fi
done
#--------------------------Copio ficheros ejecutables------------------------------------------
if [ "$contador" -eq "1" ];then
  #caso 0 ficheros ejecutables aparte de este en el directorio actual
  echo "No se ha copiado ningun archivo"
else
  #caso 1 o mas ficheros ejecutables en el directorio actual
  for var in $(ls);do
    if [ -x $var ] && [ -f $var ];then
      cp "$var" "$file"
      echo "./$var ha sido copiado a $file"
    fi
  done
  echo "Se han copiado $contador archivos"
fi
rm -r "$file"
