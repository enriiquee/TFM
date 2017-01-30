######################################################################

# Scrit para la realización de histogramas de ángulos diedros y Ramachandran

######################################################################

#Comprobamos mediante este bucle si los paquetes necesarios están instalados...
packages <- c("gridExtra","ggplot2","assertthat", "tidyr", "hexbin", "Cairo")
if (length(setdiff(packages, rownames(installed.packages()))) > 0) {
  install.packages(setdiff(packages, rownames(installed.packages())))  }

print("Realizando histogramas... Puede tardar un poco...")
options(warn=-1)
#Cargamos los paquetes que utilizaremos: 
library("ggplot2")
library("tidyr")
library("gridExtra")
library("assertthat")
library("hexbin")
library("Cairo")



#Cargamos los datos que vamos a tuilizar y añadimos nombres a las columnas
data1 <- read.table(file.path(getwd(),"Script_298/Script_angulos_diedros/cache/dihedral_angle.dat"), quote="\"", comment.char="")
data2<- read.table(file.path(getwd(),"Script_318/Script_angulos_diedros/cache/dihedral_angle.dat"), quote="\"", comment.char="")
data3<- read.table(file.path(getwd(),"Script_extendida_278/Script_angulos_diedros/cache/dihedral_angle.dat"), quote="\"", comment.char="")
data4<- read.table(file.path(getwd(),"Script_extendida_298/Script_angulos_diedros/cache/dihedral_angle.dat"), quote="\"", comment.char="")

#Juntamos en listas: 
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
res <- lapply(1:20, function(i){ cbind(data_prueba[i], data_prueba2[i], data_prueba3[i], data_prueba4[i]) })

#Extraemos los datos de interes de nuestra lista
data_final01 <- res[[1]]; data_final02 <- res[[2]]; data_final03 <- res[[3]]; data_final04 <- res[[4]]; data_final05 <- res[[5]]; data_final06 <- res[[6]];
data_final07 <- res[[7]]; data_final08 <- res[[8]]; data_final09 <- res[[9]]; data_final10 <- res[[10]]; data_final11 <- res[[11]]; data_final12 <- res[[12]]; data_final13 <- res[[13]];
data_final14 <- res[[14]]; data_final15 <- res[[15]]; data_final16 <- res[[16]]; data_final17 <- res[[17]]; data_final18 <- res[[18]]; data_final19 <- res[[19]]; data_final20 <- res[[20]] 

#Renombramos los nombres de las columnas: 

colnames(data_final01) <- c("\u03D5_Alpha298K", "\u03D5_Alpha318K",  "\u03D5_Ext278K",  "\u03D5_Ext298K")
colnames(data_final02) <- c("\u0470_Alpha298K", "\u0470_Alpha318K",  "\u0470_Ext278K",  "\u0470_Ext298K")
colnames(data_final03) <- c("\u03D5_Alpha298K", "\u03D5_Alpha318K",  "\u03D5_Ext278K",  "\u03D5_Ext298K")
colnames(data_final04) <- c("\u0470_Alpha298K", "\u0470_Alpha318K",  "\u0470_Ext278K",  "\u0470_Ext298K")
colnames(data_final05) <- c("\u03D5_Alpha298K", "\u03D5_Alpha318K",  "\u03D5_Ext278K",  "\u03D5_Ext298K")
colnames(data_final06) <- c("\u0470_Alpha298K", "\u0470_Alpha318K",  "\u0470_Ext278K",  "\u0470_Ext298K")
colnames(data_final07) <- c("\u03D5_Alpha298K", "\u03D5_Alpha318K",  "\u03D5_Ext278K",  "\u03D5_Ext298K")
colnames(data_final08) <- c("\u0470_Alpha298K", "\u0470_Alpha318K",  "\u0470_Ext278K",  "\u0470_Ext298K")
colnames(data_final09) <- c("\u03D5_Alpha298K", "\u03D5_Alpha318K",  "\u03D5_Ext278K",  "\u03D5_Ext298K")
colnames(data_final10) <- c("\u0470_Alpha298K", "\u0470_Alpha318K",  "\u0470_Ext278K",  "\u0470_Ext298K")
colnames(data_final11) <- c("\u03D5_Alpha298K", "\u03D5_Alpha318K",  "\u03D5_Ext278K",  "\u03D5_Ext298K")
colnames(data_final12) <- c("\u0470_Alpha298K", "\u0470_Alpha318K",  "\u0470_Ext278K",  "\u0470_Ext298K")
colnames(data_final13) <- c("\u03D5_Alpha298K", "\u03D5_Alpha318K",  "\u03D5_Ext278K",  "\u03D5_Ext298K")
colnames(data_final14) <- c("\u0470_Alpha298K", "\u0470_Alpha318K",  "\u0470_Ext278K",  "\u0470_Ext298K")
colnames(data_final15) <- c("\u03D5_Alpha298K", "\u03D5_Alpha318K",  "\u03D5_Ext278K",  "\u03D5_Ext298K")
colnames(data_final16) <- c("\u0470_Alpha298K", "\u0470_Alpha318K",  "\u0470_Ext278K",  "\u0470_Ext298K")
colnames(data_final17) <- c("\u03D5_Alpha298K", "\u03D5_Alpha318K",  "\u03D5_Ext278K",  "\u03D5_Ext298K")
colnames(data_final18) <- c("\u0470_Alpha298K", "\u0470_Alpha318K",  "\u0470_Ext278K",  "\u0470_Ext298K")
colnames(data_final19) <- c("\u03D5_Alpha298K", "\u03D5_Alpha318K",  "\u03D5_Ext278K",  "\u03D5_Ext298K")
colnames(data_final20) <- c("\u0470_Alpha298K", "\u0470_Alpha318K",  "\u0470_Ext278K",  "\u0470_Ext298K")


cairo_pdf(file = "Angulos_diedros_phi.pdf", width = 20, height = 15, onefile = TRUE)

#Para hacer la unión de todos los histogramas por grupo psi
df1 <- tidyr::gather(data_final01)
colnames(df1) <- c("Phi",   "value")
ggplot(df1, aes(x = value, fill = Phi, colour= Phi)) + 
  geom_histogram(aes(y=2.5*..density..), binwidth=2.5, alpha=0.3, lwd=0.2, position = "identity") +
  labs(x=expression(Grados (º)), y="(Frecuencia)")+
  scale_x_continuous(expand = c(0.01, 10), limits = c(-180,180), breaks = seq(-180,180,40)) +
  scale_y_continuous(expand=c(0,0.0), limits = c(0,0.16), breaks = seq(0,0.16,0.05)) +
  scale_fill_manual(values = c("red", "green", "blue", "yellow")) + 
  ggtitle("(A)") +
  theme_minimal()+
  theme(legend.position = c(0.8, 0.8), legend.key.size = unit(2.0, "cm"), legend.text=element_text(size=50), legend.title=element_text(size=50),  
  plot.title = element_text(hjust = 0.05, vjust=1.20, size = 50), 
  axis.text.x = element_text(colour="black",size=60,angle=0,hjust=.5,vjust=.5,face="plain"),
  axis.text.y = element_text(colour="black",size=60,angle=0,hjust=1,vjust=0,face="plain"),  
  axis.title.x = element_text(colour="black",size=60,angle=0,hjust=.5,vjust=0,face="plain"),
  axis.title.y = element_text(colour="black",size=60,angle=90,hjust=.5,vjust=.5,face="plain")) + 
  geom_vline(xintercept = -82, colour = "red") +
  geom_vline(xintercept = -42, colour = "red") +
  geom_vline(xintercept = -62, colour = "black") 



df3 <- tidyr::gather(data_final03)
colnames(df3) <- c("Phi",   "value")
ggplot(df3, aes(x = value, fill = Phi, colour= Phi)) + 
  geom_histogram(aes(y=2.5*..density..), binwidth=2.5, alpha=0.3, lwd=0.2, position = "identity") +
  labs(x=expression(Grados (º)), y="(Frecuencia)")+
  scale_x_continuous(expand = c(0.01, 10), limits = c(-180,180), breaks = seq(-180,180,40)) +
  scale_y_continuous(expand=c(0,0.0), limits = c(0,0.16), breaks = seq(0,0.16,0.05)) +
  scale_fill_manual(values = c("red", "green", "blue", "yellow")) + 
  ggtitle("(B)") +
  theme_minimal()+
  theme(legend.position = c(0.8, 0.8), legend.key.size = unit(2.0, "cm"), legend.text=element_text(size=50), legend.title=element_text(size=50),  
        plot.title = element_text(hjust = 0.05, vjust=1.20, size = 50), 
        axis.text.x = element_text(colour="black",size=60,angle=0,hjust=.5,vjust=.5,face="plain"),
        axis.text.y = element_text(colour="black",size=60,angle=0,hjust=1,vjust=0,face="plain"),  
        axis.title.x = element_text(colour="black",size=60,angle=0,hjust=.5,vjust=0,face="plain"),
        axis.title.y = element_text(colour="black",size=60,angle=90,hjust=.5,vjust=.5,face="plain")) + 
  geom_vline(xintercept = -82, colour = "red") +
  geom_vline(xintercept = -42, colour = "red") +
  geom_vline(xintercept = -62, colour = "black") 



