#!/bin/bash

#####################################################################
##      # SCRIPT PARA LA REALIZACIÓN DE MEDIAS  PUENTES H           #
#                                                                   #
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


# Creación del archivo Phi | Psi. Iteramos sobre los archivos que nos interesan
for path_to_hb_file in $( ls tray*/*raman.dat.gz ); do
    echo Procesando $path_to_hb_file ... #Imprimimos en pantalla el archivo que se está procesando. 

    #Empieza desde 1 hasta el último(+2) que es 15
    for((current_column=1; current_column <= 19; current_column=current_column+2)); do 
        current_column_plus_one=$(($current_column+1))

        DISTANCES_FILE=$WORKING_DIRECTORY/angles_medias_$current_column.dat #Se establece el directorio y el nombre del archivo
        zcat $path_to_hb_file | awk -v a=$current_column -v b=$current_column_plus_one 'BEGIN{OFS=IFS=" "} { print $a,$b }' >> $DISTANCES_FILE
    done # for (current_column)
done



#Script de python: Te crea los archivos 100/0 dependiendo de las condiciones. 
echo Generando datos... Puede tardar un poco. 
python ./generador_total.py


#Bucle for para ordenar los resultados añadiendole 0. 

for f in cache/hb_medias_?.dat.results; do 
    mv "$f" "${f/_medias_/_medias_0}" ; done

for f in cache/angles_medias_?.dat.results ; do 
    mv "$f" "${f/_medias_/_medias_0}" ; done


#Código para pegar los resultados de los distintos puentes de hidrógeno y los ángulos. 

paste cache/angles_medias_*.dat.results | column -s $'\t' -t >> cache/Final_Evolucion_angles.dat

paste cache/hb_medias_*.dat.results | column -s $'\t' -t >> cache/Final_Evolucion_hb.dat


python ./calculo_porcentajes_hd.py
python ./calculo_porcentajes_angles.py  

Rscript ./calculo_porcentajes_hd_y_angles.R 

if [ $? -eq 0 ]; then
    echo El proceso se ha ejecutado sin errores.
else
    echo ERROR. El proceso no se ha ejecutado correctamente. 
fi

read -p "¿Desea eliminar los archivos de Cache?"
rm -rf ./cache/*