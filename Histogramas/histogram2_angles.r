########################################################
#Script para la realizaci?n de histogramas de angulos
########################################################

#Comprobar si los paquete necesarios estAn instalados: 
list.of.packages <- c("gridExtra","ggplot2","assertthat", "tidyr" )
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

#Cargar paquetes
library(gridExtra)
library(ggplot2)
library(assertthat)
library(tidyr)

#Cargamos datos
data <- read.table("~/adolfo/investigacion/eperez/tray0/cache/angles.dat", quote="\"", comment.char="")

#A?adimos nombres a las columnas. 
colnames(data) <- c("Ang1",   "Ang2", "Ang3","Ang4",  'Ang5', 'Ang6', 'Ang7', "Ang8")

#Bucle para realizar los histogramas: 
out<-list()
for (i in 1:8){
  x = data[,i]
  out[[i]] <- ggplot(data.frame(x), aes(x)) + 
    geom_histogram(aes(y=..count../sum(..count..)), fill="red",color="black", lwd=0.9, breaks=seq(0,200,2), alpha=I(.9)) + 
    labs(x=expression(d["HB"]), y="Frecuencia") + 
    geom_vline(xintercept = 120) + 
    geom_vline(xintercept = 180)
  grid.arrange(out[[i]],  ncol=1)
}

#Una manera de realizar los histogramas de golpe y por separado desde el data.frame: 
# ggplot(melt(data),aes(x=value)) + geom_histogram(aes(y=..count../sum(..count..)), fill="red", lwd=0.9, breaks=seq(0,5,0.1), col=("black"), 
# alpha=I(.9)) + facet_wrap(~variable) + labs(x=expression(d["HB"]), y="Frecuencia")

#Para realizar el histograma con todos los datos: 

df2 <- tidyr::gather(data)
colnames(df2) <- c("Angs",   "value")
ggplot(df2, aes(x = value, fill = Angs)) + 
  geom_histogram(aes(y=..count../sum(..count..)), breaks=seq(0,200,2), alpha=.6, position = "identity") +
  labs(x=expression(Ang["HB"]), y="Frequency")  + geom_vline(xintercept = 120) + geom_vline(xintercept = 180)