df5 <- tidyr::gather(data_final05)
colnames(df5) <- c("Phi",   "value")
ggplot(df5, aes(x = value, fill = Phi, colour= Phi)) + 
  geom_histogram(aes(y=2.5*..density..), binwidth=2.5, alpha=0.3, lwd=0.2, position = "identity") +
  labs(x=expression(Grados (º)), y="(Frecuencia)")+
  scale_x_continuous(expand = c(0.01, 10), limits = c(-180,180), breaks = seq(-180,180,40)) +
  scale_y_continuous(expand=c(0,0.0), limits = c(0,0.16), breaks = seq(0,0.16,0.05)) +
  scale_fill_manual(values = c("red", "green", "blue", "yellow")) + 
  ggtitle("(C)") +
  theme_minimal()+
  theme(legend.position = c(0.8, 0.8), legend.key.size = unit(2.0, "cm"), legend.text=element_text(size=50), legend.title=element_text(size=50),  
        plot.title = element_text(hjust = 0.05, vjust=1.20, size = 50), 
        axis.text.x = element_text(colour="black",size=60,angle=0,hjust=.5,vjust=.5,face="plain"),
        axis.text.y = element_text(colour="black",size=60,angle=0,hjust=1,vjust=0,face="plain"),  
        axis.title.x = element_text(colour="black",size=60,angle=0,hjust=.5,vjust=0,face="plain"),
        axis.title.y = element_text(colour="black",size=60,angle=90,hjust=.5,vjust=.5,face="plain")) + 
  geom_vline(xintercept = -82, colour = "red") +
  geom_vline(xintercept = -42, colour = "red") +
  geom_vline(xintercept = -62, colour = "black") 

df7 <- tidyr::gather(data_final07)
colnames(df7) <- c("Phi",   "value")
ggplot(df7, aes(x = value, fill = Phi, colour= Phi)) + 
  geom_histogram(aes(y=2.5*..density..), binwidth=2.5, alpha=0.3, lwd=0.2, position = "identity") +
  labs(x=expression(Grados (º)), y="(Frecuencia)")+
  scale_x_continuous(expand = c(0.01, 10), limits = c(-180,180), breaks = seq(-180,180,40)) +
  scale_y_continuous(expand=c(0,0.0), limits = c(0,0.16), breaks = seq(0,0.16,0.05)) +
  scale_fill_manual(values = c("red", "green", "blue", "yellow")) + 
  ggtitle("(D)") +
  theme_minimal()+
  theme(legend.position = c(0.8, 0.8), legend.key.size = unit(2.0, "cm"), legend.text=element_text(size=50), legend.title=element_text(size=50),  
        plot.title = element_text(hjust = 0.05, vjust=1.20, size = 50), 
        axis.text.x = element_text(colour="black",size=60,angle=0,hjust=.5,vjust=.5,face="plain"),
        axis.text.y = element_text(colour="black",size=60,angle=0,hjust=1,vjust=0,face="plain"),  
        axis.title.x = element_text(colour="black",size=60,angle=0,hjust=.5,vjust=0,face="plain"),
        axis.title.y = element_text(colour="black",size=60,angle=90,hjust=.5,vjust=.5,face="plain")) + 
  geom_vline(xintercept = -82, colour = "red") +
  geom_vline(xintercept = -42, colour = "red") +
  geom_vline(xintercept = -62, colour = "black") 

df09 <- tidyr::gather(data_final09)
colnames(df09) <- c("Phi",   "value")
ggplot(df09, aes(x = value, fill = Phi, colour= Phi)) + 
  geom_histogram(aes(y=2.5*..density..), binwidth=2.5, alpha=0.3, lwd=0.2, position = "identity") +
  labs(x=expression(Grados (º)), y="(Frecuencia)")+
  scale_x_continuous(expand = c(0.01, 10), limits = c(-180,180), breaks = seq(-180,180,40)) +
  scale_y_continuous(expand=c(0,0.0), limits = c(0,0.16), breaks = seq(0,0.16,0.05)) +
  scale_fill_manual(values = c("red", "green", "blue", "yellow")) + 
  ggtitle("(E)") +
  theme_minimal()+
  theme(legend.position = c(0.8, 0.8), legend.key.size = unit(2.0, "cm"), legend.text=element_text(size=50), legend.title=element_text(size=50),  
        plot.title = element_text(hjust = 0.05, vjust=1.20, size = 50), 
        axis.text.x = element_text(colour="black",size=60,angle=0,hjust=.5,vjust=.5,face="plain"),
        axis.text.y = element_text(colour="black",size=60,angle=0,hjust=1,vjust=0,face="plain"),  
        axis.title.x = element_text(colour="black",size=60,angle=0,hjust=.5,vjust=0,face="plain"),
        axis.title.y = element_text(colour="black",size=60,angle=90,hjust=.5,vjust=.5,face="plain")) + 
  geom_vline(xintercept = -82, colour = "red") +
  geom_vline(xintercept = -42, colour = "red") +
  geom_vline(xintercept = -62, colour = "black") 

df11 <- tidyr::gather(data_final11)
colnames(df11) <- c("Phi",   "value")
ggplot(df11, aes(x = value, fill = Phi, colour= Phi)) + 
  geom_histogram(aes(y=2.5*..density..), binwidth=2.5, alpha=0.3, lwd=0.2, position = "identity") +
  labs(x=expression(Grados (º)), y="(Frecuencia)")+
  scale_x_continuous(expand = c(0.01, 10), limits = c(-180,180), breaks = seq(-180,180,40)) +
  scale_y_continuous(expand=c(0,0.0), limits = c(0,0.16), breaks = seq(0,0.16,0.05)) +
  scale_fill_manual(values = c("red", "green", "blue", "yellow")) + 
  ggtitle("(F)") +
  theme_minimal()+
  theme(legend.position = c(0.8, 0.8), legend.key.size = unit(2.0, "cm"), legend.text=element_text(size=50), legend.title=element_text(size=50),  
  plot.title = element_text(hjust = 0.05, vjust=1.20, size = 50), 
  axis.text.x = element_text(colour="black",size=60,angle=0,hjust=.5,vjust=.5,face="plain"),
  axis.text.y = element_text(colour="black",size=60,angle=0,hjust=1,vjust=0,face="plain"),  
  axis.title.x = element_text(colour="black",size=60,angle=0,hjust=.5,vjust=0,face="plain"),
  axis.title.y = element_text(colour="black",size=60,angle=90,hjust=.5,vjust=.5,face="plain")) + 
  geom_vline(xintercept = -82, colour = "red") +
  geom_vline(xintercept = -42, colour = "red") +
  geom_vline(xintercept = -62, colour = "black") 

df13 <- tidyr::gather(data_final13)
colnames(df13) <- c("Phi",   "value")
ggplot(df13, aes(x = value, fill = Phi, colour= Phi)) + 
  geom_histogram(aes(y=2.5*..density..), binwidth=2.5, alpha=0.3, lwd=0.2, position = "identity") +
  labs(x=expression(Grados (º)), y="(Frecuencia)")+
  scale_x_continuous(expand = c(0.01, 10), limits = c(-180,180), breaks = seq(-180,180,40)) +
  scale_y_continuous(expand=c(0,0.0), limits = c(0,0.16), breaks = seq(0,0.16,0.05)) +
  scale_fill_manual(values = c("red", "green", "blue", "yellow")) + 
  ggtitle("(G)") +
  theme_minimal()+
  theme(legend.position = c(0.8, 0.8), legend.key.size = unit(2.0, "cm"), legend.text=element_text(size=50), legend.title=element_text(size=50),  
  plot.title = element_text(hjust = 0.05, vjust=1.20, size = 50), 
  axis.text.x = element_text(colour="black",size=60,angle=0,hjust=.5,vjust=.5,face="plain"),
  axis.text.y = element_text(colour="black",size=60,angle=0,hjust=1,vjust=0,face="plain"),  
  axis.title.x = element_text(colour="black",size=60,angle=0,hjust=.5,vjust=0,face="plain"),
  axis.title.y = element_text(colour="black",size=60,angle=90,hjust=.5,vjust=.5,face="plain")) + 
  geom_vline(xintercept = -82, colour = "red") +
  geom_vline(xintercept = -42, colour = "red") +
  geom_vline(xintercept = -62, colour = "black") 

