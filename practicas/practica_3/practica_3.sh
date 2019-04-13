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
	     #identifier: identificador usuario de la linea $linea_add
	     password=$(echo $linea_add | cut -d , -f 2)
	     #password: contraseña usuario de la linea $linea_add
	     full_name=$(echo $linea_add | cut -d, -f 3)
	     #full_name: nombre completo usuario de la linea $linea_add
	     if [ -z $identifier ] || [ -z $password ] || [ -z $full_name ];then
		 #caso alguno de los campos está vacío
		 echo "Campo invalido" 
		 exit 1
	     else
		 #caso ningún campo vacío
		 if [ ! id -u $identifier ];then
		    #caso usuario no existe
		    #añadimos usuario
		    useradd -c "$full_name" -d "/home/$identifier" -f 0 -m  -k /etc/skel -K UID_MIN=1815 -U "$identifier"
                    echo "$identifier:$password" | chpasswd
                    passwd -x 30 "$identifier"
		    echo "$full_name ha sido creado"
		 else
	            #caso usuario existe
		    echo "El usuario $identifier ya existe"
		 fi

	     fi

	     
	  done
        elif [ $1 = "-s" ];then
          #caso eliminar usuarios
          mkdir -p /extra/backup
 
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
      else
      #caso $2 no es un fichero
      exit 1
      fi 
   fi 
  exit 0
else 
  #caso no tiene privilegios de administración
  echo "Este script necesita privilegios de administracion" >&2
  exit 1
fi
