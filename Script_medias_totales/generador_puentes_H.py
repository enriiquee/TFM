# -*- coding: utf-8 -*-
"""
Created on Thu Jun 16 09:13:22 2016

@author: enriq
"""

from decimal import *
i = 1
while(i <= 15):
    salida = open('cache/hb_medias_'+str(i)+'.dat.results', 'w') 
    with open('cache/hb_medias_'+str(i)+'.dat', 'r') as f:
        for line in f:
            columnas = line.split(' ')
            if(Decimal(columnas[0]) < 2.5 and (Decimal(columnas[1]) >= 120 and Decimal(columnas[1]) <= 180)):
                salida.write("100\n")
            else:
                salida.write("0\n")
    salida.close()
    i+=2

