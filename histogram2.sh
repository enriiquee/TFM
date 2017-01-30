#!/bin/bash
#############################################
#Script histogramas angulos y distancias HP#
#############################################

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
#Cogemos las columnas que nos interesan
    DISTANCES_FILE=$WORKING_DIRECTORY/distances.dat
    zcat $path_to_hb_file | cut -d' ' -f1,3,5,7,9,11,13,15 >> $DISTANCES_FILE

    ANGLES_FILE=$WORKING_DIRECTORY/angles.dat
    zcat $path_to_hb_file | cut -d' ' -f2,4,6,8,10,12,14,16 >> $ANGLES_FILE
done
echo Archivos generados...
#Ejecutamos script de R
echo Realizando histogramas...
Rscript ./histogram2_HP.r
mv Rplots.pdf Histogramas_comparativa.pdf

if [ $? -eq 0 ]; then
    echo El proceso se ha ejecutado sin errores.
else
    echo ERROR. El proceso no se ha ejecutado correctamente. 
fi
# Eliminar todos los datos del working directory
read -p "Pause"
rm -rf ./cache/*




