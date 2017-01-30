##############################################

#Script para la realizaci?n de histogramas de Distancias

############################################

#Comprobamos mediante este bucle si los paquetes necesarios están instalados...
packages <- c("gridExtra","ggplot2","assertthat", "tidyr")
if (length(setdiff(packages, rownames(installed.packages()))) > 0) {
  install.packages(setdiff(packages, rownames(installed.packages())))  }

#Cargamos los paquetes que utilizaremos: 
library("ggplot2")
library("tidyr")
library("gridExtra")
library("assertthat")


#Cargamos datos
data <- read.table("~/adolfo/investigacion/eperez/tray0/cache/distances.dat", quote="\"", comment.char="")
#A?adimos nombres a las columnas. 
colnames(data) <- c("HB1",   "HB2", "HB3","HB4",  'HB5', 'HB6', 'HB7', "HB8")

#Bucle para realizar los histogramas: 
out<-list()
for (i in 1:8){
  x = data[,i]
  out[[i]] <- ggplot(data.frame(x), aes(x)) + 
  geom_histogram(aes(y=..count../sum(..count..)), fill="red", lwd=0.9, breaks=seq(0,12.0,0.1), col=("black"), 
  alpha=I(.9)) + 
  ggtitle('HB') +
  labs(x=expression(d["HB"]), y="Frecuencia") + 
  geom_vline(xintercept = 2.5 )
  grid.arrange(out[[i]],  ncol=1)
}
#Una manera de realizar los histogramas de golpe y por separado desde el data.frame: 
# ggplot(melt(data),aes(x=value)) + geom_histogram(aes(y=..count../sum(..count..)), fill="red", lwd=0.9, breaks=seq(0,5,0.1), col=("black"), 
# alpha=I(.9)) + facet_wrap(~variable) + labs(x=expression(d["HB"]), y="Frecuencia")

#Para realizar el histograma con todos los datos: 

df2 <- tidyr::gather(data)
colnames(df2) <- c("HBs",   "value")
ggplot(df2, aes(x = value, fill = HBs)) + 
  geom_histogram(aes(y=..count../sum(..count..)), breaks=seq(0,12,0.1), alpha=.6, position = "identity") +
  labs(x=expression(d["HB"]), y="Frequency")  + geom_vline(xintercept = 2.5)
