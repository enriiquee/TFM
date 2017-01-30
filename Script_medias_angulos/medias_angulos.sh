#!/bin/bash

#####################################################################
##         SCRIPT PARA VER EVOLUCION DE LAS MEDIAS                  #
#                      LOS ANGULOS                                  #
#                                                                   #
# Para la ejecucion del programa son necesarios los archivos:       #
# -generador.python                                                 #
# -grafico_medias                                                   #
#####################################################################


WORKING_DIRECTORY=`pwd`/cache #Se establece el directorio de trabajo
rm -rf $WORKING_DIRECTORY/*

# Creamos el directorio de trabajo
mkdir -p $WORKING_DIRECTORY

# Creación del archivo Dist | Angul. Iteramos sobre los archivos que nos interesan
for path_to_angles_file in $( ls tray*/*raman.dat.gz ); do
    echo Procesando $path_to_angles_file ... #Imprimimos en pantalla el archivo que se está procesando. 

    #Empieza desde 1 hasta el último(+2) que es 15
    for((current_column=1; current_column <= 19; current_column=current_column+2)); do 
    	current_column_plus_one=$(($current_column+1))
    #Se establece el directorio y el nombre del archivo
    	DISTANCES_FILE=$WORKING_DIRECTORY/angles_medias_$current_column.dat 
    	zcat $path_to_angles_file | awk -v a=$current_column -v b=$current_column_plus_one 'BEGIN{OFS=IFS=" "} { print $a,$b }' >> $DISTANCES_FILE
	done # for (current_column)
done

#Script de python: Te crea los archivos 100/0 dependiendo de las condiciones. 
python ./generador.py

#Corta los archivos generados en 3000

for path_to_angles_file in $( ls cache/angles_medias_*.dat.results ); do
	echo Procesando medias $path_to_angles_file ...
	mkdir -p $WORKING_DIRECTORY/cache

	SPLIT_FILE=$WORKING_DIRECTORY/$path_to_angles_file.dat.splits
	cat $path_to_angles_file | awk -v n=3000 '{data[(NR-1)%n FS int((NR-1)/n)]=$0} END {cols=NR/n; 
	for (i=0;i<n;i++) {for (j=0;j<cols;j++) {printf "%s%s", data[i FS j], FS} print ""}}' >> $SPLIT_FILE
done

#Bucle for para ordenar los resultados añadiendole 0. 

for f in ./cache/cache/angles_medias_?.dat.results.dat.splits; do  
    mv "$f" "${f/_medias_/_medias_0}" ; done

#Ejecutamos el script de R. 
Rscript ./grafico_medias.R

#Renombramos el output de R. 

mv Rplots.pdf grafico_medias_angulos.pdf
#Bucle for para comprobar si se ha terminado con éxito: 

if [ $? -eq 0 ]; then
    echo El proceso se ha ejecutado sin errores.
else
    echo ERROR. El proceso no se ha ejecutado correctamente. 
fi



read -p "Pause"
rm -rf ./cache/*


