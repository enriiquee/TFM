
#Script para la realizacion de graficas: 


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
medias <- lapply(alldfs, function(x) rowMeans(subset(x, select = c(1:224)), na.rm = TRUE))
medias <- lapply(alldfs, function(x) cbind(x,"rowmean"=rowMeans(subset(x, select = c(1:224)), na.rm = TRUE)))

#Separamos las columnas: 
medias <- lapply(x = medias, seq_along(alldfs), function(x, i) {
  assign(paste0("data", i), x[[i]], envir=.GlobalEnv)
})

######################
#PRUEBA
#######


data_final <- cbind(data1$rowmean,data2$rowmean,data3$rowmean,data4$rowmean,data5$rowmean, data6$rowmean,data7$rowmean,data8$rowmean)

colnames(data_final) <- c("HB1", "HB2","HB3","HB4","HB5","HB6","HB7","HB8")
eje_x <- data.frame(seq(0,2999,1))
eje_x <- eje_x/40
data_final <- cbind(eje_x,data_final)

colnames(data_final) <- c("eje_x","HB1", "HB2","HB3","HB4","HB5","HB6","HB7","HB8")



  ggplot() + 
  geom_line(data = data_final, alpha=0.7, aes(x = eje_x, y = HB1, color = "HB1")) +
  geom_line(data = data_final, alpha=0.7,aes(x = eje_x, y = HB2, color = "HB2")) + 
  geom_line(data = data_final, alpha=0.7,aes(x = eje_x, y = HB3, color = "HB3")) + 
  geom_line(data = data_final, alpha=0.7,aes(x = eje_x, y = HB4, color = "HB4")) + 
  geom_line(data = data_final, alpha=0.7,aes(x = eje_x, y = HB5, color = "HB5")) + 
  geom_line(data = data_final, alpha=0.7,aes(x = eje_x, y = HB6, color = "HB6")) + 
  geom_line(data = data_final, alpha=0.7,aes(x = eje_x, y = HB7, color = "HB7")) + 
  geom_line(data = data_final, alpha=0.7,aes(x = eje_x, y = HB8, color = "HB8")) + 
    labs(color="HBs")+
  xlab('Tiempo (fs)') +
    scale_fill_manual(color = c("red", "blue", "green", "yellow", "orange", "grey", "pink", "#CC79A7", "lightgreen", "skyblue")) + 
  
  scale_x_continuous(expand = c(0.01, 0), limits = c(0,75.000)) +
  scale_y_continuous( limits = c(0,100)) +
  ylab('Medias (%)')+
  theme_minimal()


df1 <- tidyr::gather(data_final)

ggplot(data_final, aes(x = value, fill = HBs)) + 
  geom_histogram(aes(y=..count../sum(..count..)),  colour="black", breaks=seq(0,15,0.1), alpha=0.5, position = "identity") +
  labs(x=expression(d["HB"]), y="Frecuencia")  + geom_vline(xintercept = 2.5, colour="red") +
  scale_x_continuous(expand = c(0.01, 0), breaks = seq(0, 15, 2.5), limits = c(0,15)) +
  scale_y_continuous( limits = c(0,0.025), breaks = seq(0,0.025,0.005)) +
  scale_fill_manual(values = c("red", "green", "blue", "yellow")) + 
  ggtitle("(A)") +
  theme_minimal()+
  theme(legend.position = c(0.9, 0.8), legend.key.size = unit(0.5, "cm")) +
  theme(plot.title = element_text(hjust = -0.1, vjust=2.12))





#Representamos las columnas de las medias para ver su evolucion: 
op <- par(mfrow = c(1,1))
plot((data1$rowmean), type="l", ylim=c(0, 100), xlab = 'Tiempo (Fs)', ylab = 'Medias (%)', main = "Evolución de los angulos diedros 1")
plot((data1$rowmean), type="l", xlab = 'Tiempo (Fs)', ylab = 'Medias (%)', main = "Evolución de los angulos diedros 1")
plot((data2$rowmean), type="l", ylim=c(0, 100), xlab = 'Tiempo (Fs)', ylab = 'Medias (%)', main = "Evolución de los angulos diedros 2")
plot((data2$rowmean), type="l", xlab = 'Tiempo (Fs)', ylab = 'Medias (%)', main = "Evolución de los angulos diedros 2")
plot((data3$rowmean), type="l", ylim=c(0, 100), xlab = 'Tiempo (Fs)', ylab = 'Medias (%)', main = "Evolución de los angulos diedros 3")
plot((data3$rowmean), type="l", xlab = 'Tiempo (Fs)', ylab = 'Medias (%)', main = "Evolución de los angulos diedros 3")
plot((data4$rowmean), type="l", ylim=c(0, 100), xlab = 'Tiempo (Fs)', ylab = 'Medias (%)', main = "Evolución de los angulos diedros 4")
plot((data4$rowmean), type="l", xlab = 'Tiempo (Fs)', ylab = 'Medias (%)', main = "Evolución de los angulos diedros 4")
plot((data5$rowmean), type="l", ylim=c(0, 100), xlab = 'Tiempo (Fs)', ylab = 'Medias (%)', main = "Evolución de los angulos diedros 5")
plot((data5$rowmean), type="l", xlab = 'Tiempo (Fs)', ylab = 'Medias (%)', main = "Evolución de los angulos diedros 5")
plot((data6$rowmean), type="l", ylim=c(0, 100), xlab = 'Tiempo (Fs)', ylab = 'Medias (%)', main = "Evolución de los angulos diedros 6")
plot((data6$rowmean), type="l", xlab = 'Tiempo (Fs)', ylab = 'Medias (%)', main = "Evolución de los angulos diedros 6")
plot((data7$rowmean), type="l", ylim=c(0, 100), xlab = 'Tiempo (Fs)', ylab = 'Medias (%)', main = "Evolución de los angulos diedros 7")
plot((data7$rowmean), type="l", xlab = 'Tiempo (Fs)', ylab = 'Medias (%)', main = "Evolución de los angulos diedros 7")
plot((data8$rowmean), type="l", ylim=c(0, 100), xlab = 'Tiempo (Fs)', ylab = 'Medias (%)', main = "Evolución de los angulos diedros 8")
plot((data8$rowmean), type="l", xlab = 'Tiempo (Fs)', ylab = 'Medias (%)', main = "Evolución de los angulos diedros 8")
plot((data9$rowmean), type="l", ylim=c(0, 100), xlab = 'Tiempo (Fs)', ylab = 'Medias (%)', main = "Evolución de los angulos diedros 8")
plot((data9$rowmean), type="l", xlab = 'Tiempo (Fs)', ylab = 'Medias (%)', main = "Evolución de los angulos diedros 8")
plot((data10$rowmean), type="l", ylim=c(0, 100), xlab = 'Tiempo (Fs)', ylab = 'Medias (%)', main = "Evolución de los angulos diedros 8")
plot((data10$rowmean), type="l", xlab = 'Tiempo (Fs)', ylab = 'Medias (%)', main = "Evolución de los angulos diedros 8")







