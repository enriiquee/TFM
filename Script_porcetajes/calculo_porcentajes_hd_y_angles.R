list.of.packages <- c("grid", "gridExtra","gridBase" )
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

library("grid"); library("gridExtra"); 

options(warn=-1)

resultados <- read.csv(file.path(getwd(),"cache/resultados_porcentajes_hd.dat"), header=FALSE)
resultados2 <- read.csv(file.path(getwd(),"cache/resultados_porcentajes_angles.dat"), header=FALSE)



#Se establece el directorio de trabajo
#resultados <- read.csv("~/TFM/pruebas/resultados_porcentajes.dat", header=FALSE)
#resultados2 <- read.csv("~/TFM/pruebas/resultados_porcentajes_angulos.dat", header=FALSE)

#setwd("~/adolfo/investigacion/eperez/tray0/")
#setwd("~/TFM/pruebas/")


resultados<- t(resultados)
resultados <- data.frame(resultados)
resultados<- setNames(resultados, c("Nº puentes de hidrógeno","Porcentaje (%)"))

resultados2<- t(resultados2)
resultados2 <- data.frame(resultados2)
resultados2 <- setNames(resultados2, c("Nº de angulos","Porcentaje (%)"))


#sum(resultados2$`Porcentaje (%)`, rows = NULL)

#En esta parte lo que se exporta son las tablas correspondientes a la frecuencia de los datos. 
pdf(file="porcentaje_total.pdf")
grid.arrange(
  tableGrob(resultados, rows = NULL),
  tableGrob(resultados2, rows = NULL),
  nrow=2)

dev.off()

