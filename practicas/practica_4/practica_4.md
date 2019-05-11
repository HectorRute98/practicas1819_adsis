# Memoria práctica 4  
---
Autor: Diego Marco  
Nip: 755232  

## Parte 1: Preparación de las máquinas en VirtualBox
Una vez tengo definida una red de tipo "Host-Only-Network". La máquina host (que en mi caso será mi máquina física), tiene la ip 192.168.56.1. Procedo a incluir los adaptadores de esta red en las máquinas virtuales debian-ghest1 y debian-ghest2. 

## Parte 2: Configuración de las máquinas virtuales
1. Instalo sudo con el comando `sudo apt-get install sudo` y con el comando `visudo`, configuro el fichero  
**/etc/sudo/sudoers** añadiendo la línea *as ALL=(ALL)NOPASSWD:ALL*, para que el usuario as pueda ejecutar cualquier
comando sin necesidad de introducir contraseña.
2. Diagrama de red (Host-Only-Network):
```    _______________                                    _______________
      | debian-ghest2 |                                  | debian-ghest1 |
      |_______________|   ------------------------------ |_______________|
      192.168.56.3                                        192.168.56.2
      08:00:27:cf:9c:61                              -    08:00:27:6b:92:3d
                        -                         -
                          -                     -
                            -  ______________ -
                              | Host         |
                              |______________|
                              192.168.56.1
                              0a:00:27:00:00:00
```
3. Después, dentro de las máquinas guest con el comando `ip addr` descubro que el nombre de adaptador asignado es enp0s8,
(el identificador MAC del adaptador de la red Host-Only-Network coincide con el de enp0s8).
A continuación asigno una ip estática a cada máquina ghest modificando e fichero **etc/network/interfaces** :
```
auto enp0s8
iface enp0s8 inet static
adress 192.168.56.2(debian-ghest1) / 192.168.56.3(debian-ghest2)
netmask 255.255.255.0
broadcast 192.168.56.255
network 192.168.56.0
```
4. Compruebo con los comandos `ip monitor all`, `ip route` y `ip addr`el estado de las máquinas.
5. Finalmente para comprobar también que están activas las dos máquinas pruebo a hacer `ping` desde la máquina host y desde
   las máquinas ghest.
6. Instalo servidor ssh en las máquinas ghest: sudo apt-get install `openssh-server`.
7. Edito el fichero **/etc/ssh/sshd_config** y descomento la linea PermitRootLogin poniendo el valor "no" para evitar una conexión ssh al usuario root.
8. Compruebo que los daemons ssh funcionan correctamente en ambos ghest.

## Parte 3: Preparación de la estructura de autentificación
Para acceder a las máquinas ghest usando ssh con criptografía de clave pública sin usar contraseña.
Primero generamos la clave pública y privada en el host, `ssh-keygen -t ed25519 -f ~/.ssh/id_as_ed25519`, 
-t indica el algoritmo de cifrado, -f indica el fichero destino.
Después compartimos la clave pública con la máquina ghest1: `ssh-copy-id -i ~/.ssh/id_as_ed25519 as@192.168.56.2`.
Finalmente con la máquina ghest2:`ssh-copy-id -i ~/.ssh/id_as_ed25519 as@192.168.56.3`.
