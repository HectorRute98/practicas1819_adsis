#!/bin/bash
#nombre autor:Diego Marco Beisty
#nip autor: 755232
#Ejecución: practica_4.sh  [-a|-s] <fichero_usuarios> <fichero_máquinas>

cat /etc/shadow &> /dev/null
#intento ejecutar cat sobre un fichero protegido como shadow
#Compruebo el estado de salida del comando
if [ $? -eq 0 ];then
  #caso tiene privilegios de administración
  if [ ! $# -eq 3 ];then
    #caso numero de parametros != 3
    echo "Numero incorrecto de parametros"
  else
    #caso numero de parametros == 3
    #------------GESTIÓN FICHERO IP's------------------------
    lineas2=$(cat $3)
         echo "$lineas2" | while read linea_ip;do
			echo "hola"
            #intento conectarme a la máquina de ip "$linea_ip", ejecutando un comando por probar
            ssh -i ~/.ssh/id_as_ed25519 as@"$linea_ip" pwd &> /dev/null
            if [ ! $? -eq 0 ];then
                #caso no se ha podido conectar a la máquina
                echo "$linea_ip no es accesible"
               # exit 1
            else
                #caso se ha podido acceder a la máquina
                lineas=$(cat $2)
                if [ $1 = "-a" ];then
                    #caso añadir usuarios
	                echo "$lineas" | while read linea_add;do
	                    identifier=$(echo $linea_add | cut -d , -f 1)
	                    #identifier: identificador usuario de la linea $linea_add
	                    password=$(echo $linea_add | cut -d , -f 2)
	                    #password: contraseña usuario de la linea $linea_add
	                    full_name=$(echo $linea_add | cut -d, -f 3)
	                    #full_name: nombre completo usuario de la linea $linea_add
	                    if [ -z "$identifier" ] || [ -z "$password" ] || [ -z "$full_name" ];then
		                    #caso alguno de los campos está vacío
		                    echo "Campo invalido"
		                    exit 1
	                    else
		                    #caso ningún campo vacío
		                     ssh -i ~/.ssh/id_as_ed25519 as@"$linea_ip" id -u "$identifier" &> /dev/null
		                    if [ ! $? -eq 0  ];then
		                        #caso usuario no existe
		                        #añadimos usuario
		                       ssh -i ~/.ssh/id_as_ed25519 as@"$linea_ip" sudo useradd -c "$full_name" -d "/home/$identifier" -f 0 -m  -k /etc/skel -K UID_MIN=1815 -U "$identifier"
                                echo "$identifier:$password" | ssh -i ~/.ssh/id_as_ed25519 as@"$linea_ip" sudo chpasswd
                                ssh -i ~/.ssh/id_as_ed25519 as@"$linea_ip" sudo passwd -x 30 "$identifier" &> /dev/null
		                        echo "$full_name ha sido creado"
		                    else
	                            #caso usuario existe
		                        echo "El usuario $identifier ya existe"
		                    fi
	                    fi
	                done
                elif [ $1 = "-s" ];then
                    #caso eliminar usuarios
                    ssh -i ~/.ssh/id_as_ed25519 as@"$linea_ip" sudo mkdir -p /extra/backup
                    echo "$lineas" | while  read linea_del ;do
                        identifier=$(echo $linea_del | cut -d , -f 1)
	                    #Bloqueo contraseña de usuario
	                    ssh -i ~/.ssh/id_as_ed25519 as@"$linea_ip" sudo usermod -L "$identifier"
                        #comprimo directorio home de $user_name y hago backup
                        ssh -i ~/.ssh/id_as_ed25519 as@"$linea_ip"  tar -cf "$identifier.tar" "/home/$identifier" &> /dev/null
                       ssh -i ~/.ssh/id_as_ed25519 as@"$linea_ip"  sudo mv $identifier.tar /extra/backup/
                        if [ $? -eq 0 ];then
	                        #caso se ha podido hacer el backup
                            ssh -i ~/.ssh/id_as_ed25519 as@"$linea_ip" sudo userdel -r -f $identifier &> /dev/null
                        fi
                    done
                else
                    #caso primer parametro distinto de [-a|-b]
                    echo "Opcion invalida" >&2
                    exit 1
                fi
              fi
            done
            fi
            exit 0
     else
        #caso no tiene privilegios de administración
        echo "Este script necesita privilegios de administracion"
        exit 1
     fi
