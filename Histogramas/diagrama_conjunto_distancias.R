##########################################
#Script para la realización de histogramas 
##########################################

#Comprobar si los paquete necesarios estAn insalados, si lo están, no los instala: 
list.of.packages <- c("gridExtra","ggplot2","assertthat", "tidyr", "plyr", "gtools")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

#Cargamos datos: 
library(plyr); library(ggplot2); library(gtools); library(data.table)

#Imprimimos por pantalla y eliminamos warnings: 
print("Realizando histogramas... Puede tardar un poco..."); options(warn=-1)
setwd("~/TFM/pruebas/")

getwd()

#Leemos los datos. 
distances_298 <- read.table(file.path(getwd(),"Script_298/Histogram2/cache/distances.dat"), quote="\"", comment.char="")
distances_318 <- read.table(file.path(getwd(),"Script_318/Histogram2/cache/distances.dat"), quote="\"", comment.char="")
distances_ext_278 <- read.table(file.path(getwd(),"Script_extendida_278/Histogram2/cache/distances.dat"), quote="\"", comment.char="")
distances_ext_298 <- read.table(file.path(getwd(),"Script_extendida_298/Histogram2/cache/distances.dat"), quote="\"", comment.char="")

# #Ajustamos el número de datos: 
# distances_298 <- data.frame(distances_298[-c(240001:672000), ])
# distances_318 <- 
# distances_ext_278 <- data.frame(distances_ext_278[-c(240001:1600000), ])
# distances_ext_298 <- data.frame(distances_ext_298[-c(240001:1940000), ])

#Renombramos los data frame: 
data1 <- data.frame(distances_298)
data2 <- data.frame(distances_318)
data3 <- data.frame(distances_ext_278)
data4 <- data.frame(distances_ext_298)

#Bucle para añadir NA a los datos que no tenemos. R no permite unir data frame si no poseen el 
# mismo número de filas. 

#Estadistica de puentes de hidrógeno 1: 
(sum(data1$V1 < 2.5) / nrow(data1))*100 
(sum(data1$V2 < 2.5) / nrow(data1))*100
(sum(data1$V3 < 2.5) / nrow(data1))*100
(sum(data1$V4 < 2.5) / nrow(data1))*100
(sum(data1$V5 < 2.5) / nrow(data1))*100
(sum(data1$V6 < 2.5) / nrow(data1))*100
(sum(data1$V7 < 2.5) / nrow(data1))*100
(sum(data1$V8 < 2.5) / nrow(data1))*100

#Estadistica de puentes de hidrógeno 2: 
(sum(data2$V1 < 2.5) / nrow(data2))*100
(sum(data2$V2 < 2.5) / nrow(data2))*100
(sum(data2$V3 < 2.5) / nrow(data2))*100
(sum(data2$V4 < 2.5) / nrow(data2))*100
(sum(data2$V5 < 2.5) / nrow(data2))*100
(sum(data2$V6 < 2.5) / nrow(data2))*100
(sum(data2$V7 < 2.5) / nrow(data2))*100
(sum(data2$V8 < 2.5) / nrow(data2))*100

#Estadistica de puentes de hidrógeno 3: 
(sum(data3$V1 < 2.5) / nrow(data3))*100
(sum(data3$V2 < 2.5) / nrow(data3))*100
(sum(data3$V3 < 2.5) / nrow(data3))*100
(sum(data3$V4 < 2.5) / nrow(data3))*100
(sum(data3$V5 < 2.5) / nrow(data3))*100
(sum(data3$V6 < 2.5) / nrow(data3))*100
(sum(data3$V7 < 2.5) / nrow(data3))*100
(sum(data3$V8 < 2.5) / nrow(data3))*100

#Estadistica de puentes de hidrógeno 4: 
(sum(data4$V1 < 2.5) / nrow(data4))*100
(sum(data4$V2 < 2.5) / nrow(data4))*100
(sum(data4$V3 < 2.5) / nrow(data4))*100
(sum(data4$V4 < 2.5) / nrow(data4))*100
(sum(data4$V5 < 2.5) / nrow(data4))*100
(sum(data4$V6 < 2.5) / nrow(data4))*100
(sum(data4$V7 < 2.5) / nrow(data4))*100
(sum(data4$V8 < 2.5) / nrow(data4))*100



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

