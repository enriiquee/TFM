####################
#diagramaConjunto.R# 
####################

#Comprobar si los paquete necesarios estAn instalados, si lo están, no los instala: 
list.of.packages <- c("gridExtra","ggplot2","assertthat", "tidyr", "plyr", "gtools")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

#Cargamos los paquetes necesarios:
library(plyr); library(ggplot2); library(gtools); library(data.table)

#Imprimimos por pantalla y eliminamos warnings: 
print("Realizando histogramas... Puede tardar un poco..."); options(warn=-1)

#Leemos los datos. 
data1 <- read.table(file.path(getwd(),"Script_298/Histogram2/cache/distances.dat"), quote="\", comment.char="")
data2 <- read.table(file.path(getwd(),"Script_318/Histogram2/cache/distances.dat"), quote="\", comment.char="")
data3 <- read.table(file.path(getwd(),"Script_extendida_278/Histogram2/cache/distances.dat"), quote="\", comment.char="")
data4 <- read.table(file.path(getwd(),"Script_extendida_298/Histogram2/cache/distances.dat"), quote="\", comment.char="")

# Bucle para añadir NA a los datos que no tenemos. R no permite unir data frame si no poseen el mismo número de filas. 
list.df <- list(data1, data2, data3, data4)
max.rows <- max(unlist(lapply(list.df, nrow), use.names = F))
list.df <- lapply(list.df, function(x) {
  na.count <- max.rows - nrow(x)
  if (na.count > 0L) {
    na.dm <- matrix(NA, na.count, ncol(x))
    colnames(na.dm) <- colnames(x)
    rbind(x, na.dm)
  } else {
    x
  }
})

#Extraemos de la lista los datos generados y los guardamos en una variable: 
data_prueba <- list.df[[1]]; data_prueba2 <- list.df[[2]]; data_prueba3 <- list.df[[3]]; data_prueba4 <- list.df[[4]]

#Creamos una lista mediante un bucle. En ella se van a ir almacenando iterativamente las distintas columnas con los datos que nos interesan. 
res <- lapply(1:8, function(i){ cbind(data_prueba[i], data_prueba2[i], data_prueba3[i], data_prueba4[i]) })

#Extraemos los datos de interés de nuestra lista
data_final1 <- res[[1]]; data_final2 <- res[[2]]; data_final3 <- res[[3]]; data_final4 <- res[[4]] ; data_final5 <- res[[5]]; data_final6 <- res[[6]]; data_final7 <- res[[7]]; data_final8 <- res[[8]]

#Renombramos las columnas y realizamos histogramas, cambiando data_final1 hasta data_final8
df1 <- tidyr::gather(data_final1)
colnames(df1) <- c("HBs",   "value")
ggplot(df1, aes(x = value, fill = HBs)) + 
  geom_histogram(aes(y=..count../sum(..count..)),  colour="black", breaks=seq(0,15,0.1), alpha=0.5, position = "identity") +
  labs(x=expression(d["HB"]), y="Frecuencia")  + geom_vline(xintercept = 2.5, colour="red") +
  scale_x_continuous(expand = c(0.01, 0), breaks = seq(0, 15, 2.5), limits = c(0,15)) +
  scale_y_continuous( limits = c(0,0.025), breaks = seq(0,0.025,0.005)) +
  scale_fill_manual(values = c("red", "green", "blue", "yellow")) + 
  ggtitle("(A)") + theme_minimal()+  theme(legend.position = c(0.9, 0.8), legend.key.size = unit(0.5, "cm")) +
  theme(plot.title = element_text(hjust = -0.1, vjust=2.12))


  



