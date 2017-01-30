####################
#diedral_angles.R  #
####################

#Comprobamos mediante este bucle si los paquetes necesarios están instalados...
packages <- c("gridExtra","ggplot2","assertthat", "tidyr", "hexbin")
if (length(setdiff(packages, rownames(installed.packages()))) > 0) {
  install.packages(setdiff(packages, rownames(installed.packages())))  }

print("Realizando histogramas... Puede tardar un poco...")
options(warn=-1)
#Cargamos los paquetes que utilizaremos: 
library("ggplot2"); library("tidyr"); library("gridExtra"); 

#Cargamos los datos que vamos a utilizar
data <- read.table(file.path(getwd(),"cache/dihedral_angle.dat"), quote="\"", comment.char="")
angulos1_10.dat <- read.table(file.path(getwd(),"cache/angulos1_10.dat"), quote="\"", comment.char="")
angulos11_20.dat <- read.table(file.path(getwd(),"cache/angulos11_20.dat"), quote="\", comment.char="")

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
  geom_vline(xintercept = -62, colour = "blue") +
  geom_vline(xintercept = -21, colour = "blue") 

#Diagrama de Ramachandran: 
colnames(data) <- c("V1","V2","V3","V4","V5","V6","V7","V8","V9","V10","V11","V12","V13","V14","V15","V16","V17","V18","V19","V20")

#Dividimos las variables: 
df1<-data.frame(x=data$V1,y=data$V2); df2<-data.frame(x=data$V3,y=data$V4); df3<-data.frame(x=data$V5,y=data$V6)
df4<-data.frame(x=data$V7,y=data$V8); df5<-data.frame(x=data$V9,y=data$V10); df6<-data.frame(x=data$V11,y=data$V12)
df7<-data.frame(x=data$V13,y=data$V14); df8<-data.frame(x=data$V15,y=data$V16); df9<-data.frame(x=data$V17,y=data$V18)
df10<-data.frame(x=data$V19,y=data$V20)

#Generamos diagrama Ramachandran.  
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
  
