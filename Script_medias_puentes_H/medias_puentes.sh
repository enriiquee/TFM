#!/bin/bash

#####################################################################
##		# SCRIPT PARA LA REALIZACIÓN DE MEDIAS 	PUENTES H			#
#																	#
#####################################################################


WORKING_DIRECTORY=`pwd`/cache #Se establece el directorio de trabajo
rm -rf $WORKING_DIRECTORY/*
# Creamos el directorio de trabajo
mkdir -p $WORKING_DIRECTORY

# Creación del archivo Dist | Angul. Iteramos sobre los archivos que nos interesan
for path_to_hb_file in $( ls tray*/*hb.dat.gz ); do
    echo Procesando $path_to_hb_file ... #Imprimimos en pantalla el archivo que se está procesando. 

    #Empieza desde 1 hasta el último(+2) que es 15
    for((current_column=1; current_column <= 15; current_column=current_column+2)); do 
    	current_column_plus_one=$(($current_column+1))

    	DISTANCES_FILE=$WORKING_DIRECTORY/hb_medias_$current_column.dat #Se establece el directorio y el nombre del archivo
    	zcat $path_to_hb_file | awk -v a=$current_column -v b=$current_column_plus_one 'BEGIN{OFS=IFS=" "} { print $a,$b }' >> $DISTANCES_FILE
	done # for (current_column)
done

#Script de python: Te crea los archivos 100/0 dependiendo de las condiciones. 
echo Ejecutando python Script... Puede tardar un poco. 
python ./generador_puentes.py

#Corta los archivos generados en 3000

for path_to_hb_file in $( ls cache/hb_*.dat.results ); do
	echo Procesando medias $path_to_hb_file ...
	mkdir -p $WORKING_DIRECTORY/cache

	SPLIT_FILE=$WORKING_DIRECTORY/$path_to_hb_file.dat.splits
	cat $path_to_hb_file | awk -v n=3000 '{data[(NR-1)%n FS int((NR-1)/n)]=$0} END {cols=NR/n; 
	for (i=0;i<n;i++) {for (j=0;j<cols;j++) {printf "%s%s", data[i FS j], FS} print ""}}' >> $SPLIT_FILE


done

#Bucle for para ordenar los resultados 

for f in cache/cache/hb_medias_?.dat.results.dat.splits ; do 
    mv "$f" "${f/_medias_/_medias_0}" ; done

#Rscript para la realizacion de las medias: 

Rscript ./grafico_medias.R

mv ./cache/cache/Rplots.pdf Grafico_medias_H.pdf

if [ $? -eq 0 ]; then
    echo El proceso se ha ejecutado sin errores.
else
    echo ERROR. El proceso no se ha ejecutado correctamente. 
fi

read -p "¿Desea eliminar los archivos de Cache?"
rm -rf ./cache/*
