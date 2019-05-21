#!/bin/bash
 Tenemos un directorio que contiene, entre otras cosas, fotos: ficheros con extensión .jpg o .JPG. Las fotos tienen mucha resolución. Queremos reducirlas a 800x600 puntos y publicar la versión reducida en una web. Para reducir el tamaño podemos usar el comandoconvert -geometry 800x600 origen destinoPara publicar en el web, basta copiar al directorio public_html del home del usuario. Suponemos este directorio existente y con los permisos adecuados.Proceden de un sistema contaminado por un virus, así que hay ficheros que a pesar de su extensión,no son imágenes jpeg sino ejecutables. Si son verdaderas imágenes el comando "file" mostrará un mensaje similar a este:imagen01.jpg: JPEG image data, EXIF standard 0.73, 10752 x 2048Haz un script de shell bash que reciba como primer argumento el directorio, que compruebe cada fichero, que lo reduzca y publique si está bien y que lo borre si está contaminado, mostrando un mensaje parecido aeste:imagen01.jpg CONTAMINADO. Se borra el ficheroimagen02.jpg ok. Reducida y publicadaimagen03.jpg ok. Reducida y publicada1 ficheros contaminados y borrados2 ficheros reducidos y publicado


if [$# -ne 1];then
	echo "Uso: $0 directorio"
	exit 1
fi >&2

contaminados=0
publicados=0

for fichero in $(ls $1);do
	if file $fichero | grep 'JPEG';then
		convert-geometry 800 600 $fichero ~/public_html/$fichero
		publicados=$(($publicados + 1))
	else
	contaminadso=$(($contaminados + 1))
	rm -f $fichero
	fi
done

echo $contaminados ficheros contaminados y borrados
echo $publicados reducidos y publicados

