##############################################################
#SCRIPT EVOLUCIÓN ANGULOS DIEDROS Y DIAGRAMA DE RAMACHANDRAN #
##############################################################

#Se establece el directorio de trabajo
rm -rf $WORKING_DIRECTORY
WORKING_DIRECTORY=`pwd`/cache 

# Creamos el directorio de trabajo
mkdir -p $WORKING_DIRECTORY

# Iteramos sobre los archivos que nos interesan
for path_to_hb_file in $( ls tray*/*raman.dat.gz ); do
    echo $path_to_hb_file

    DIHEDRAL_ANGLE_FILE=$WORKING_DIRECTORY/dihedral_angle.dat
    zcat $path_to_hb_file | cut -d' ' -f1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20 >> $DIHEDRAL_ANGLE_FILE
done
echo Generación del archivo completada...
#Ejecturamos el Script de R para la realización de histogramas y Ramachandran. 
echo Generando histogramas y Ramachandran...

#Generamos este archivo para la generación del histogramas solapados. 
cat `pwd`/cache/dihedral_angle.dat | cut -d' ' -f1,2,3,4,5,6,7,8,9,10 >> ./cache/angulos1_10.dat
cat `pwd`/cache/dihedral_angle.dat | cut -d' ' -f11,12,13,14,15,16,17,18,19,20 >> ./cache/angulos11_20.dat

Rscript ./diedral_angles.R
mv Rplots.pdf Angulos_diedros_Raman_Histo.pdf

if [ $? -eq 0 ]; then
    echo El proceso se ha ejecutado sin errores.
else
    echo ERROR. El proceso no se ha ejecutado correctamente. 
fi

read -p "Pause"
rm -rf ./cache/*
# Eliminar todos los datos del working direcotry