df15 <- tidyr::gather(data_final15)
colnames(df15) <- c("Phi",   "value")
ggplot(df15, aes(x = value, fill = Phi, colour= Phi)) + 
  geom_histogram(aes(y=2.5*..density..), binwidth=2.5, alpha=0.3, lwd=0.2, position = "identity") +
  labs(x=expression(Grados (º)), y="(Frecuencia)")+
  scale_x_continuous(expand = c(0.01, 10), limits = c(-180,180), breaks = seq(-180,180,40)) +
  scale_y_continuous(expand=c(0,0.0), limits = c(0,0.16), breaks = seq(0,0.16,0.05)) +
  scale_fill_manual(values = c("red", "green", "blue", "yellow")) + 
  ggtitle("(H)") +
  theme_minimal()+
  theme(legend.position = c(0.8, 0.8), legend.key.size = unit(2.0, "cm"), legend.text=element_text(size=50), legend.title=element_text(size=50),  
  plot.title = element_text(hjust = 0.05, vjust=1.20, size = 50), 
  axis.text.x = element_text(colour="black",size=60,angle=0,hjust=.5,vjust=.5,face="plain"),
  axis.text.y = element_text(colour="black",size=60,angle=0,hjust=1,vjust=0,face="plain"),  
  axis.title.x = element_text(colour="black",size=60,angle=0,hjust=.5,vjust=0,face="plain"),
  axis.title.y = element_text(colour="black",size=60,angle=90,hjust=.5,vjust=.5,face="plain")) + 
  geom_vline(xintercept = -82, colour = "red") +
  geom_vline(xintercept = -42, colour = "red") +
  geom_vline(xintercept = -62, colour = "black") 

df17 <- tidyr::gather(data_final17)
colnames(df17) <- c("Phi",   "value")
ggplot(df17, aes(x = value, fill = Phi, colour= Phi)) + 
  geom_histogram(aes(y=2.5*..density..), binwidth=2.5, alpha=0.3, lwd=0.2, position = "identity") +
  labs(x=expression(Grados (º)), y="(Frecuencia)")+
  scale_x_continuous(expand = c(0.01, 10), limits = c(-180,180), breaks = seq(-180,180,40)) +
  scale_y_continuous(expand=c(0,0.0), limits = c(0,0.16), breaks = seq(0,0.16,0.05)) +
  scale_fill_manual(values = c("red", "green", "blue", "yellow")) + 
  ggtitle("(I)") +
  theme_minimal()+
  theme(legend.position = c(0.8, 0.8), legend.key.size = unit(2.0, "cm"), legend.text=element_text(size=50), legend.title=element_text(size=50),  
  plot.title = element_text(hjust = 0.05, vjust=1.20, size = 50), 
  axis.text.x = element_text(colour="black",size=60,angle=0,hjust=.5,vjust=.5,face="plain"),
  axis.text.y = element_text(colour="black",size=60,angle=0,hjust=1,vjust=0,face="plain"),  
  axis.title.x = element_text(colour="black",size=60,angle=0,hjust=.5,vjust=0,face="plain"),
  axis.title.y = element_text(colour="black",size=60,angle=90,hjust=.5,vjust=.5,face="plain")) + 
  geom_vline(xintercept = -82, colour = "red") +
  geom_vline(xintercept = -42, colour = "red") +
  geom_vline(xintercept = -62, colour = "black") 


df19 <- tidyr::gather(data_final19)
colnames(df19) <- c("Phi",   "value")
ggplot(df19, aes(x = value, fill = Phi, colour= Phi)) + 
  geom_histogram(aes(y=2.5*..density..), binwidth=2.5, alpha=0.3, lwd=0.2, position = "identity") +
  labs(x=expression(Grados (º)), y="(Frecuencia)")+
  scale_x_continuous(expand = c(0.01, 10), limits = c(-180,180), breaks = seq(-180,180,40)) +
  scale_y_continuous(expand=c(0,0.0), limits = c(0,0.16), breaks = seq(0,0.16,0.05)) +
  scale_fill_manual(values = c("red", "green", "blue", "yellow")) + 
  ggtitle("(J)") +
  theme_minimal()+
  theme(legend.position = c(0.8, 0.8), legend.key.size = unit(2.0, "cm"), legend.text=element_text(size=50), legend.title=element_text(size=50),  
        plot.title = element_text(hjust = 0.05, vjust=1.20, size = 50), 
        axis.text.x = element_text(colour="black",size=60,angle=0,hjust=.5,vjust=.5,face="plain"),
        axis.text.y = element_text(colour="black",size=60,angle=0,hjust=1,vjust=0,face="plain"),  
        axis.title.x = element_text(colour="black",size=60,angle=0,hjust=.5,vjust=0,face="plain"),
        axis.title.y = element_text(colour="black",size=60,angle=90,hjust=.5,vjust=.5,face="plain")) + 
  geom_vline(xintercept = -82, colour = "red") +
  geom_vline(xintercept = -42, colour = "red") +
  geom_vline(xintercept = -62, colour = "black") 

dev.off()
cairo_pdf(file = "Angulos_diedros_psi.pdf", width = 20, height = 15, onefile = TRUE)

#Para hacer la unión de todos los histogramas por grupo psi
df2 <- tidyr::gather(data_final02)
colnames(df2) <- c("Phi",   "value")
ggplot(df2, aes(x = value, fill = Phi, colour= Phi)) + 
  geom_histogram(aes(y=2.5*..density..), binwidth=2.5, alpha=0.3, lwd=0.2, position = "identity") +
  labs(x=expression(Grados (º)), y="(Frecuencia)")+
  scale_x_continuous(expand = c(0.01, 10), limits = c(-180,180), breaks = seq(-180,180,40)) +
  scale_y_continuous(expand=c(0,0.0), limits = c(0,0.16), breaks = seq(0,0.16,0.05)) +
  scale_fill_manual(values = c("red", "green", "blue", "yellow")) + 
  ggtitle("(A)") +
  theme_minimal()+
  theme(legend.position = c(0.8, 0.8), legend.key.size = unit(2.0, "cm"), legend.text=element_text(size=50), legend.title=element_text(size=50),  
        plot.title = element_text(hjust = 0.05, vjust=1.20, size = 50), 
        axis.text.x = element_text(colour="black",size=60,angle=0,hjust=.5,vjust=.5,face="plain"),
        axis.text.y = element_text(colour="black",size=60,angle=0,hjust=1,vjust=0,face="plain"),  
        axis.title.x = element_text(colour="black",size=60,angle=0,hjust=.5,vjust=0,face="plain"),
        axis.title.y = element_text(colour="black",size=60,angle=90,hjust=.5,vjust=.5,face="plain")) + 
  geom_vline(xintercept = -61, colour = "blue") +
  geom_vline(xintercept = -21, colour = "blue") +
  geom_vline(xintercept = -41, colour = "black") 



df4 <- tidyr::gather(data_final04)
colnames(df4) <- c("Phi",   "value")
ggplot(df4, aes(x = value, fill = Phi, colour= Phi)) + 
  geom_histogram(aes(y=2.5*..density..), binwidth=2.5, alpha=0.3, lwd=0.2, position = "identity") +
  labs(x=expression(Grados (º)), y="(Frecuencia)")+
  scale_x_continuous(expand = c(0.01, 10), limits = c(-180,180), breaks = seq(-180,180,40)) +
  scale_y_continuous(expand=c(0,0.0), limits = c(0,0.16), breaks = seq(0,0.16,0.05)) +
  scale_fill_manual(values = c("red", "green", "blue", "yellow")) + 
  ggtitle("(B)") +
  theme_minimal()+
  theme(legend.position = c(0.8, 0.8), legend.key.size = unit(2.0, "cm"), legend.text=element_text(size=50), legend.title=element_text(size=50),  
        plot.title = element_text(hjust = 0.05, vjust=1.20, size = 50), 
        axis.text.x = element_text(colour="black",size=60,angle=0,hjust=.5,vjust=.5,face="plain"),
        axis.text.y = element_text(colour="black",size=60,angle=0,hjust=1,vjust=0,face="plain"),  
        axis.title.x = element_text(colour="black",size=60,angle=0,hjust=.5,vjust=0,face="plain"),
        axis.title.y = element_text(colour="black",size=60,angle=90,hjust=.5,vjust=.5,face="plain")) + 
  geom_vline(xintercept = -61, colour = "blue") +
  geom_vline(xintercept = -21, colour = "blue") +
  geom_vline(xintercept = -41, colour = "black") 