#Extramos de la lista los datos generados y los guardamos en una variable: 
data_prueba <- list.df[[1]]
data_prueba2 <- list.df[[2]]
data_prueba3 <- list.df[[3]]
data_prueba4 <- list.df[[4]]


#Creamos una lista mediante un bucle. En ella se van a ir almacenando iterativamente las distintas
# columnas con los datos que nos interesan. 
res <- lapply(1:8, function(i){ cbind(data_prueba[i], data_prueba2[i], data_prueba3[i], data_prueba4[i]) })

#Extraemos los datos de interes de nuestra lista
data_final1 <- res[[1]]
data_final2 <- res[[2]]
data_final3 <- res[[3]]
data_final4 <- res[[4]]
data_final5 <- res[[5]]
data_final6 <- res[[6]]
data_final7 <- res[[7]]
data_final8 <- res[[8]]


#Renombramos los nombres de las columnas: 
colnames(data_final1) <- c("HB1_Alpha298K", "HB1_Alpha318K",  "HB1_ext278K",  "HB1_ext298K")
colnames(data_final2) <- c("HB2 _Alpha298K", "HB2_Alpha318K",  "HB2_ext278K",  "HB2_ext298K")
colnames(data_final3) <- c("HB3_Alpha298K", "HB3_Alpha318K",  "HB3_ext278K",  "HB3_ext298K")
colnames(data_final4) <- c("HB4_Alpha298K", "HB4_Alpha318K",  "HB4_ext278K",  "HB4_ext298K")
colnames(data_final5) <- c("HB5_Alpha298K", "HB5_Alpha318K",  "HB5_ext278K",  "HB5_ext298K")
colnames(data_final6) <- c("HB6_Alpha298K", "HB6_Alpha318K",  "HB6_ext278K",  "HB6_ext298K")
colnames(data_final7) <- c("HB7_Alpha298K", "HB7_Alpha318K",  "HB7_ext278K",  "HB7_ext298K")
colnames(data_final8) <- c("HB8_Alpha298K", "HB8_Alpha318K",  "HB8_ext278K",  "HB8_ext298K")

pdf(file = "Distancias_puentes_H.pdf", width = 20, height = 15)
#Realizamos histogramas: 
df1 <- tidyr::gather(data_final1)
colnames(df1) <- c("HBs",   "value")

ggplot(df1, aes(x = value, fill = HBs, colour=HBs)) + 
  geom_histogram(aes(y=0.1*..density..), binwidth=0.1, alpha=0.5, lwd=0.2, position = "identity") +
  labs(x=expression((ring(A))), y="(Frecuencia)")  + geom_vline(xintercept = 2.5, colour="red") +
  scale_x_continuous(expand = c(0.01, 0.5), breaks = seq(0, 15, 2.5), limits = c(0,15)) +
  scale_y_continuous( limits = c(0,0.18), breaks = seq(0,0.18,0.04)) +
  scale_fill_manual(values = c("red", "green", "blue", "yellow")) + 
  ggtitle("(A)") +
  theme_minimal()+
  theme(legend.position = c(0.8, 0.8), legend.key.size = unit(2.0, "cm"), legend.text=element_text(size=50), legend.title=element_text(size=50),  
  plot.title = element_text(hjust = 0.05, vjust=1.20, size = 50), 
  axis.text.x = element_text(colour="black",size=60,angle=0,hjust=.5,vjust=.5,face="plain"),
  axis.text.y = element_text(colour="black",size=60,angle=0,hjust=1,vjust=0,face="plain"),  
  axis.title.x = element_text(colour="black",size=60,angle=0,hjust=.5,vjust=0,face="plain"),
  axis.title.y = element_text(colour="black",size=60,angle=90,hjust=.5,vjust=.5,face="plain"))

