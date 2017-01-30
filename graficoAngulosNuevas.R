###################
#grafico_medias.R #			
###################

#Comprobamos mediante este bucle si los paquetes necesarios están instalados...
packages <- c("gridExtra","ggplot2","assertthat", "tidyr", "hexbin", "reshape")
if (length(setdiff(packages, rownames(installed.packages()))) > 0) {
  install.packages(setdiff(packages, rownames(installed.packages())))  }

print("Realizando histogramas... Puede tardar un poco...")
options(warn=-1)

#Cargamos los paquetes que utilizaremos: 
library("ggplot2"); library("tidyr"); library("gridExtra"); library("reshape")

#Establecemos el working directory de donde se van a obtener los datos:
directory <- setwd("/home/eperez/TFM/pruebas/Script_298/Script_medias_angulos_3000/cache/cache")

#Creamos una lista con nuestros ficheros
allTextFiles <- list.files(pattern = ".dat")

#Leemos los ficheros uno a uno con la función lapply. Se crean 10 elementos. 
alldfs <- lapply(allTextFiles, function(x) { 
  textfiles <- read.table(x, quote="\", comment.char="")
})

#Hacemos las medias de cada uno, creando una columna llamada rowmeans. 
medias <- lapply(alldfs, function(x) rowMeans(subset(x,  na.rm = TRUE)))
medias <- lapply(alldfs, function(x) cbind(x,"rowmean"=rowMeans(subset(x), na.rm = TRUE)))

#Separamos las columnas: 
medias <- lapply(x = medias, seq_along(alldfs), function(x, i) {
  assign(paste0("data", i), x[[i]], envir=.GlobalEnv)})

data_final <- cbind(data1$rowmean,data2$rowmean,data3$rowmean,data4$rowmean,data5$rowmean, data6$rowmean,data7$rowmean,data8$rowmean, data9$rowmean, data10$rowmean)

colnames(data_final) <- c("Ang_1", "Ang_2","Ang_3","Ang_4","Ang_5","Ang_6","Ang_7","Ang_8","Ang_","Ang_10")
eje_x <- data.frame(seq(0,2999,1))
eje_x <- eje_x/40
data_final <- cbind(eje_x,data_final)
colnames(data_final) <- c("eje_x","Ang1_Alpha298K", "Ang2_Alpha298K","Ang3_Alpha298K","Ang4_Alpha298K","Ang5_Alpha298K","Ang6_Alpha298K","Ang7_Alpha298K","Ang8_Alpha298K","Ang9_Alpha298K","Ang10_Alpha298K")

#Convertimos mediante función melt
d <- melt(data_final, id.vars="eje_x")

ggplot(d, aes(eje_x,value, col=variable)) + 
  geom_line(alpha=.7) + 
  labs(color="Ángulos Diedros")+
  xlab('Tiempo (Fs)') +
  scale_x_continuous(expand = c(0, 0), limits = c(0,75.000), breaks = seq(0, 75.000, 5)) +
  scale_y_continuous( limits = c(0,100),expand = c(0, 0), breaks = seq(0, 100, 10)) +
  scale_color_manual(values=c("blue", "#FF0066","brown", "orange", "yellow", "#66FF00", "#CC0099", "red", "#56B4E9","#009E73"))+
  ylab('Medias (%)')+
  theme_minimal()

#Histogramas separados. 

ggplot(data_final, aes(eje_x,Ang1_Alpha298K)) + 
  geom_line(alpha=.7) + 
  labs(color="Ángulos Diedros")+
  xlab('Tiempo (Fs)') +
  scale_x_continuous(expand = c(0, 0), limits = c(0,75.000), breaks = seq(0, 75.000, 5)) +
  scale_y_continuous( limits = c(0,100),expand = c(0, 0), breaks = seq(0, 100, 10)) +
  scale_fill_brewer(palette="Set1")+
  ylab('Medias (%)')+
  ggtitle("Ang_HB1_Alpha298K")+
  theme_minimal()