df6 <- tidyr::gather(data_final06)
colnames(df6) <- c("Phi",   "value")
ggplot(df6, aes(x = value, fill = Phi, colour= Phi)) + 
  geom_histogram(aes(y=2.5*..density..), binwidth=2.5, alpha=0.3, lwd=0.2, position = "identity") +
  labs(x=expression(Grados (º)), y="(Frecuencia)")+
  scale_x_continuous(expand = c(0.01, 10), limits = c(-180,180), breaks = seq(-180,180,40)) +
  scale_y_continuous(expand=c(0,0.0), limits = c(0,0.16), breaks = seq(0,0.16,0.05)) +
  scale_fill_manual(values = c("red", "green", "blue", "yellow")) + 
  ggtitle("(C)") +
  theme_minimal()+
  theme(legend.position = c(0.8, 0.8), legend.key.size = unit(2.0, "cm"), legend.text=element_text(size=50), legend.title=element_text(size=50),  
        plot.title = element_text(hjust = 0.05, vjust=1.20, size = 50), 
        axis.text.x = element_text(colour="black",size=60,angle=0,hjust=.5,vjust=.5,face="plain"),
        axis.text.y = element_text(colour="black",size=60,angle=0,hjust=1,vjust=0,face="plain"),  
        axis.title.x = element_text(colour="black",size=60,angle=0,hjust=.5,vjust=0,face="plain"),
        axis.title.y = element_text(colour="black",size=60,angle=90,hjust=.5,vjust=.5,face="plain")) + 
  geom_vline(xintercept = -61, colour = "blue") +
  geom_vline(xintercept = -21, colour = "blue") +
  geom_vline(xintercept = -41, colour = "black") 
df8 <- tidyr::gather(data_final08)
colnames(df8) <- c("Phi",   "value")
ggplot(df8, aes(x = value, fill = Phi, colour= Phi)) + 
  geom_histogram(aes(y=2.5*..density..), binwidth=2.5, alpha=0.3, lwd=0.2, position = "identity") +
  labs(x=expression(Grados (º)), y="(Frecuencia)")+
  scale_x_continuous(expand = c(0.01, 10), limits = c(-180,180), breaks = seq(-180,180,40)) +
  scale_y_continuous(expand=c(0,0.0), limits = c(0,0.16), breaks = seq(0,0.16,0.05)) +
  scale_fill_manual(values = c("red", "green", "blue", "yellow")) + 
  ggtitle("(D)") +
  theme_minimal()+
  theme(legend.position = c(0.8, 0.8), legend.key.size = unit(2.0, "cm"), legend.text=element_text(size=50), legend.title=element_text(size=50),  
        plot.title = element_text(hjust = 0.05, vjust=1.20, size = 50), 
        axis.text.x = element_text(colour="black",size=60,angle=0,hjust=.5,vjust=.5,face="plain"),
        axis.text.y = element_text(colour="black",size=60,angle=0,hjust=1,vjust=0,face="plain"),  
        axis.title.x = element_text(colour="black",size=60,angle=0,hjust=.5,vjust=0,face="plain"),
        axis.title.y = element_text(colour="black",size=60,angle=90,hjust=.5,vjust=.5,face="plain")) + 
  geom_vline(xintercept = -61, colour = "blue") +
  geom_vline(xintercept = -21, colour = "blue") +
  geom_vline(xintercept = -41, colour = "black") 

df10 <- tidyr::gather(data_final10)
colnames(df10) <- c("Phi",   "value")
ggplot(df10, aes(x = value, fill = Phi, colour= Phi)) + 
  geom_histogram(aes(y=2.5*..density..), binwidth=2.5, alpha=0.3, lwd=0.2, position = "identity") +
  labs(x=expression(Grados (º)), y="(Frecuencia)")+
  scale_x_continuous(expand = c(0.01, 10), limits = c(-180,180), breaks = seq(-180,180,40)) +
  scale_y_continuous(expand=c(0,0.0), limits = c(0,0.16), breaks = seq(0,0.16,0.05)) +
  scale_fill_manual(values = c("red", "green", "blue", "yellow")) + 
  ggtitle("(E)") +
  theme_minimal()+
  theme(legend.position = c(0.8, 0.8), legend.key.size = unit(2.0, "cm"), legend.text=element_text(size=50), legend.title=element_text(size=50),  
        plot.title = element_text(hjust = 0.05, vjust=1.20, size = 50), 
        axis.text.x = element_text(colour="black",size=60,angle=0,hjust=.5,vjust=.5,face="plain"),
        axis.text.y = element_text(colour="black",size=60,angle=0,hjust=1,vjust=0,face="plain"),  
        axis.title.x = element_text(colour="black",size=60,angle=0,hjust=.5,vjust=0,face="plain"),
        axis.title.y = element_text(colour="black",size=60,angle=90,hjust=.5,vjust=.5,face="plain")) + 
  geom_vline(xintercept = -61, colour = "blue") +
  geom_vline(xintercept = -21, colour = "blue") +
  geom_vline(xintercept = -41, colour = "black") 

df12 <- tidyr::gather(data_final12)
colnames(df12) <- c("Phi",   "value")
ggplot(df12, aes(x = value, fill = Phi, colour= Phi)) + 
  geom_histogram(aes(y=2.5*..density..), binwidth=2.5, alpha=0.3, lwd=0.2, position = "identity") +
  labs(x=expression(Grados (º)), y="(Frecuencia)")+
  scale_x_continuous(expand = c(0.01, 10), limits = c(-180,180), breaks = seq(-180,180,40)) +
  scale_y_continuous(expand=c(0,0.0), limits = c(0,0.16), breaks = seq(0,0.16,0.05)) +
  scale_fill_manual(values = c("red", "green", "blue", "yellow")) + 
  ggtitle("(F)") +
  theme_minimal()+
  theme(legend.position = c(0.8, 0.8), legend.key.size = unit(2.0, "cm"), legend.text=element_text(size=50), legend.title=element_text(size=50),  
        plot.title = element_text(hjust = 0.05, vjust=1.20, size = 50), 
        axis.text.x = element_text(colour="black",size=60,angle=0,hjust=.5,vjust=.5,face="plain"),
        axis.text.y = element_text(colour="black",size=60,angle=0,hjust=1,vjust=0,face="plain"),  
        axis.title.x = element_text(colour="black",size=60,angle=0,hjust=.5,vjust=0,face="plain"),
        axis.title.y = element_text(colour="black",size=60,angle=90,hjust=.5,vjust=.5,face="plain")) + 
  geom_vline(xintercept = -61, colour = "blue") +
  geom_vline(xintercept = -21, colour = "blue") +
  geom_vline(xintercept = -41, colour = "black") 

df14 <- tidyr::gather(data_final14)
colnames(df14) <- c("Phi",   "value")
ggplot(df14, aes(x = value, fill = Phi, colour= Phi)) + 
  geom_histogram(aes(y=2.5*..density..), binwidth=2.5, alpha=0.3, lwd=0.2, position = "identity") +
  labs(x=expression(Grados (º)), y="(Frecuencia)")+
  scale_x_continuous(expand = c(0.01, 10), limits = c(-180,180), breaks = seq(-180,180,40)) +
  scale_y_continuous(expand=c(0,0.0), limits = c(0,0.16), breaks = seq(0,0.16,0.05)) +
  scale_fill_manual(values = c("red", "green", "blue", "yellow")) + 
  ggtitle("(G)") +
  theme_minimal()+
  theme(legend.position = c(0.8, 0.8), legend.key.size = unit(2.0, "cm"), legend.text=element_text(size=50), legend.title=element_text(size=50),  
        plot.title = element_text(hjust = 0.05, vjust=1.20, size = 50), 
        axis.text.x = element_text(colour="black",size=60,angle=0,hjust=.5,vjust=.5,face="plain"),
        axis.text.y = element_text(colour="black",size=60,angle=0,hjust=1,vjust=0,face="plain"),  
        axis.title.x = element_text(colour="black",size=60,angle=0,hjust=.5,vjust=0,face="plain"),
        axis.title.y = element_text(colour="black",size=60,angle=90,hjust=.5,vjust=.5,face="plain")) + 
  geom_vline(xintercept = -61, colour = "blue") +
  geom_vline(xintercept = -21, colour = "blue") +
  geom_vline(xintercept = -41, colour = "black") 

df16 <- tidyr::gather(data_final16)
colnames(df16) <- c("Phi",   "value")
ggplot(df16, aes(x = value, fill = Phi, colour= Phi)) + 
  geom_histogram(aes(y=2.5*..density..), binwidth=2.5, alpha=0.3, lwd=0.2, position = "identity") +
  labs(x=expression(Grados (º)), y="(Frecuencia)")+
  scale_x_continuous(expand = c(0.01, 10), limits = c(-180,180), breaks = seq(-180,180,40)) +
  scale_y_continuous(expand=c(0,0.0), limits = c(0,0.16), breaks = seq(0,0.16,0.05)) +
  scale_fill_manual(values = c("red", "green", "blue", "yellow")) + 
  ggtitle("(H)") +
  theme_minimal()+
  theme(legend.position = c(0.8, 0.8), legend.key.size = unit(2.0, "cm"), legend.text=element_text(size=50), legend.title=element_text(size=50),  
        plot.title = element_text(hjust = 0.05, vjust=1.20, size = 50), 
        axis.text.x = element_text(colour="black",size=60,angle=0,hjust=.5,vjust=.5,face="plain"),
        axis.text.y = element_text(colour="black",size=60,angle=0,hjust=1,vjust=0,face="plain"),  
        axis.title.x = element_text(colour="black",size=60,angle=0,hjust=.5,vjust=0,face="plain"),
        axis.title.y = element_text(colour="black",size=60,angle=90,hjust=.5,vjust=.5,face="plain")) + 
  geom_vline(xintercept = -61, colour = "blue") +
  geom_vline(xintercept = -21, colour = "blue") +
  geom_vline(xintercept = -41, colour = "black") 
  
