############################
#calculo_porcentajes_hd.py #
############################

from array import *

# aqui es donde almacenaremos el total de puentes hechos por linea
puentes_hechos_por_linea = list()

with open('cache/Final_Evolucion_hb.dat', 'r') as f:
    for line in f:
        otro_contador = line.count('100')
        #Limpiamos la linea de varios espacios seguidos
        for i in range(0, 10):
            line = line.replace("  ", " ")
        
        columnas = line.split()
        contador_de_puentes_hechos = 0

        # Contamos los que son 100 y guardamos
        for columna in columnas:
            if int(columna) == 100:
                contador_de_puentes_hechos += 1
        
        puentes_hechos_por_linea.append(contador_de_puentes_hechos)
        if otro_contador != contador_de_puentes_hechos:
            i = 0
            pass
    i += 1

# Guardamos el sumatorio (por numero de puentes) de los datos de puentes_hechos_por_linea
sumatorio_de_puentes = array('i', [0, 0, 0, 0, 0, 0, 0, 0, 0])

for puentes in puentes_hechos_por_linea:
    sumatorio_de_puentes[int(puentes)] += 1

# sumamos todos los resultados
puentes_totales = 0

# Si queremos cambiar el tamaño hay que cambiar número de longitud
for i in range(0, 9):
    puentes_totales += sumatorio_de_puentes[i]

# Calculamos cuanto porcentaje tenemos de cada uno
porcentajes_finales = list()

for i in range(0, 9):
    porcentajes_finales.append(float(sumatorio_de_puentes[i]) * 100.0 / float(puentes_totales))

porcentaje_total = 0
for porcentaje in porcentajes_finales:
    porcentaje_total += porcentaje

# Output
salida = open('cache/resultados_porcentajes_hd.dat', 'w')

for i in range(0, 8):
    salida.write(str(i+1) + ',')
salida.write('9')

salida.write('\n')

for i in range(0, 8):
    salida.write(str(porcentajes_finales[i]) + ',')
salida.write(str(porcentajes_finales[8]))

salida.close()