df2 <- tidyr::gather(data_final2)
colnames(df2) <- c("HBs",   "value")
ggplot(df2, aes(x = value, fill = HBs, colour=HBs)) + 
  geom_histogram(aes(y=0.1*..density..), binwidth=0.1, alpha=0.5, lwd=0.2, position = "identity") +
  labs(x=expression((ring(A))), y="(Frecuencia)")  + geom_vline(xintercept = 2.5, colour="red") +
  scale_x_continuous(expand = c(0.01, 0.5), breaks = seq(0, 15, 2.5), limits = c(0,15)) +
  scale_y_continuous( limits = c(0,0.18), breaks = seq(0,0.18,0.04)) +
  scale_fill_manual(values = c("red", "green", "blue", "yellow")) + 
  ggtitle("(B)") +
  theme_minimal()+
  theme(legend.position = c(0.8, 0.8), legend.key.size = unit(2.0, "cm"), legend.text=element_text(size=50), legend.title=element_text(size=50),  
  plot.title = element_text(hjust = 0.05, vjust=1.20, size = 50), 
  axis.text.x = element_text(colour="black",size=60,angle=0,hjust=.5,vjust=.5,face="plain"),
  axis.text.y = element_text(colour="black",size=60,angle=0,hjust=1,vjust=0,face="plain"),  
  axis.title.x = element_text(colour="black",size=60,angle=0,hjust=.5,vjust=0,face="plain"),
  axis.title.y = element_text(colour="black",size=60,angle=90,hjust=.5,vjust=.5,face="plain"))

  


df3 <- tidyr::gather(data_final3)
colnames(df3) <- c("HBs",   "value")
ggplot(df3, aes(x = value, fill = HBs, colour=HBs)) + 
  geom_histogram(aes(y=0.1*..density..), binwidth=0.1, alpha=0.5, lwd=0.2, position = "identity") +
  labs(x=expression((ring(A))), y="(Frecuencia)")  + geom_vline(xintercept = 2.5, colour="red") +
  scale_x_continuous(expand = c(0.01, 0.5), breaks = seq(0, 15, 2.5), limits = c(0,15)) +
  scale_y_continuous( limits = c(0,0.18), breaks = seq(0,0.18,0.04)) +
  scale_fill_manual(values = c("red", "green", "blue", "yellow")) + 
  ggtitle("(C)") +
  theme_minimal()+
  theme(legend.position = c(0.8, 0.8), legend.key.size = unit(2.0, "cm"), legend.text=element_text(size=50), legend.title=element_text(size=50),  
  plot.title = element_text(hjust = 0.05, vjust=1.20, size = 50), 
  axis.text.x = element_text(colour="black",size=60,angle=0,hjust=.5,vjust=.5,face="plain"),
  axis.text.y = element_text(colour="black",size=60,angle=0,hjust=1,vjust=0,face="plain"),  
  axis.title.x = element_text(colour="black",size=60,angle=0,hjust=.5,vjust=0,face="plain"),
  axis.title.y = element_text(colour="black",size=60,angle=90,hjust=.5,vjust=.5,face="plain"))

  

df4 <- tidyr::gather(data_final4)
colnames(df4) <- c("HBs",   "value")
ggplot(df4, aes(x = value, fill = HBs, colour=HBs)) + 
  geom_histogram(aes(y=0.1*..density..), binwidth=0.1, alpha=0.5, lwd=0.2, position = "identity") +
  labs(x=expression((ring(A))), y="(Frecuencia)")  + geom_vline(xintercept = 2.5, colour="red") +
  scale_x_continuous(expand = c(0.01, 0.5), breaks = seq(0, 15, 2.5), limits = c(0,15)) +
  scale_y_continuous( limits = c(0,0.18), breaks = seq(0,0.18,0.04)) +
  scale_fill_manual(values = c("red", "green", "blue", "yellow")) + 
  ggtitle("(D)") +
  theme_minimal()+
  theme(legend.position = c(0.8, 0.8), legend.key.size = unit(2.0, "cm"), legend.text=element_text(size=50), legend.title=element_text(size=50),  
  plot.title = element_text(hjust = 0.05, vjust=1.20, size = 50), 
  axis.text.x = element_text(colour="black",size=60,angle=0,hjust=.5,vjust=.5,face="plain"),
  axis.text.y = element_text(colour="black",size=60,angle=0,hjust=1,vjust=0,face="plain"),  
  axis.title.x = element_text(colour="black",size=60,angle=0,hjust=.5,vjust=0,face="plain"),
  axis.title.y = element_text(colour="black",size=60,angle=90,hjust=.5,vjust=.5,face="plain"))

  

