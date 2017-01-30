# -*- coding: utf-8 -*-
##########################
###generadorAngulos.py###
##########################
from decimal import *

i = 1
while(i <= 19):
    salida = open('cache/angles_medias_'+str(i)+'.dat.results', 'w') 
    with open('cache/angles_medias_'+str(i)+'.dat', 'r') as f:
        for line in f:
            columnas = line.split(' ')
            if(Decimal(columnas[0]) <= -42 and (Decimal(columnas[0])) >= -82 and (Decimal(columnas[1]) <= -21 and Decimal(columnas[1]) >= -61)):
                salida.write("100\n")
            else:
                salida.write("0\n")
    salida.close()
    i+=2