###################
#grafico_medias.R #			
###################

#Comprobamos mediante este bucle si los paquetes necesarios están instalados...
packages <- c("gridExtra","ggplot2","assertthat", "tidyr", "hexbin", "reshape")
if (length(setdiff(packages, rownames(installed.packages()))) > 0) {
  install.packages(setdiff(packages, rownames(installed.packages())))  }

print("Realizando histogramas... Puede tardar un poco..."); options(warn=-1)

#Cargamos los paquetes que utilizaremos: 
library("ggplot2"); library("tidyr"); library("gridExtra"); library("reshape")

#Creamos una lista con nuestros ficheros
allTextFiles <- list.files(pattern = ".dat")

#Leemos los ficheros uno a uno con la función. Se crean 10 elementos. 
alldfs <- lapply(allTextFiles, function(x) { 
  textfiles <- read.table(x, quote="\", comment.char="")
})

#Hacemos las medias de cada uno, creando una columna llamada rowmeans. 
medias <- lapply(alldfs, function(x) rowMeans(subset(x,  na.rm = TRUE)))
medias <- lapply(alldfs, function(x) cbind(x,"rowmean"=rowMeans(subset(x), na.rm = TRUE)))

#Separamos las columnas: 
medias <- lapply(x = medias, seq_along(alldfs), function(x, i) {
  assign(paste0("data", i), x[[i]], envir=.GlobalEnv)
})

#Extraemos las medias
data_final <- cbind(data1$rowmean,data2$rowmean,data3$rowmean,data4$rowmean,data5$rowmean, data6$rowmean,data7$rowmean,data8$rowmean)
#Creamos nueva columna con el tiempo
eje_x <- data.frame(seq(0,5999,1))
eje_x <- eje_x/40
data_final <- cbind(eje_x,data_final)
colnames(data_final) <- c("eje_x","HB1_Alpha298K", "HB2_Alpha298K","HB3_Alpha298K","HB4_Alpha298K","HB5_Alpha298K","HB6_Alpha298K","HB7_Alpha298K","HB8_Alpha298K")

#Representamos histogramas. 
d <- melt(data_final, id.vars="eje_x")

ggplot(d, aes(eje_x,value, col=variable)) + 
  geom_line(alpha=.7) +   labs(color="HBs")+
  scale_color_discrete("HBs")+  xlab('Tiempo (Fs)') +
  scale_x_continuous(expand = c(0, 0), limits = c(0,150.000), breaks = seq(0, 150.000, 15)) +
  scale_y_continuous( limits = c(0,100),expand = c(0, 0), breaks = seq(0, 100, 10)) +
  scale_color_manual(values=c("blue", "#FF0066","brown", "orange", "yellow", "#66FF00", "#CC0099", "red"))+
  ylab('Medias (%)')+  theme_minimal()