df5 <- tidyr::gather(data_final5)
colnames(df5) <- c("HBs",   "value")
ggplot(df5, aes(x = value, fill = HBs, colour=HBs)) + 
  geom_histogram(aes(y=0.1*..density..), binwidth=0.1, alpha=0.5, lwd=0.2, position = "identity") +
  labs(x=expression((ring(A))), y="(Frecuencia)")  + geom_vline(xintercept = 2.5, colour="red") +
  scale_x_continuous(expand = c(0.01, 0.5), breaks = seq(0, 15, 2.5), limits = c(0,15)) +
  scale_y_continuous( limits = c(0,0.18), breaks = seq(0,0.18,0.04)) +
  scale_fill_manual(values = c("red", "green", "blue", "yellow")) + 
  ggtitle("(E)") +
  theme_minimal()+
  theme(legend.position = c(0.8, 0.8), legend.key.size = unit(2.0, "cm"), legend.text=element_text(size=50), legend.title=element_text(size=50),  
  plot.title = element_text(hjust = 0.05, vjust=1.20, size = 50), 
  axis.text.x = element_text(colour="black",size=60,angle=0,hjust=.5,vjust=.5,face="plain"),
  axis.text.y = element_text(colour="black",size=60,angle=0,hjust=1,vjust=0,face="plain"),  
  axis.title.x = element_text(colour="black",size=60,angle=0,hjust=.5,vjust=0,face="plain"),
  axis.title.y = element_text(colour="black",size=60,angle=90,hjust=.5,vjust=.5,face="plain"))

  

df6 <- tidyr::gather(data_final6)
colnames(df6) <- c("HBs",   "value")
ggplot(df6, aes(x = value, fill = HBs, colour=HBs)) + 
  geom_histogram(aes(y=0.1*..density..), binwidth=0.1, alpha=0.5, lwd=0.2, position = "identity") +
  labs(x=expression((ring(A))), y="(Frecuencia)")  + geom_vline(xintercept = 2.5, colour="red") +
  scale_x_continuous(expand = c(0.01, 0.5), breaks = seq(0, 15, 2.5), limits = c(0,15)) +
  scale_y_continuous( limits = c(0,0.18), breaks = seq(0,0.18,0.04)) +
  scale_fill_manual(values = c("red", "green", "blue", "yellow")) + 
  ggtitle("(F)") +
  theme_minimal()+
  theme(legend.position = c(0.8, 0.8), legend.key.size = unit(2.0, "cm"), legend.text=element_text(size=50), legend.title=element_text(size=50),  
  plot.title = element_text(hjust = 0.05, vjust=1.20, size = 50), 
  axis.text.x = element_text(colour="black",size=60,angle=0,hjust=.5,vjust=.5,face="plain"),
  axis.text.y = element_text(colour="black",size=60,angle=0,hjust=1,vjust=0,face="plain"),  
  axis.title.x = element_text(colour="black",size=60,angle=0,hjust=.5,vjust=0,face="plain"),
  axis.title.y = element_text(colour="black",size=60,angle=90,hjust=.5,vjust=.5,face="plain"))

  

df7 <- tidyr::gather(data_final7)
colnames(df7) <- c("HBs",   "value")
ggplot(df7, aes(x = value, fill = HBs, colour=HBs)) + 
  geom_histogram(aes(y=0.1*..density..), binwidth=0.1, alpha=0.5, lwd=0.2, position = "identity") +
  labs(x=expression((ring(A))), y="(Frecuencia)")  + geom_vline(xintercept = 2.5, colour="red") +
  scale_x_continuous(expand = c(0.01, 0.5), breaks = seq(0, 15, 2.5), limits = c(0,15)) +
  scale_y_continuous( limits = c(0,0.18), breaks = seq(0,0.18,0.04)) +
  scale_fill_manual(values = c("red", "green", "blue", "yellow")) + 
  ggtitle("(G)") +
  theme_minimal()+
  theme(legend.position = c(0.8, 0.8), legend.key.size = unit(2.0, "cm"), legend.text=element_text(size=50), legend.title=element_text(size=50),  
  plot.title = element_text(hjust = 0.05, vjust=1.20, size = 50), 
  axis.text.x = element_text(colour="black",size=60,angle=0,hjust=.5,vjust=.5,face="plain"),
  axis.text.y = element_text(colour="black",size=60,angle=0,hjust=1,vjust=0,face="plain"),  
  axis.title.x = element_text(colour="black",size=60,angle=0,hjust=.5,vjust=0,face="plain"),
  axis.title.y = element_text(colour="black",size=60,angle=90,hjust=.5,vjust=.5,face="plain"))

  