df18 <- tidyr::gather(data_final18)
colnames(df18) <- c("Phi",   "value")
ggplot(df18, aes(x = value, fill = Phi, colour= Phi)) + 
  geom_histogram(aes(y=2.5*..density..), binwidth=2.5, alpha=0.3, lwd=0.2, position = "identity") +
  labs(x=expression(Grados (º)), y="(Frecuencia)")+
  scale_x_continuous(expand = c(0.01, 10), limits = c(-180,180), breaks = seq(-180,180,40)) +
  scale_y_continuous(expand=c(0,0.0), limits = c(0,0.16), breaks = seq(0,0.16,0.05)) +
  scale_fill_manual(values = c("red", "green", "blue", "yellow")) + 
  ggtitle("(I)") +
  theme_minimal()+
  theme(legend.position = c(0.8, 0.8), legend.key.size = unit(2.0, "cm"), legend.text=element_text(size=50), legend.title=element_text(size=50),  
        plot.title = element_text(hjust = 0.05, vjust=1.20, size = 50), 
        axis.text.x = element_text(colour="black",size=60,angle=0,hjust=.5,vjust=.5,face="plain"),
        axis.text.y = element_text(colour="black",size=60,angle=0,hjust=1,vjust=0,face="plain"),  
        axis.title.x = element_text(colour="black",size=60,angle=0,hjust=.5,vjust=0,face="plain"),
        axis.title.y = element_text(colour="black",size=60,angle=90,hjust=.5,vjust=.5,face="plain")) + 
  geom_vline(xintercept = -61, colour = "blue") +
  geom_vline(xintercept = -21, colour = "blue") +
  geom_vline(xintercept = -41, colour = "black") 

df20 <- tidyr::gather(data_final20)
colnames(df20) <- c("Phi",   "value")
ggplot(df20, aes(x = value, fill = Phi, colour= Phi)) + 
  geom_histogram(aes(y=2.5*..density..), binwidth=2.5, alpha=0.3, lwd=0.2, position = "identity") +
  labs(x=expression(Grados (º)), y="(Frecuencia)")+
  scale_x_continuous(expand = c(0.01, 10), limits = c(-180,180), breaks = seq(-180,180,40)) +
  scale_y_continuous(expand=c(0,0.0), limits = c(0,0.16), breaks = seq(0,0.16,0.05)) +
  scale_fill_manual(values = c("red", "green", "blue", "yellow")) + 
  ggtitle("(J)") +
  theme_minimal()+
  theme(legend.position = c(0.8, 0.8), legend.key.size = unit(2.0, "cm"), legend.text=element_text(size=50), legend.title=element_text(size=50),  
        plot.title = element_text(hjust = 0.05, vjust=1.20, size = 50), 
        axis.text.x = element_text(colour="black",size=60,angle=0,hjust=.5,vjust=.5,face="plain"),
        axis.text.y = element_text(colour="black",size=60,angle=0,hjust=1,vjust=0,face="plain"),  
        axis.title.x = element_text(colour="black",size=60,angle=0,hjust=.5,vjust=0,face="plain"),
        axis.title.y = element_text(colour="black",size=60,angle=90,hjust=.5,vjust=.5,face="plain")) + 
  geom_vline(xintercept = -61, colour = "blue") +
  geom_vline(xintercept = -21, colour = "blue") +
  geom_vline(xintercept = -41, colour = "black") 
dev.off()






#Diagrama de Ramachandran: 
colnames(data1) <- c("V1","V2","V3","V4","V5","V6","V7","V8","V9","V10","V11","V12","V13","V14","V15","V16","V17","V18","V19","V20")
colnames(data2) <- c("V1","V2","V3","V4","V5","V6","V7","V8","V9","V10","V11","V12","V13","V14","V15","V16","V17","V18","V19","V20")
colnames(data3) <- c("V1","V2","V3","V4","V5","V6","V7","V8","V9","V10","V11","V12","V13","V14","V15","V16","V17","V18","V19","V20")
colnames(data4) <- c("V1","V2","V3","V4","V5","V6","V7","V8","V9","V10","V11","V12","V13","V14","V15","V16","V17","V18","V19","V20")

#Dividimos las variables: 
df1<-data.frame(x=data1$V1,y=data1$V2)
df2<-data.frame(x=data1$V3,y=data1$V4)
df3<-data.frame(x=data1$V5,y=data1$V6)
df4<-data.frame(x=data1$V7,y=data1$V8)
df5<-data.frame(x=data1$V9,y=data1$V10)
df6<-data.frame(x=data1$V11,y=data1$V12)
df7<-data.frame(x=data1$V13,y=data1$V14)
df8<-data.frame(x=data1$V15,y=data1$V16)
df9<-data.frame(x=data1$V17,y=data1$V18)
df10<-data.frame(x=data1$V19,y=data1$V20)

#Dividimos las variables: 
df11<-data.frame(x=data2$V1,y=data2$V2)
df12<-data.frame(x=data2$V3,y=data2$V4)
df13<-data.frame(x=data2$V5,y=data2$V6)
df14<-data.frame(x=data2$V7,y=data2$V8)
df15<-data.frame(x=data2$V9,y=data2$V10)
df16<-data.frame(x=data2$V11,y=data2$V12)
df17<-data.frame(x=data2$V13,y=data2$V14)
df18<-data.frame(x=data2$V15,y=data2$V16)
df19<-data.frame(x=data2$V17,y=data2$V18)
df20<-data.frame(x=data2$V19,y=data2$V20)

#Dividimos las variables: 
df21<-data.frame(x=data3$V1,y=data3$V2)
df22<-data.frame(x=data3$V3,y=data3$V4)
df23<-data.frame(x=data3$V5,y=data3$V6)
df24<-data.frame(x=data3$V7,y=data3$V8)
df25<-data.frame(x=data3$V9,y=data3$V10)
df26<-data.frame(x=data3$V11,y=data3$V12)
df27<-data.frame(x=data3$V13,y=data3$V14)
df28<-data.frame(x=data3$V15,y=data3$V16)
df29<-data.frame(x=data3$V17,y=data3$V18)
df30<-data.frame(x=data3$V19,y=data3$V20)

#Dividimos las variables: 
df31<-data.frame(x=data4$V1,y=data4$V2)
df32<-data.frame(x=data4$V3,y=data4$V4)
df33<-data.frame(x=data4$V5,y=data4$V6)
df34<-data.frame(x=data4$V7,y=data4$V8)
df35<-data.frame(x=data4$V9,y=data4$V10)
df36<-data.frame(x=data4$V11,y=data4$V12)
df37<-data.frame(x=data4$V13,y=data4$V14)
df38<-data.frame(x=data4$V15,y=data4$V16)
df39<-data.frame(x=data4$V17,y=data4$V18)
df40<-data.frame(x=data4$V19,y=data4$V20)

#Ramachandra separado: 
# #Ang1
# ggplot() +
#   geom_point(data = df1, alpha = 0.2, aes(x = x, y = y), color='red') +
#   scale_x_continuous( limits = c(-180, 180), breaks = scales::pretty_breaks(n = 10)) +
#   scale_y_continuous(limits = c(-180, 180), breaks = scales::pretty_breaks(n = 10)) +
#   ggtitle('PP1') +
#   ylab(expression(paste(psi))) + 
#   xlab(expression(paste(phi)))

#Ang1-Densidad: 
p <- ggplot(df1) +
  scale_x_continuous(limits = c(-180,180), breaks = seq(-180,180,40), expand=c(0,0)) +
  scale_y_continuous(limits = c(-180,180), breaks = seq(-180,180,40), expand=c(0,0)) +
  geom_hex(aes(x, y), bins = 500) +
  ggtitle('PP1') +
  scale_fill_gradientn("", colours = rev(rainbow(10, end = 4/6))) + 
  ylab(expression(paste(psi))) + xlab(expression(paste(phi)))
print(p)

# #Ang2
# ggplot() +
#   geom_point(data = df2, alpha = 0.2, aes(x = x, y = y), color='orange') +
#   scale_x_continuous( limits = c(-180, 180), breaks = scales::pretty_breaks(n = 10)) +
#   scale_y_continuous(limits = c(-180, 180), breaks = scales::pretty_breaks(n = 10)) +
#   ggtitle('PP2') +
#   ylab(expression(paste(psi))) + 
#   xlab(expression(paste(phi)))

