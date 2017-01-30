

#Comprobamos mediante este bucle si los paquetes necesarios están instalados...
packages <- c("gridExtra","ggplot2","assertthat", "tidyr", "hexbin", "reshape")
if (length(setdiff(packages, rownames(installed.packages()))) > 0) {
  install.packages(setdiff(packages, rownames(installed.packages())))  }

print("Realizando histogramas... Puede tardar un poco...")

options(warn=-1)
#Cargamos los paquetes que utilizaremos: 
library("ggplot2"); library("tidyr"); library("gridExtra"); library("reshape")

#Establecemos el working directory de donde se van a obtener los datos:
directory <- setwd("/home/eperez/TFM/pruebas/Script_298/Script_medias_puentes_H_3000/cache")

#Creamos una lista con nuestros ficheros
allTextFiles <- list.files(pattern = ".dat")
allTextFiles
#Leemos los ficheros uno a uno con la función. Se crean 10 elementos. 
alldfs <- lapply(allTextFiles, function(x) { 
  textfiles <- read.table(x, quote="\"", comment.char="")
})

#Hacemos las medias de cada uno, creando una columna llamada rowmeans. 
medias <- lapply(alldfs, function(x) rowMeans(subset(x,  na.rm = TRUE)))
medias <- lapply(alldfs, function(x) cbind(x,"rowmean"=rowMeans(subset(x), na.rm = TRUE)))

#Separamos las columnas: 
medias <- lapply(x = medias, seq_along(alldfs), function(x, i) {
  assign(paste0("data", i), x[[i]], envir=.GlobalEnv)
})



data_final <- cbind(data1$rowmean,data2$rowmean,data3$rowmean,data4$rowmean,data5$rowmean, data6$rowmean,data7$rowmean,data8$rowmean)

colnames(data_final) <- c("HB1", "HB2","HB3","HB4","HB5","HB6","HB7","HB8")
eje_x <- data.frame(seq(0,2999,1))
eje_x <- eje_x/40
data_final <- cbind(eje_x,data_final)
colnames(data_final) <- c("eje_x","HB1", "HB2","HB3","HB4","HB5","HB6","HB7","HB8")

#Convertimos mediante 
d <- melt(data_final, id.vars="eje_x")

pdf(file = "Evolucion_temporal_H.pdf", width = 20, height = 15)

ggplot(d, aes(eje_x,value, col=variable)) + 
  geom_line(alpha=.7) + 
  labs(color="HBs")+
  scale_color_discrete("HBs")+
  xlab('Tiempo (fs)') +
  scale_x_continuous(expand = c(0.01, 0.5), limits = c(0,75.000), breaks = seq(0, 75.000, 25)) +
  scale_y_continuous( limits = c(0,100), expand = c(0.01, 0.5),breaks = seq(0, 100, 20)) +
  scale_color_manual(values=c("blue", "#FF0066","brown", "orange", "yellow", "#66FF00", "#CC0099", "red"))+
  ylab('Medias (%)')+
  ggtitle("(A)") +
  theme_minimal() +
  theme(legend.key.size = unit(2.0, "cm"), legend.text=element_text(size=50), legend.title=element_text(size=50),  
  plot.title = element_text(hjust = 0.05, vjust=1.20, size = 50), 
  axis.text.x = element_text(colour="black",size=60,angle=0,hjust=.5,vjust=.5,face="plain"),
  axis.text.y = element_text(colour="black",size=60,angle=0,hjust=1,vjust=0,face="plain"),  
  axis.title.x = element_text(colour="black",size=60,angle=0,hjust=.5,vjust=0,face="plain"),
  axis.title.y = element_text(colour="black",size=60,angle=90,hjust=.5,vjust=.5,face="plain"))


#Histogramas separados. 

ggplot(data_final, aes(eje_x,HB1)) + 
  geom_line(alpha=.7) + 
  labs(color="HBs")+
  scale_color_discrete("HBs")+
  xlab('Tiempo (fs)') +
  scale_x_continuous(expand = c(0.01, 0.5), limits = c(0,75.000), breaks = seq(0, 75.000, 25)) +
  scale_y_continuous( limits = c(0,100), expand = c(0.01, 0.5),breaks = seq(0, 100, 20)) +
  scale_fill_brewer(palette="Set1")+
  ylab('Medias (%)')+
  ggtitle("HB1_Alpha298K")+
  theme_minimal()+
  theme(plot.title = element_text(hjust = 0.05, vjust=1.20, size = 50), 
  axis.text.x = element_text(colour="black",size=60,angle=0,hjust=.5,vjust=.5,face="plain"),
  axis.text.y = element_text(colour="black",size=60,angle=0,hjust=1,vjust=0,face="plain"),  
  axis.title.x = element_text(colour="black",size=60,angle=0,hjust=.5,vjust=0,face="plain"),
  axis.title.y = element_text(colour="black",size=60,angle=90,hjust=.5,vjust=.5,face="plain")) 

