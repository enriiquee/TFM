#!/bin/bash

#####################################################################
##		   SCRIPT PARA LA REALIZACIÓN DE HISTOGRAMAS  				#
#			ANGULOS Y DISTANCIAS DE LOS PUENTES DE H     			#
#																	#
# Para la ejecucion del programa son necesarios los archivos:		#
# -histogram2_angles 												#
# -histogram2_distances												#
#####################################################################

#Eliminamos el contenido de la carpeta WORKING_DIRECTORY
rm -rf $WORKING_DIRECTORY

#Se establece el directorio de trabajo
WORKING_DIRECTORY=`pwd`/cache 

# Creamos el directorio de trabajo
mkdir -p $WORKING_DIRECTORY

# Iteramos sobre los archivos que nos interesan
echo Generando archivos de distancias y angulos...
for path_to_hb_file in $( ls tray*/*hb.dat.gz ); do
    echo $path_to_hb_file

    DISTANCES_FILE=$WORKING_DIRECTORY/distances.dat
    zcat $path_to_hb_file | cut -d' ' -f1,3,5,7,9,11,13,15 >> $DISTANCES_FILE

    ANGLES_FILE=$WORKING_DIRECTORY/angles.dat
    zcat $path_to_hb_file | cut -d' ' -f2,4,6,8,10,12,14,16 >> $ANGLES_FILE
done
echo Archivos generados...

echo Realizando histogramas...
Rscript ./histogram2_distances.r
mv Rplots.pdf Histogramas_distancias.pdf
Rscript ./histogram2_angles.r
mv Rplots.pdf Histogramas_angulos.pdf


if [ $? -eq 0 ]; then
    echo El proceso se ha ejecutado sin errores.
else
    echo ERROR. El proceso no se ha ejecutado correctamente. 
fi

read -p "Pause"
rm -rf ./cache/*
# Eliminar todos los datos del working direcotry