#Ang2-Densidad: 
p <- ggplot(df2) +
  scale_x_continuous(limits = c(-180,180), breaks = seq(-180,180,40), expand=c(0,0)) +
  scale_y_continuous(limits = c(-180,180), breaks = seq(-180,180,40), expand=c(0,0)) +
  geom_hex(aes(x, y), bins = 500) +
  ggtitle('PP2') +
  scale_fill_gradientn("", colours = rev(rainbow(10, end = 4/6))) + 
  ylab(expression(paste(psi))) + xlab(expression(paste(phi)))
print(p)

# #Ang3
# ggplot() +
#   geom_point(data = df3, alpha = 0.2, aes(x = x, y = y), color='yellow') +
#   scale_x_continuous( limits = c(-180, 180), breaks = scales::pretty_breaks(n = 10)) +
#   scale_y_continuous(limits = c(-180, 180), breaks = scales::pretty_breaks(n = 10)) +
#   ggtitle('PP3') +
#   ylab(expression(paste(psi))) + 
#   xlab(expression(paste(phi)))

#Ang2-Densidad: 
p <- ggplot(df3) +
  scale_x_continuous(limits = c(-180,180), breaks = seq(-180,180,40), expand=c(0,0)) +
  scale_y_continuous(limits = c(-180,180), breaks = seq(-180,180,40), expand=c(0,0)) +
  geom_hex(aes(x, y), bins = 500) +
  ggtitle('PP3') +
  scale_fill_gradientn("", colours = rev(rainbow(10, end = 4/6))) + 
  ylab(expression(paste(psi))) + xlab(expression(paste(phi)))
print(p)

#Ang4
# ggplot() +
#   geom_point(data = df4, alpha = 0.2, aes(x = x, y = y), color='darkgreen') +
#   scale_x_continuous( limits = c(-180, 180), breaks = scales::pretty_breaks(n = 10)) +
#   scale_y_continuous(limits = c(-180, 180), breaks = scales::pretty_breaks(n = 10)) +
#   ggtitle('PP4') +
#   ylab(expression(paste(psi))) + 
#   xlab(expression(paste(phi)))

#Ang2-Densidad: 
p <- ggplot(df4) +
  scale_x_continuous(limits = c(-180,180), breaks = seq(-180,180,40), expand=c(0,0)) +
  scale_y_continuous(limits = c(-180,180), breaks = seq(-180,180,40), expand=c(0,0)) +
  geom_hex(aes(x, y), bins = 500) +
  ggtitle('PP4') +
  scale_fill_gradientn("", colours = rev(rainbow(10, end = 4/6))) + 
  ylab(expression(paste(psi))) + xlab(expression(paste(phi)))
print(p)

# #Ang5
# ggplot() +
#   geom_point(data = df5, alpha = 0.2, aes(x = x, y = y), color='green') +
#   scale_x_continuous( limits = c(-180, 180), breaks = scales::pretty_breaks(n = 10)) +
#   scale_y_continuous(limits = c(-180, 180), breaks = scales::pretty_breaks(n = 10)) +
#   ggtitle('PP5') +
#   ylab(expression(paste(psi))) + 
#   xlab(expression(paste(phi)))

#Ang2-Densidad: 
p <- ggplot(df5) +
  scale_x_continuous(limits = c(-180,180), breaks = seq(-180,180,40), expand=c(0,0)) +
  scale_y_continuous(limits = c(-180,180), breaks = seq(-180,180,40), expand=c(0,0)) +
  geom_hex(aes(x, y), bins = 500) +
  ggtitle('PP5') +
  scale_fill_gradientn("", colours = rev(rainbow(10, end = 4/6))) + 
  ylab(expression(paste(psi))) + xlab(expression(paste(phi)))
print(p)

# #Ang6
# ggplot() +
#   geom_point(data = df6, alpha = 0.2, aes(x = x, y = y), color='skyblue') +
#   scale_x_continuous( limits = c(-180, 180), breaks = scales::pretty_breaks(n = 10)) +
#   scale_y_continuous(limits = c(-180, 180), breaks = scales::pretty_breaks(n = 10)) +
#   ggtitle('PP6') +
#   ylab(expression(paste(psi))) + 
#   xlab(expression(paste(phi)))

#Ang2-Densidad: 
p <- ggplot(df6) +
  scale_x_continuous(limits = c(-180,180), breaks = seq(-180,180,40), expand=c(0,0)) +
  scale_y_continuous(limits = c(-180,180), breaks = seq(-180,180,40), expand=c(0,0)) +
  geom_hex(aes(x, y), bins = 500) +
  ggtitle('PP6') +
  scale_fill_gradientn("", colours = rev(rainbow(10, end = 4/6))) + 
  ylab(expression(paste(psi))) + xlab(expression(paste(phi)))
print(p)


# #Ang7
# ggplot() +
#   geom_point(data = df7, alpha = 0.2, aes(x = x, y = y), color='blue') +
#   scale_x_continuous( limits = c(-180, 180), breaks = scales::pretty_breaks(n = 10)) +
#   scale_y_continuous(limits = c(-180, 180), breaks = scales::pretty_breaks(n = 10)) +
#   ggtitle('PP7') +
#   ylab(expression(paste(psi))) + 
#   xlab(expression(paste(phi)))

#Ang2-Densidad: 
p <- ggplot(df7) +
  scale_x_continuous(limits = c(-180,180), breaks = seq(-180,180,40), expand=c(0,0)) +
  scale_y_continuous(limits = c(-180,180), breaks = seq(-180,180,40), expand=c(0,0)) +
  geom_hex(aes(x, y), bins = 500) +
  ggtitle('PP7') +
  scale_fill_gradientn("", colours = rev(rainbow(10, end = 4/6))) + 
  ylab(expression(paste(psi))) + xlab(expression(paste(phi)))
print(p)


# #Ang8
# ggplot() +
#   geom_point(data = df8, alpha = 0.2, aes(x = x, y = y), color='darkred') +
#   scale_x_continuous( limits = c(-180, 180), breaks = scales::pretty_breaks(n = 10)) +
#   scale_y_continuous(limits = c(-180, 180), breaks = scales::pretty_breaks(n = 10)) +
#   ggtitle('PP8') +
#   ylab(expression(paste(psi))) + 
#   xlab(expression(paste(phi)))

#Ang2-Densidad: 
p <- ggplot(df8) +
  scale_x_continuous(limits = c(-180,180), breaks = seq(-180,180,40), expand=c(0,0)) +
  scale_y_continuous(limits = c(-180,180), breaks = seq(-180,180,40), expand=c(0,0)) +
  geom_hex(aes(x, y), bins = 500) +
  ggtitle('PP8') +
  scale_fill_gradientn("", colours = rev(rainbow(10, end = 4/6))) + 
  ylab(expression(paste(psi))) + xlab(expression(paste(phi)))
print(p)


# #Ang9
# ggplot() +
#   geom_point(data = df9, alpha = 0.2, aes(x = x, y = y), color='purple') +
#   scale_x_continuous( limits = c(-180, 180), breaks = scales::pretty_breaks(n = 10)) +
#   scale_y_continuous(limits = c(-180, 180), breaks = scales::pretty_breaks(n = 10)) +
#   ggtitle('PP9') +
#   ylab(expression(paste(psi))) + 
#   xlab(expression(paste(phi)))

#Ang2-Densidad: 
p <- ggplot(df9) +
  scale_x_continuous(limits = c(-180,180), breaks = seq(-180,180,40), expand=c(0,0)) +
  scale_y_continuous(limits = c(-180,180), breaks = seq(-180,180,40), expand=c(0,0)) +
  geom_hex(aes(x, y), bins = 500) +
  ggtitle('PP9') +
  scale_fill_gradientn("", colours = rev(rainbow(10, end = 4/6))) + 
  ylab(expression(paste(psi))) + xlab(expression(paste(phi)))
print(p)

##Ang10
# ggplot() +
#   geom_point(data = df10, alpha = 0.2, aes(x = x, y = y), color='pink') +
#   scale_x_continuous( limits = c(-180, 180), breaks = scales::pretty_breaks(n = 10)) +
#   scale_y_continuous(limits = c(-180, 180), breaks = scales::pretty_breaks(n = 10)) +
#   ggtitle('PP10') +
#   ylab(expression(paste(psi))) + 
#   xlab(expression(paste(phi)))

#Ang2-Densidad: 
p <- ggplot(df10) +
  scale_x_continuous(limits = c(-180,180), breaks = seq(-180,180,40), expand=c(0,0)) +
  scale_y_continuous(limits = c(-180,180), breaks = seq(-180,180,40), expand=c(0,0)) +
  geom_hex(aes(x, y), bins = 500) +
  ggtitle('PP10') +
  scale_fill_gradientn("", colours = rev(rainbow(10, end = 4/6))) + 
  ylab(expression(paste(psi))) + xlab(expression(paste(phi)))
print(p)