ggplot(data_final, aes(eje_x,HB2)) + 
  geom_line(alpha=.7) + 
  labs(color="HBs")+
  scale_color_discrete("HBs")+
  xlab('Tiempo (fs)') +
  scale_x_continuous(expand = c(0.01, 0.5), limits = c(0,75.000), breaks = seq(0, 75.000, 25)) +
  scale_y_continuous( limits = c(0,100), expand = c(0.01, 0.5),breaks = seq(0, 100, 20)) +
  scale_fill_brewer(palette="Set1")+
  ylab('Medias (%)')+
  ggtitle("HB2_Alpha298K")+
  theme_minimal()+
  theme(plot.title = element_text(hjust = 0.05, vjust=1.20, size = 50), 
  axis.text.x = element_text(colour="black",size=60,angle=0,hjust=.5,vjust=.5,face="plain"),
  axis.text.y = element_text(colour="black",size=60,angle=0,hjust=1,vjust=0,face="plain"),  
  axis.title.x = element_text(colour="black",size=60,angle=0,hjust=.5,vjust=0,face="plain"),
  axis.title.y = element_text(colour="black",size=60,angle=90,hjust=.5,vjust=.5,face="plain"))

ggplot(data_final, aes(eje_x,HB3)) + 
  geom_line(alpha=.7) + 
  labs(color="HBs")+
  scale_color_discrete("HBs")+
  xlab('Tiempo (fs)') +
  scale_x_continuous(expand = c(0.01, 0.5), limits = c(0,75.000), breaks = seq(0, 75.000, 25)) +
  scale_y_continuous( limits = c(0,100), breaks = seq(0, 100, 10)) +
  scale_fill_brewer(palette="Set1")+
  ylab('Medias (%)')+
  ggtitle("HB3_Alpha298K")+
  theme_minimal()+
  theme(plot.title = element_text(hjust = 0.05, vjust=1.20, size = 50), 
  axis.text.x = element_text(colour="black",size=60,angle=0,hjust=.5,vjust=.5,face="plain"),
  axis.text.y = element_text(colour="black",size=60,angle=0,hjust=1,vjust=0,face="plain"),  
  axis.title.x = element_text(colour="black",size=60,angle=0,hjust=.5,vjust=0,face="plain"),
  axis.title.y = element_text(colour="black",size=60,angle=90,hjust=.5,vjust=.5,face="plain"))

ggplot(data_final, aes(eje_x,HB4)) + 
  geom_line(alpha=.7) + 
  labs(color="HBs")+
  scale_color_discrete("HBs")+
  xlab('Tiempo (fs)') +
  scale_x_continuous(expand = c(0.01, 0.5), limits = c(0,75.000), breaks = seq(0, 75.000, 25)) +
  scale_y_continuous( limits = c(0,100), breaks = seq(0, 100, 10)) +
  scale_fill_brewer(palette="Set1")+
  ylab('Medias (%)')+
  ggtitle("HB4_Alpha298K")+
  theme_minimal()+
  theme(plot.title = element_text(hjust = 0.05, vjust=1.20, size = 50), 
  axis.text.x = element_text(colour="black",size=60,angle=0,hjust=.5,vjust=.5,face="plain"),
  axis.text.y = element_text(colour="black",size=60,angle=0,hjust=1,vjust=0,face="plain"),  
  axis.title.x = element_text(colour="black",size=60,angle=0,hjust=.5,vjust=0,face="plain"),
  axis.title.y = element_text(colour="black",size=60,angle=90,hjust=.5,vjust=.5,face="plain"))

