######################################################################

# Scrit para la realización de histogramas de ángulos diedros y Ramachandran

######################################################################

#Comprobamos mediante este bucle si los paquetes necesarios están instalados...
packages <- c("gridExtra","ggplot2","assertthat", "tidyr", "hexbin")
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

#Cargamos los datos que vamos a tuilizar y añadimos nombres a las columnas
 data <- read.table(file.path(getwd(),"cache/dihedral_angle.dat"), quote="\"", comment.char="")
#data <- read.table("~/TFM/pruebas/cache/dihedral_angle.dat", quote="\"", comment.char="")
colnames(data) <- c('\u03D501','\u047001','\u03D502','\u047002','\u03D503','\u047003','\u03D504','\u047004','\u03D505','\u047005','\u03D506','\u047006','\u03D507','\u047007','\u03D508','\u047008','\u03D509','\u047009','\u03D510','\u047010')

#Bucle para realizar los histogramas individualmente: 
out<-list()
for (i in 1:20){
  x = data[,i]
  out[[i]] <- ggplot(data.frame(x), aes(x)) + 
  geom_histogram(aes(y=..count../sum(..count..)), fill="red", binwidth = 5, lwd=0.9, col=("black"), 
  alpha=I(.9)) + labs(x=expression(Grados (º)), y="Frecuencia") +  
  scale_x_continuous(breaks = pretty(x, n = 15)) +
  #Si añadimos expand = FALSE se eliminan los bordes. 
  coord_cartesian(xlim = c(-185, 185), expand = FALSE) +
  ggtitle(as.character()) + theme(legend.position = c(0.8, 0.2)) +
  theme_minimal()+
  ggtitle('\u03D5 \u0470') 
  grid.arrange(out[[i]], ncol=1)
}

#Este script sirve para representar 10:2 histogramas en una imagen:
# ggplot(melt(data), aes(x = value)) + 
#   facet_wrap(~ variable, scales = "free", ncol = 2) + 
#   geom_histogram(binwidth = 1)

#Cargamos los datos: 
angulos1_10.dat <- read.table(file.path(getwd(),"cache/angulos1_10.dat"), quote="\"", comment.char="")
angulos11_20.dat <- read.table(file.path(getwd(),"cache/angulos11_20.dat"), quote="\"", comment.char="")
#Unimos datos: 
result<-rbind(angulos1_10.dat, angulos11_20.dat)
colnames(result) <- c("Ang01","Ang02","Ang03","Ang04","Ang05","Ang06","Ang07","Ang08","Ang09","Ang10")


#Para hacer la unión de todos los histogramas: 
df2 <- tidyr::gather(result)
colnames(df2) <- c("HBs",   "value")
ggplot(df2, aes(x = value, fill = HBs)) + 
  geom_histogram(aes(y=..count../sum(..count..)), colour="black", binwidth = 2.5, alpha=.5, position = "identity") +
  scale_x_continuous(limits = c(-180,180), breaks = seq(-180,180,40), expand=c(0,0)) +
  scale_y_continuous( limits = c(0,0.016), breaks = seq(0,0.016,0.005), expand=c(0,0)) +
  scale_fill_manual(values = c("red", "blue", "green", "yellow", "orange", "grey", "pink", "#CC79A7", "lightgreen", "skyblue")) + 
  labs(x=expression(Grados (º)), y="Frecuencia") +
  theme_minimal()+
  ggtitle("(A)") +
  theme(plot.title = element_text(hjust = 0.0, vjust=2.12))+
  geom_vline(xintercept = -82, colour = "red") +
  geom_vline(xintercept = -42, colour = "red") +
  # geom_vline(xintercept = -62, colour = "black") +
   geom_vline(xintercept = -62, colour = "blue") +
   geom_vline(xintercept = -21, colour = "blue") 
  # geom_vline(xintercept = -41, colour = "black") 

#Diagrama de Ramachandran: 
colnames(data) <- c("V1","V2","V3","V4","V5","V6","V7","V8","V9","V10","V11","V12","V13","V14","V15","V16","V17","V18","V19","V20")

#Dividimos las variables: 
df1<-data.frame(x=data$V1,y=data$V2)
df2<-data.frame(x=data$V3,y=data$V4)
df3<-data.frame(x=data$V5,y=data$V6)
df4<-data.frame(x=data$V7,y=data$V8)
df5<-data.frame(x=data$V9,y=data$V10)
df6<-data.frame(x=data$V11,y=data$V12)
df7<-data.frame(x=data$V13,y=data$V14)
df8<-data.frame(x=data$V15,y=data$V16)
df9<-data.frame(x=data$V17,y=data$V18)
df10<-data.frame(x=data$V19,y=data$V20)

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


#Otra manera de verlo: 
result<-rbind(df1,df2,df3 ,df4 ,df5 ,df6 ,df7 ,df8,df9 ,df10)
df <- data.frame(x1 = 0, x2 = -180, y1 = 0, y2 = 0)
df2 <- data.frame(x1 = 0, x2 = -180, y1 = -135, y2 = -135)
  ggplot(result) + 
  scale_x_continuous(limits = c(-180,180), breaks = seq(-180,180,40), expand=c(0,0)) +
  scale_y_continuous(limits = c(-180,180), breaks = seq(-180,180,40), expand=c(0,0)) +
  geom_hex(aes(x, y), bins = 500) +
  geom_vline(xintercept = 0, colour="red", linetype = "dashed") +
  geom_segment(aes(x = x1, y = y1, xend = x2, yend = y2), data = df, linetype = "dashed", colour="red")+
  geom_segment(aes(x = x1, y = y1, xend = x2, yend = y2), data = df2, linetype = "longdash",colour="red")+
  scale_fill_gradientn("", colours = rev(rainbow(10, end = 4/6))) + ylab(expression(paste(psi))) + xlab(expression(paste(phi)))
  