# 
# 
# #Diagrama ramachandran de todos los ángulos: 
# ggplot() +
#   scale_x_continuous( limits = c(-180, 180), breaks = scales::pretty_breaks(n = 10)) +
#   scale_y_continuous(limits = c(-180, 180), breaks = scales::pretty_breaks(n = 10)) +
#   geom_point(data = df1, alpha = 0.2, aes(x = x, y = y, color = "Angle 01")) +
#   geom_point(data = df2, alpha = 0.2, aes(x = x, y = y, color = "Angle 02")) +
#   geom_point(data = df3, alpha = 0.2, aes(x = x, y = y, color = "Angle 03")) +
#   geom_point(data = df4, alpha = 0.2, aes(x = x, y = y, color = "Angle 04")) +
#   geom_point(data = df5, alpha = 0.2, aes(x = x, y = y, color = "Angle 05")) +
#   geom_point(data = df6, alpha = 0.2, aes(x = x, y = y, color = "Angle 06")) +
#   geom_point(data = df7, alpha = 0.2, aes(x = x, y = y, color = "Angle 07")) +
#   geom_point(data = df8, alpha = 0.2, aes(x = x, y = y, color = "Angle 08")) +
#   geom_point(data = df9, alpha = 0.2, aes(x = x, y = y, color = "Angle 09")) +
#   geom_point(data = df10, alpha = 0.2, aes(x = x, y = y, color = "Angle 10")) +
#   ggtitle('Ramachandran Plot') +
#   ylab(expression(paste(psi))) + xlab(expression(paste(phi)))

cairo_pdf(file = "Ramachandran.pdf", width = 20, height = 15, , onefile = TRUE)

#Otra manera de verlo: 
result<-rbind(df1,df2,df3 ,df4 ,df5 ,df6 ,df7 ,df8,df9 ,df10)
data.line <- data.frame(x1 = 0, x2 = -180, y1 = 0, y2 = 0)
data.line2 <- data.frame(x1 = 0, x2 = -180, y1 = -135, y2 = -135)

ggplot(result) + 
  scale_x_continuous(limits = c(-180,180), breaks = seq(-180,180,40), expand=c(0,0)) +
  scale_y_continuous(limits = c(-180,180), breaks = seq(-180,180,40), expand=c(0,0)) +
  geom_hex(aes(x, y), bins = 500) +
  geom_vline(xintercept = 0, colour="red", linetype = "dashed") +
  geom_segment(aes(x = x1, y = y1, xend = x2, yend = y2), data = data.line, linetype = "dashed", colour="red")+
  geom_segment(aes(x = x1, y = y1, xend = x2, yend = y2), data = data.line2, linetype = "longdash",colour="red")+
  scale_fill_gradientn("", colours = rev(rainbow(10, end = 4/6))) + 
  ylab(expression(paste(psi))) + 
  xlab(expression(paste(phi))) +
  ggtitle("(A)")+
  theme(legend.key.size = unit(1.5, "cm"), legend.text=element_text(size=30), legend.title=element_text(size=30),  
  plot.title = element_text(hjust = 0.05, vjust=1.20, size = 50), 
  axis.text.x = element_text(colour="black",size=60,angle=0,hjust=.5,vjust=.5,face="plain"),
  axis.text.y = element_text(colour="black",size=60,angle=0,hjust=1,vjust=0,face="plain"),  
  axis.title.x = element_text(colour="black",size=60,angle=0,hjust=.5,vjust=0,face="plain"),
  axis.title.y = element_text(colour="black",size=60,angle=90,hjust=.5,vjust=.5,face="plain"))+
  annotate("text", x = -10, y = -10, label = "\u03B1", colour = "red", size = 20)+
  annotate("text", x = -10, y = 170, label = "\u03B2", colour = "red", size = 20)+
  annotate("text", x = -10, y = -150, label = "\u03B2", colour = "red", size = 20)
  

#Otra manera de verlo: 
result<-rbind(df11,df12,df13 ,df14 ,df15 ,df16 ,df17 ,df18,df19 ,df20)
data.line <- data.frame(x1 = 0, x2 = -180, y1 = 0, y2 = 0)
data.line2 <- data.frame(x1 = 0, x2 = -180, y1 = -135, y2 = -135)
ggplot(result) + 
  scale_x_continuous(limits = c(-180,180), breaks = seq(-180,180,40), expand=c(0,0)) +
  scale_y_continuous(limits = c(-180,180), breaks = seq(-180,180,40), expand=c(0,0)) +
  geom_hex(aes(x, y), bins = 500) +
  geom_vline(xintercept = 0, colour="red", linetype = "dashed") +
  geom_segment(aes(x = x1, y = y1, xend = x2, yend = y2), data = data.line, linetype = "dashed", colour="red")+
  geom_segment(aes(x = x1, y = y1, xend = x2, yend = y2), data = data.line2, linetype = "longdash",colour="red")+
  scale_fill_gradientn("", colours = rev(rainbow(10, end = 4/6))) + 
  ylab(expression(paste(psi))) + 
  xlab(expression(paste(phi))) +
  ggtitle("(B)")+
  theme(legend.key.size = unit(1.5, "cm"), legend.text=element_text(size=30), legend.title=element_text(size=30),  
  plot.title = element_text(hjust = 0.05, vjust=1.20, size = 50), 
  axis.text.x = element_text(colour="black",size=60,angle=0,hjust=.5,vjust=.5,face="plain"),
  axis.text.y = element_text(colour="black",size=60,angle=0,hjust=1,vjust=0,face="plain"),  
  axis.title.x = element_text(colour="black",size=60,angle=0,hjust=.5,vjust=0,face="plain"),
  axis.title.y = element_text(colour="black",size=60,angle=90,hjust=.5,vjust=.5,face="plain"))+
  annotate("text", x = -10, y = -10, label = "\u03B1", colour = "red", size = 20)+
  annotate("text", x = -10, y = 170, label = "\u03B2", colour = "red", size = 20)+
  annotate("text", x = -10, y = -150, label = "\u03B2", colour = "red", size = 20)
#Otra manera de verlo: 
result<-rbind(df21,df22,df23 ,df24 ,df25 ,df26 ,df27 ,df28,df29 ,df30)
data.line <- data.frame(x1 = 0, x2 = -180, y1 = 0, y2 = 0)
data.line2 <- data.frame(x1 = 0, x2 = -180, y1 = -135, y2 = -135)
ggplot(result) + 
  scale_x_continuous(limits = c(-180,180), breaks = seq(-180,180,40), expand=c(0,0)) +
  scale_y_continuous(limits = c(-180,180), breaks = seq(-180,180,40), expand=c(0,0)) +
  geom_hex(aes(x, y), bins = 500) +
  geom_vline(xintercept = 0, colour="red", linetype = "dashed") +
  geom_segment(aes(x = x1, y = y1, xend = x2, yend = y2), data = data.line, linetype = "dashed", colour="red")+
  geom_segment(aes(x = x1, y = y1, xend = x2, yend = y2), data = data.line2, linetype = "longdash",colour="red")+
  scale_fill_gradientn("", colours = rev(rainbow(10, end = 4/6))) + 
  ylab(expression(paste(psi))) + 
  xlab(expression(paste(phi))) +
  ggtitle("(C)")+
  theme(legend.key.size = unit(1.5, "cm"), legend.text=element_text(size=30), legend.title=element_text(size=30),  
  plot.title = element_text(hjust = 0.05, vjust=1.20, size = 50), 
  axis.text.x = element_text(colour="black",size=60,angle=0,hjust=.5,vjust=.5,face="plain"),
  axis.text.y = element_text(colour="black",size=60,angle=0,hjust=1,vjust=0,face="plain"),  
  axis.title.x = element_text(colour="black",size=60,angle=0,hjust=.5,vjust=0,face="plain"),
  axis.title.y = element_text(colour="black",size=60,angle=90,hjust=.5,vjust=.5,face="plain"))+
  annotate("text", x = -10, y = -10, label = "\u03B1", colour = "red", size = 20)+
  annotate("text", x = -10, y = 170, label = "\u03B2", colour = "red", size = 20)+
  annotate("text", x = -10, y = -150, label = "\u03B2", colour = "red", size = 20)