ggplot(data_final, aes(eje_x,HB5)) + 
  geom_line(alpha=.7) + 
  labs(color="HBs")+
  scale_color_discrete("HBs")+
  xlab('Tiempo (fs)') +
  scale_x_continuous(expand = c(0.01, 0.5), limits = c(0,75.000), breaks = seq(0, 75.000, 25)) +
  scale_y_continuous( limits = c(0,100), breaks = seq(0, 100, 10)) +
  scale_fill_brewer(palette="Set1")+
  ylab('Medias (%)')+
  ggtitle("HB5_Alpha298K")+
  theme_minimal()+
  theme(plot.title = element_text(hjust = 0.05, vjust=1.20, size = 50), 
  axis.text.x = element_text(colour="black",size=60,angle=0,hjust=.5,vjust=.5,face="plain"),
  axis.text.y = element_text(colour="black",size=60,angle=0,hjust=1,vjust=0,face="plain"),  
  axis.title.x = element_text(colour="black",size=60,angle=0,hjust=.5,vjust=0,face="plain"),
  axis.title.y = element_text(colour="black",size=60,angle=90,hjust=.5,vjust=.5,face="plain"))

ggplot(data_final, aes(eje_x,HB6)) + 
  geom_line(alpha=.7) + 
  labs(color="HBs")+
  scale_color_discrete("HBs")+
  xlab('Tiempo (fs)') +
  scale_x_continuous(expand = c(0.01, 0.5), limits = c(0,75.000), breaks = seq(0, 75.000, 25)) +
  scale_y_continuous( limits = c(0,100), breaks = seq(0, 100, 10)) +
  scale_fill_brewer(palette="Set1")+
  ylab('Medias (%)')+
  ggtitle("HB6_Alpha298K")+
  theme_minimal()+
  theme(plot.title = element_text(hjust = 0.05, vjust=1.20, size = 50), 
  axis.text.x = element_text(colour="black",size=60,angle=0,hjust=.5,vjust=.5,face="plain"),
  axis.text.y = element_text(colour="black",size=60,angle=0,hjust=1,vjust=0,face="plain"),  
  axis.title.x = element_text(colour="black",size=60,angle=0,hjust=.5,vjust=0,face="plain"),
  axis.title.y = element_text(colour="black",size=60,angle=90,hjust=.5,vjust=.5,face="plain"))

ggplot(data_final, aes(eje_x,HB7)) + 
  geom_line(alpha=.7) + 
  labs(color="HBs")+
  scale_color_discrete("HBs")+
  xlab('Tiempo (fs)') +
  scale_x_continuous(expand = c(0.01, 0.5), limits = c(0,75.000), breaks = seq(0, 75.000, 25)) +
  scale_y_continuous( limits = c(0,100), breaks = seq(0, 100, 10)) +
  scale_fill_brewer(palette="Set1")+
  ylab('Medias (%)')+
  ggtitle("HB7_Alpha298K")+
  theme_minimal()+
  theme(plot.title = element_text(hjust = 0.05, vjust=1.20, size = 50), 
  axis.text.x = element_text(colour="black",size=60,angle=0,hjust=.5,vjust=.5,face="plain"),
  axis.text.y = element_text(colour="black",size=60,angle=0,hjust=1,vjust=0,face="plain"),  
  axis.title.x = element_text(colour="black",size=60,angle=0,hjust=.5,vjust=0,face="plain"),
  axis.title.y = element_text(colour="black",size=60,angle=90,hjust=.5,vjust=.5,face="plain"))

ggplot(data_final, aes(eje_x,HB8)) + 
  geom_line(alpha=.7) + 
  labs(color="HBs")+
  scale_color_discrete("HBs")+
  xlab('Tiempo (fs)') +
  scale_x_continuous(expand = c(0.01, 0.5), limits = c(0,75.000), breaks = seq(0, 75.000, 25)) +
  scale_y_continuous( limits = c(0,100), breaks = seq(0, 100, 10)) +
  scale_fill_brewer(palette="Set1")+
  ylab('Medias (%)')+
  ggtitle("HB8_Alpha298K")+
  theme_minimal()+
  theme(plot.title = element_text(hjust = 0.05, vjust=1.20, size = 50), 
  axis.text.x = element_text(colour="black",size=60,angle=0,hjust=.5,vjust=.5,face="plain"),
  axis.text.y = element_text(colour="black",size=60,angle=0,hjust=1,vjust=0,face="plain"),  
  axis.title.x = element_text(colour="black",size=60,angle=0,hjust=.5,vjust=0,face="plain"),
  axis.title.y = element_text(colour="black",size=60,angle=90,hjust=.5,vjust=.5,face="plain"))

dev.off()


