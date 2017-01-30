
print("Iniciando script...")
 setwd("~/adolfo/investigacion/eperez/tray0/")
 print("Script iniciado...")
 print("Cargando paquetes necesarios...")
#Instalamos los paquete que sean necesarios. Para automatizar esto realizamos este bucle: 
  list.of.packages <- c("grid", "gridExtra","gridBase" )
 new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
 if(length(new.packages)) install.packages(new.packages)
 
 library("grid"); library("gridExtra"); 
 print("Cargando datos...")
#Se cargan los datos. Convendría hacer un bucle aquí para que vaya recorriendo los archivos.  
#Puentes de hidrógen1
data1 <- read.table("~/adolfo/investigacion/eperez/tray0/cache/cache/hb_medias_01.dat.results.dat.splits", quote="\"", comment.char="")
data2 <- read.table("~/adolfo/investigacion/eperez/tray0/cache/cache/hb_medias_03.dat.results.dat.splits", quote="\"", comment.char="")
data3 <- read.table("~/adolfo/investigacion/eperez/tray0/cache/cache/hb_medias_05.dat.results.dat.splits", quote="\"", comment.char="")
data4 <- read.table("~/adolfo/investigacion/eperez/tray0/cache/cache/hb_medias_07.dat.results.dat.splits", quote="\"", comment.char="")
data5 <- read.table("~/adolfo/investigacion/eperez/tray0/cache/cache/hb_medias_09.dat.results.dat.splits", quote="\"", comment.char="")
data6 <- read.table("~/adolfo/investigacion/eperez/tray0/cache/cache/hb_medias_11.dat.results.dat.splits", quote="\"", comment.char="")
data7 <- read.table("~/adolfo/investigacion/eperez/tray0/cache/cache/hb_medias_13.dat.results.dat.splits", quote="\"", comment.char="")
data8 <- read.table("~/adolfo/investigacion/eperez/tray0/cache/cache/hb_medias_15.dat.results.dat.splits", quote="\"", comment.char="")

#Creamos el data.frame junto: 
df_hb <- cbind(data1, data2, data3, data4, data5, data6, data7, data8)


#Cargamos los ángulos diedros

data1 <- read.table("~/adolfo/investigacion/eperez/tray0/cache/cache/angles_medias_01.dat.results.dat.splits", quote="\"", comment.char="")
data2 <- read.table("~/adolfo/investigacion/eperez/tray0/cache/cache/angles_medias_03.dat.results.dat.splits", quote="\"", comment.char="")
data3 <- read.table("~/adolfo/investigacion/eperez/tray0/cache/cache/angles_medias_05.dat.results.dat.splits", quote="\"", comment.char="")
data4 <- read.table("~/adolfo/investigacion/eperez/tray0/cache/cache/angles_medias_07.dat.results.dat.splits", quote="\"", comment.char="")
data5 <- read.table("~/adolfo/investigacion/eperez/tray0/cache/cache/angles_medias_09.dat.results.dat.splits", quote="\"", comment.char="")
data6 <- read.table("~/adolfo/investigacion/eperez/tray0/cache/cache/angles_medias_11.dat.results.dat.splits", quote="\"", comment.char="")
data7 <- read.table("~/adolfo/investigacion/eperez/tray0/cache/cache/angles_medias_13.dat.results.dat.splits", quote="\"", comment.char="")
data8 <- read.table("~/adolfo/investigacion/eperez/tray0/cache/cache/angles_medias_15.dat.results.dat.splits", quote="\"", comment.char="")
data9 <- read.table("~/adolfo/investigacion/eperez/tray0/cache/cache/angles_medias_17.dat.results.dat.splits", quote="\"", comment.char="")
data10 <- read.table("~/adolfo/investigacion/eperez/tray0/cache/cache/angles_medias_19.dat.results.dat.splits", quote="\"", comment.char="")


#Juntamos los archivos en un data.frame: 

df_ang <- cbind(data1, data2, data3, data4, data5, data6, data7, data8, data9, data10)

#Para encontrar el número que más se repite, aplicamos esta función: 
Mode <- function(x) { 
  ux <- unique(x)
  ux[which.max(tabulate(match(x, ux)))]
}

