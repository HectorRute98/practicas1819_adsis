#!/bin/bash
#Nombre autor: Diego Marco
#NIP autor: 755232
#-----------------------------------almaceno directorios con mismo patron-------------------------
dirs=$(find $HOME -name bin???)
if [ -z "$dirs" ];then 
  #caso ningun directorio con mismo patron
  ruta=$(mktemp -d $HOME/binXXX)
  echo "Se ha creado el directorio $ruta"
else
  #caso uno o mas directorios con mismo patron
  ruta=$(stat -c "%n,%Y" $dirs | sort -n -t , -k 2 | grep -o ".*," | tr -d "," | head -n 1)
fi
echo "Directorio destino de copia: "$ruta""

   contador=0
for var in $(ls);do
  if [ -f $var ] && [ -x $var ];then
    cp "$var" "$ruta"
    echo "./$var ha sido copiado a $ruta"
   contador=$(($contador + 1))
  fi
done
if [ $contador -eq 0 ];then
  "No se ha copiado ningun archivo"
else
  echo "Se han copiado $contador archivos"
fi
rm -r "$ruta"