result<-rbind(df31,df32,df33 ,df34 ,df35 ,df36 ,df37 ,df38,df39 ,df40)
data.line <- data.frame(x1 = 0, x2 = -180, y1 = 0, y2 = 0)
data.line2 <- data.frame(x1 = 0, x2 = -180, y1 = -135, y2 = -135)
ggplot(result) + 
  scale_x_continuous(limits = c(-180,180), breaks = seq(-180,180,40), expand=c(0,0)) +
  scale_y_continuous(limits = c(-180,180), breaks = seq(-180,180,40), expand=c(0,0)) +
  geom_hex(aes(x, y), bins = 500) +
  geom_vline(xintercept = 0, colour="red", linetype = "dashed") +
  geom_segment(aes(x = x1, y = y1, xend = x2, yend = y2), data = data.line, linetype = "dashed", colour="red")+
  geom_segment(aes(x = x1, y = y1, xend = x2, yend = y2), data = data.line2, linetype = "longdash",colour="red")+
  scale_fill_gradientn("", colours = rev(rainbow(10, end = 4/6))) + 
  ylab(expression(paste(psi))) + 
  xlab(expression(paste(phi))) +
  ggtitle("(D)")+
  theme(legend.key.size = unit(1.5, "cm"), legend.text=element_text(size=30), legend.title=element_text(size=30),  
  plot.title = element_text(hjust = 0.05, vjust=1.20, size = 50), 
  axis.text.x = element_text(colour="black",size=60,angle=0,hjust=.5,vjust=.5,face="plain"),
  axis.text.y = element_text(colour="black",size=60,angle=0,hjust=1,vjust=0,face="plain"),  
  axis.title.x = element_text(colour="black",size=60,angle=0,hjust=.5,vjust=0,face="plain"),
  axis.title.y = element_text(colour="black",size=60,angle=90,hjust=.5,vjust=.5,face="plain"))+
  annotate("text", x = -10, y = -10, label = "\u03B1", colour = "red", size = 20)+
  annotate("text", x = -10, y = 170, label = "\u03B2", colour = "red", size = 20)+
  annotate("text", x = -10, y = -150, label = "\u03B2", colour = "red", size = 20)
dev.off()

#Calculo porcentajes data1 
#Phi
sum((data1$V1 > -82 & data1$V1 < -42) / nrow(data1))*100 
sum((data1$V3 > -82 & data1$V3 < -42) / nrow(data1))*100 
sum((data1$V5 > -82 & data1$V5 < -42) / nrow(data1))*100 
sum((data1$V7 > -82 & data1$V7 < -42) / nrow(data1))*100 
sum((data1$V9 > -82 & data1$V9 < -42) / nrow(data1))*100 
sum((data1$V11 > -82 & data1$V11 < -42) / nrow(data1))*100 
sum((data1$V13 > -82 & data1$V13 < -42) / nrow(data1))*100 
sum((data1$V15 > -82 & data1$V15 < -42) / nrow(data1))*100 
sum((data1$V17 > -82 & data1$V17 < -42) / nrow(data1))*100 
sum((data1$V19 > -82 & data1$V19 < -42) / nrow(data1))*100 

#Psi
sum((data1$V2 > -61 & data1$V2 < -21) / nrow(data1))*100 
sum((data1$V4 > -61 & data1$V4 < -21) / nrow(data1))*100 
sum((data1$V6 > -61 & data1$V6 < -21) / nrow(data1))*100 
sum((data1$V8 > -61 & data1$V8 < -21) / nrow(data1))*100 
sum((data1$V10 > -61 & data1$V10 < -21) / nrow(data1))*100 
sum((data1$V12 > -61 & data1$V12 < -21) / nrow(data1))*100 
sum((data1$V14 > -61 & data1$V14 < -21) / nrow(data1))*100 
sum((data1$V16 > -61 & data1$V16 < -21) / nrow(data1))*100 
sum((data1$V18 > -61 & data1$V18 < -21) / nrow(data1))*100 
sum((data1$V20 > -61 & data1$V20 < -21) / nrow(data1))*100 

#Calculo porcentajes data2
#Phi
sum((data2$V1 > -82 & data2$V1 < -42) / nrow(data2))*100 
sum((data2$V3 > -82 & data2$V3 < -42) / nrow(data2))*100 
sum((data2$V5 > -82 & data2$V5 < -42) / nrow(data2))*100 
sum((data2$V7 > -82 & data2$V7 < -42) / nrow(data2))*100 
sum((data2$V9 > -82 & data2$V9 < -42) / nrow(data2))*100 
sum((data2$V11 > -82 & data2$V11 < -42) / nrow(data2))*100 
sum((data2$V13 > -82 & data2$V13 < -42) / nrow(data2))*100 
sum((data2$V15 > -82 & data2$V15 < -42) / nrow(data2))*100 
sum((data2$V17 > -82 & data2$V17 < -42) / nrow(data2))*100 
sum((data2$V19 > -82 & data2$V19 < -42) / nrow(data2))*100 

#Psi
sum((data2$V2 > -61 & data2$V2 < -21) / nrow(data2))*100 
sum((data2$V4 > -61 & data2$V4 < -21) / nrow(data2))*100 
sum((data2$V6 > -61 & data2$V6 < -21) / nrow(data2))*100 
sum((data2$V8 > -61 & data2$V8 < -21) / nrow(data2))*100 
sum((data2$V10 > -61 & data2$V10 < -21) / nrow(data2))*100 
sum((data2$V12 > -61 & data2$V12 < -21) / nrow(data2))*100 
sum((data2$V14 > -61 & data2$V14 < -21) / nrow(data2))*100 
sum((data2$V16 > -61 & data2$V16 < -21) / nrow(data2))*100 
sum((data2$V18 > -61 & data2$V18 < -21) / nrow(data2))*100 
sum((data2$V20 > -61 & data2$V20 < -21) / nrow(data2))*100 

#Calculo porcentajes data3 
#Phi
sum((data3$V1 > -82 & data3$V1 < -42) / nrow(data3))*100 
sum((data3$V3 > -82 & data3$V3 < -42) / nrow(data3))*100 
sum((data3$V5 > -82 & data3$V5 < -42) / nrow(data3))*100 
sum((data3$V7 > -82 & data3$V7 < -42) / nrow(data3))*100 
sum((data3$V9 > -82 & data3$V9 < -42) / nrow(data3))*100 
sum((data3$V11 > -82 & data3$V11 < -42) / nrow(data3))*100 
sum((data3$V13 > -82 & data3$V13 < -42) / nrow(data3))*100 
sum((data3$V15 > -82 & data3$V15 < -42) / nrow(data3))*100 
sum((data3$V17 > -82 & data3$V17 < -42) / nrow(data3))*100 
sum((data3$V19 > -82 & data3$V19 < -42) / nrow(data3))*100 

#Psi
sum((data3$V2 > -61 & data3$V2 < -21) / nrow(data3))*100 
sum((data3$V4 > -61 & data3$V4 < -21) / nrow(data3))*100 
sum((data3$V6 > -61 & data3$V6 < -21) / nrow(data3))*100 
sum((data3$V8 > -61 & data3$V8 < -21) / nrow(data3))*100 
sum((data3$V10 > -61 & data3$V10 < -21) / nrow(data3))*100 
sum((data3$V12 > -61 & data3$V12 < -21) / nrow(data3))*100 
sum((data3$V14 > -61 & data3$V14 < -21) / nrow(data3))*100 
sum((data3$V16 > -61 & data3$V16 < -21) / nrow(data3))*100 
sum((data3$V18 > -61 & data3$V18 < -21) / nrow(data3))*100 
sum((data3$V20 > -61 & data3$V20 < -21) / nrow(data3))*100 

#Calculo porcentajes data4
#Phi
sum((data4$V1 > -82 & data4$V1 < -42) / nrow(data4))*100 
sum((data4$V3 > -82 & data4$V3 < -42) / nrow(data4))*100 
sum((data4$V5 > -82 & data4$V5 < -42) / nrow(data4))*100 
sum((data4$V7 > -82 & data4$V7 < -42) / nrow(data4))*100 
sum((data4$V9 > -82 & data4$V9 < -42) / nrow(data4))*100 
sum((data4$V11 > -82 & data4$V11 < -42) / nrow(data4))*100 
sum((data4$V13 > -82 & data4$V13 < -42) / nrow(data4))*100 
sum((data4$V15 > -82 & data4$V15 < -42) / nrow(data4))*100 
sum((data4$V17 > -82 & data4$V17 < -42) / nrow(data4))*100 
sum((data4$V19 > -82 & data4$V19 < -42) / nrow(data4))*100 

#Psi
sum((data4$V2 > -61 & data4$V2 < -21) / nrow(data4))*100 
sum((data4$V4 > -61 & data4$V4 < -21) / nrow(data4))*100 
sum((data4$V6 > -61 & data4$V6 < -21) / nrow(data4))*100 
sum((data4$V8 > -61 & data4$V8 < -21) / nrow(data4))*100 
sum((data4$V10 > -61 & data4$V10 < -21) / nrow(data4))*100 
sum((data4$V12 > -61 & data4$V12 < -21) / nrow(data4))*100 
sum((data4$V14 > -61 & data4$V14 < -21) / nrow(data4))*100 
sum((data4$V16 > -61 & data4$V16 < -21) / nrow(data4))*100 
sum((data4$V18 > -61 & data4$V18 < -21) / nrow(data4))*100 
sum((data4$V20 > -61 & data4$V20 < -21) / nrow(data4))*100 






Phi O
geom_vline(xintercept = -82, colour = "red") +
  geom_vline(xintercept = -42, colour = "red") +
  geom_vline(xintercept = -62, colour = "black") 

Psi Y
geom_vline(xintercept = -61, colour = "blue") +
  geom_vline(xintercept = -21, colour = "blue") +
  geom_vline(xintercept = -41, colour = "black") 