#Aqui se modifica el 224 si queremos dividirlo por menos o más trayectorias.
#Lo que hace aqauí es calcular las medias y ver cual es el número que se repite más. 
a <- data.frame(rowMeans(df_hb))
b <- apply(df_hb, 1, function(x) sum(x == Mode(x)))/224
c <- data.frame(rowMeans(df_ang))
d <- apply(df_ang, 1, function(x) sum(x == Mode(x)))/224


#Se redondea con 2 cifras significativas y se le asigna nombres a cada columna. 
df_final <- round(data.frame(a, b, c, d), digits = 2)
df_final<- setNames(df_final, c("Mean HB (%)","Nº HB (1-8)", "Mean D.Angle", "Nº D.Angle(1-10)"))

#Se dibuja un gráfico de líneas para saber la variación de las medias de HB y DH. 
plot(df_final$`Nº HB`, type="l", ylim = c(1,8), ylab = "Puentes de hidrógeno formados", xlab = "Tiempo (Fs)", main = "Evolución temporal de los puentes de hidrógeno")
plot(df_final$`Nº HB`, type="l", ylab = "Puentes de hidrógeno formados", xlab = "Tiempo (Fs)", main = "Evolución temporal de los puentes de hidrógeno")

plot(df_final$`Nº D.Angle`, type="l", ylim = c(1,10), ylab = "Angulos diedros formados", xlab = "Tiempo (Fs)",main = "Evolución temporal de los ángulos diedros" )
plot(df_final$`Nº D.Angle`, type="l", ylab = "Angulos diedros formados", xlab = "Tiempo (Fs)", main = "Evolución temporal de los ángulos diedros")

#Este código sirve para crear una lista enumerada de todas las condiciones vs tiempo. 
print("Creando gráfica, puede tardar un poco...")
maxrow = 30; npages = ceiling(nrow(df_final)/maxrow); pdf("Grafica_totals.pdf", height=11, width=8.5); for (i in 1:npages) {idx = seq(1+((i-1)*maxrow), i*maxrow); grid.newpage(); grid.table(df_final[idx, ])}; dev.off()


#En esta parte lo que calculamos es la condición que más se repite. para ello seleccionamos 
#las variables que nos interesa, dividimos por el número de filas. 
e <- df_final$`Nº HB (1-8)`
f <- df_final$`Nº D.Angle(1-10)`

count1 <- table(factor(round(e), levels = 1:8))
count1 <- (count1/3000)*100
count1 <- data.frame(count1)
count1 <- round(count1$Freq, digits = 2)
count1 <- data.frame(count1)
count1 <- data.frame(cbind(1:8, count1))
count1<- setNames(count1, c("Nº puentes de hidrógeno","Porcentaje (%)"))

count2 <- table(factor(round(f), levels = 1:10))
count2 <- (count2/3000)*100
count2 <- data.frame(count2)
count2 <- round(count2$Freq, digits = 2)
count2 <- data.frame(count2)
count2 <- data.frame(cbind(1:10, count2))
count2<- setNames(count2, c("Nº ángulos diedros","Porcentaje (%)"))

#Dibujamos en un diagrama de barras los data.frame generados anteriormente. 
barplot(count1$`Porcentaje (%)`, col = "red", names = count1$`Nº puentes de hidrógeno`, ylim = c(0,100), xlab = "Nº puentes de Hidrógeno", ylab = "Porcentaje (%)", main = "Proporción de HB en la molécula")
barplot(count2$`Porcentaje (%)`, col = "blue", names = count2$`Nº ángulos diedros`, xlab = "Nº ángulos diedros", ylab = "Porcentaje (%)", main = "Proporción de DA en la molécula")

#En esta parte lo que se exporta son las tablas correspondientes a la frecuencia de los datos. 
pdf(file="porcentaje.pdf")
grid.arrange(
  tableGrob(count1, rows = NULL),
  tableGrob(count2, rows = NULL),
  nrow=2)

dev.off()

print("Script finalizado")
##################
#Fin del script. 














 