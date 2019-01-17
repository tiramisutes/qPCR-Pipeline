arg <- commandArgs(T)
library("reshape2")
library("dplyr")
###################################################
############# 1. Read raw qPCR data ###############
###################################################
t1<-read.csv(arg[1],header=TRUE)
###################################################
############# 2. raw qPCR data long to wide #######
###################################################
t2<-filter(t1,Detector == arg[2])
write.csv(t2,paste0(gsub("\\.csv","",arg[1]),"_",arg[2],".csv"),row.names = FALSE)
###################################################
print("Now, run qPCR.py scripts")