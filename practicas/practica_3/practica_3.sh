#!/bin/bash
#nombre autor:Diego Marco Beisty
#nip autor: 755232
cat /etc/shadow &> /dev/null
#intento ejecutar cat sobre un fichero protegido como shadow
#Compruebo el estado de salida del comando
if [ $? -eq 0 ];then
  #caso tiene privilegios de administración
  if [ ! $# -eq 2 ];then
    #caso numero de parametros != 2
    echo "Numero incorrecto de parametros"
  else
    #caso numero de parametros == 2
    lineas=$(cat $2)
    if [ $? -eq 0 ];then
       #caso $2 es un fichero
       if [ $1 = "-a" ];then
          #caso añadir usuarios
	  echo "$lineas" | while read linea_add;do
	     identifier=$(echo $linea_add | cut -d , -f 1)
	     #identifier: identificador usuario -> fila linea_add, fichero $2
	     password=$(echo $linea_add | cut -d , -f 2)
	     #password: contraseña usuario -> fila linea_add, fichero $2
	     full_name=$(echo $linea_add | cut -d, -f 3)
	     #full_name: nombre completo usuario -> fila linea_add, fichero $121
	     if [ -z identifier ] || [ -z password ] || [ -z full_name ];then
		 echo "Campo invalido"
		 exit 1
             fi
	  done
       elif [ $1 = "-s" ];then
          #caso eliminar usuarios
          mkdir /extra &> /dev/null
          mkdir /extra/backup &> /dev/null
 
          echo "$lineas" | while  read linea_del ;do
             identifier=$(echo $linea_del | cut -d , -f 1)
             #user_name: nombre de usuario leido de $2
             #comprimo directorio home de $user_name y hago backup
             tar -cf "$user_name.tar" "/home/$user_name" &> /dev/null 
             cp $user_name.tar /extra/backup/
             if [ $? -eq 0 ];then
	       #caso se ha podido hacer el backup
               userdel -r $user_name &> /dev/null
             fi
          done
        else
          #caso primer parametro distinto de [-a|-b]
          echo "Opcion invalida" >&2
        fi
      fi 
   fi 
  exit 0
else 
  #caso no tiene privilegios de administración
  echo "Este script necesita privilegios de administracion" >&2
  exit 1
fi
