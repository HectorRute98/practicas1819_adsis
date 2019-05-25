#!/bin/bash
#---------------------------------------------------------------------------------------
#Autor: Diego Marco Beisty
#Nip: 755232
#Coms: A partir de una especificacion obtenida de la entrada estandar, puede crear o extender
#      los volúmenes lógicos y sistemas de ficheros que residan en dichos volumenes
#----------------------------------------------------------------------------------------
OldIFS=$IFS #Guardo el Internal Field Separator
IFS=$',' #Nuevo valor por defecto ','
read nombreGrupoVolumen nombreVolumenLogico tamano tipoSistemaFicheros directorioMontaje
IFS=OldIFS # Reestablezco el antiguo valor por defecto
while [ ! -z $nombreGrupoVolumen ];do
#primer campo no vacío
    existeVG=$(sudo vgscan | grep "$nombreGrupoVolumen")
    if [ -z "$existeVG" ];then
        #caso no existe el grupo volumen
        echo "No existe el grupo volumen $nombreGrupoVolumen"
    fi >&2
    existeVL=$(sudo lgscan | grep "$nombreVolumenLogico")
    if [ -z "$existeVL" ];then
        #caso no existe el volumen logico => lo creo
        #creo el volumen lógico
        sudo lvcreate -L "$tamano" -n "$nombreVolumenLogico" "$nombreGrupoVolumen"
        #Creo el sistema de ficheros asociado al volumen logico
        sudo mkfs -F -t "$tipoSistemaFicheros" /dev/"$nombreGrupoVolumen"/"$nombreVolumenLogico"
        #monto el volumen logico
        sudo mount -t "$tipoSistemaFicheros" /dev/"$nombreGrupoVolumen"/"$nombreVolumenLogico" "$directorioMontaje"
        #lo añado al fichero /etc/fstab para que se monte en cada inicio del sistema
        sudo echo "dev/$nombreGrupoVolumen"/"$nombreVolumenLogico" "$directorioMontaje" "$tipoSistemaFicheros" defaults  0 2\n >> /etc/fstab
    else
        #caso existe el volumen logico => lo expando
        #Extiendo volumen logico
        sudo lvextend -L +"$tamano" "/dev/$nombreGrupoVolumen"/"$nombreVolumenLogico"
        #Extiendo sistema de ficheros del volumen logico
        sudo resize2fs "/dev/$nombreGrupoVolumen/$nombreVolumenLogico"
    fi
read nombreGrupoVolumen nombreVolumenLogico tamano tipoSistemaFicheros directorioMontaje
done
#primer campo vacío, termina la ejecucion
exit 0