df8 <- tidyr::gather(data_final8)
colnames(df8) <- c("HBs",   "value")
ggplot(df8, aes(x = value, fill = HBs, colour=HBs)) + 
  geom_histogram(aes(y=0.1*..density..), binwidth=0.1, alpha=0.5, lwd=0.2, position = "identity") +
  labs(x=expression((ring(A))), y="(Frecuencia)")  + geom_vline(xintercept = 2.5, colour="red") +
  scale_x_continuous(expand = c(0.01, 0.5), breaks = seq(0, 15, 2.5), limits = c(0,15)) +
  scale_y_continuous( limits = c(0,0.18), breaks = seq(0,0.18,0.04)) +
  scale_fill_manual(values = c("red", "green", "blue", "yellow")) + 
  ggtitle("(H)") +
  theme_minimal()+
  theme(legend.position = c(0.8, 0.8), legend.key.size = unit(2.0, "cm"), legend.text=element_text(size=50), legend.title=element_text(size=50),  
  plot.title = element_text(hjust = 0.05, vjust=1.20, size = 50), 
  axis.text.x = element_text(colour="black",size=60,angle=0,hjust=.5,vjust=.5,face="plain"),
  axis.text.y = element_text(colour="black",size=60,angle=0,hjust=1,vjust=0,face="plain"),  
  axis.title.x = element_text(colour="black",size=60,angle=0,hjust=.5,vjust=0,face="plain"),
  axis.title.y = element_text(colour="black",size=60,angle=90,hjust=.5,vjust=.5,face="plain"))
dev.off() 
  

###
# dat1 = data.frame(x=distances_298$V2, group="alpha298")
# dat2 = data.frame(x=distances_318$V2, group="alpha318")
# dat3 = data.frame(x=distances_ext_278$V2, group="ext278")
# dat4 = data.frame(x=distances_ext_298$V2, group="ext298")
# 
# #I use rbind.fill to bind data frames that don't have the same set of columns 
# dat <- rbind.fill(dat1,dat2,dat3,dat4)

# # Normalize histogram. 
# ggplot(dat, aes(x, fill=group, colour=group)) +
#   geom_histogram(aes(y=0.1*..density..), binwidth=0.1, alpha=0.5, lwd=0.2, position = "identity") +
#   labs(x=expression((ring(A))), y="(Frecuencia)")  + geom_vline(xintercept = 2.5, colour="red") +
#   scale_x_continuous(expand = c(0.01, 0.5), breaks = seq(0, 15, 2.5), limits = c(0,15)) +
#   scale_y_continuous( limits = c(0,0.18), breaks = seq(0,0.18,0.04)) +
#   scale_fill_manual(values = c("red", "green", "blue", "yellow")) + 
#   ggtitle("(A)") +
#   theme_minimal()+
#   theme(legend.position = c(0.8, 0.8), legend.key.size = unit(0.5, "cm")) +
#   theme(plot.title = element_text(hjust = -0.1, vjust=2.12))
# 
# ggplot(dat, aes(x, fill=group, colour=group)) +
#   geom_histogram(aes(y=0.1*..density..), binwidth=0.1, alpha=0.5, lwd=0.2, position = "identity") +
#   labs(x=expression((ring(A))), y="(Frecuencia)")  + geom_vline(xintercept = 2.5, colour="red") +
#   #scale_x_continuous(expand = c(0.01, 0), breaks = seq(0, 15, 2.5), limits = c(0,15)) +
#   #scale_y_continuous( limits = c(0,0.025), breaks = seq(0,0.025,0.005)) +
#   scale_fill_manual(values = c("red", "green", "blue", "yellow")) + 
#   ggtitle("(A)") +
#   theme_minimal()+
#   theme(legend.position = c(0.8, 0.8), legend.key.size = unit(0.5, "cm")) +
#   theme(plot.title = element_text(hjust = -0.1, vjust=2.12))
# 
