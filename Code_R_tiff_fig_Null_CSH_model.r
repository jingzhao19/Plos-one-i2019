rm(list=ls())
library(ggplot2)
est<-function (dcsh,dcshh,dcs,dcss,dt1,dt2,dt3,dt4,dt5){
  dcshm<- subset(dcsh,select=c(name,Effect,ProbF))
  dcshm$method<-"Heterogeneous_CS"
  dcshs<- subset(dcshh,select=c(name,Time,ProbF))
  dcshs$method<-"Heterogeneous_CS"
  names(dcshs)[2]<-"Effect"
  dcshs$Effect <- as.factor(dcshs$Effect)
  dcshs$Effect <- gsub("1", "week1", dcshs$Effect)
  dcshs$Effect <- gsub("2", "week7", dcshs$Effect)
  dcshs$Effect <- gsub("4", "week21", dcshs$Effect)
  dcshs$Effect <- gsub("5", "week28", dcshs$Effect)
  dcshs$Effect <- gsub("3", "week14", dcshs$Effect)
  dcsm<-subset(dcs,select=c(name,Effect,ProbF))
  dcsm$method<-"Homogenous_CS"
  dcss1<- subset(dcss,select=c(name,Time,ProbF))
  dcss1$method<-"Homogenous_CS"
  names(dcss1)[2]<-"Effect"
  dcss1$Effect<-as.factor(dcss1$Effect)
  dcss1$Effect<- gsub("1", "week1", dcss1$Effect)
  dcss1$Effect <- gsub("2", "week7", dcss1$Effect)
  dcss1$Effect <- gsub("4", "week21", dcss1$Effect)
  dcss1$Effect <- gsub("5", "week28", dcss1$Effect)
  dcss1$Effect <- gsub("3", "week14", dcss1$Effect)
  da1<- subset(dt1,Source=="Model",select=c(name,Source,ProbF))
  da1$method<-"Separate ANOVA"
  da1$Source <- gsub("Model", "week1", da1$Source)
  names(da1)[2]<-"Effect"
  da2<- subset(dt2,Source=="Model",select=c(name,Source,ProbF))
  da2$method<-"Separate ANOVA"
  da2$Source <- gsub("Model", "week7", da2$Source)
  names(da2)[2]<-"Effect"
  da3<- subset(dt3,Source=="Model",select=c(name,Source,ProbF))
  da3$method<-"Separate ANOVA"
  da3$Source <- gsub("Model", "week14", da3$Source)
  names(da3)[2]<-"Effect"
  da4<- subset(dt4,Source=="Model",select=c(name,Source,ProbF))
  da4$method<-"Separate ANOVA"
  da4$Source <- gsub("Model", "week21", da4$Source)
  names(da4)[2]<-"Effect"
  da5<- subset(dt5,Source=="Model",select=c(name,Source,ProbF))
  da5$method<-"Separate ANOVA"
  da5$Source <- gsub("Model", "week28", da5$Source)
  names(da5)[2]<-"Effect"
  main<-rbind(dcshs,dcshm,dcsm,dcss1)
  main$ProbF<-as.character(main$ProbF)
  sanova<-rbind(da1,da2,da3,da4,da5)
  data<-rbind(main,sanova)
  data$ProbF <- gsub("<", "0", data$ProbF)
  data$ProbF <- as.numeric(data$ProbF)
  datant<-subset(data,Effect !="Time")
  datant$Effect1<-as.factor(datant$Effect)
  datant$Effect1 <- factor(datant$Effect1, levels=c("Trt","Trt*Time","week1","week7","week14","week21","week28"))
  datant$method1 <- factor(datant$method, levels=c("Heterogeneous_CS","Homogenous_CS","Separate ANOVA"))
  return (datant)
}
r<-c(1,3,6,9)
n<-c(3,6,12)
for (i in r) {
  for (j in n)  {
    dcsh=read.csv(paste0("result_nullcsh_csh_r",i,"n",j,"_main.csv"),header=T)
    dcshh=read.csv(paste0("result_nullcsh_csh_r",i,"n",j,"_slice.csv"),header=T)
    dcs=read.csv(paste0("result_nullcsh_cs_r",i,"n",j,"_main.csv"),header=T)
    dcss=read.csv(paste0("result_nullcsh_cs_r",i,"n",j,"_slice.csv"),header=T)

dt1=read.csv(paste0("result_nullcsh_csh_r",i,"n",j,"_Seq ANOVA for time 1.csv"),header=T)

dt2=read.csv(paste0("result_nullcsh_csh_r",i,"n",j,"_Seq ANOVA for time 2.csv"),header=T)

dt3=read.csv(paste0("result_nullcsh_csh_r",i,"n",j,"_Seq ANOVA for time 3.csv"),header=T)

dt4=read.csv(paste0("result_nullcsh_csh_r",i,"n",j,"_Seq ANOVA for time 4.csv"),header=T)

dt5=read.csv(paste0("result_nullcsh_csh_r",i,"n",j,"_Seq ANOVA for time 5.csv"),header=T)
    
da<-est(dcsh,dcshh,dcs,dcss,dt1,dt2,dt3,dt4,dt5)
    head(da)
p<-ggplot(da, aes(x=ProbF))+
   geom_histogram(aes(y=0.05*..density..),binwidth=   
   0.05,color="blue", fill="light blue") +
      facet_grid(method1 ~ Effect1)
p + xlab("P value") + 
      ylab("Proportion") +
      ggsave(paste0("csh_null_r",i,"n", j, ".tiff"),
             units="in", width=10, height=5, dpi=600, compression = 'lzw')
     }
}



