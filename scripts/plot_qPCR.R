args = commandArgs(trailingOnly=TRUE)
# test if there is at least one argument: if not, return an error
if (length(args)==0) {
  stop("At least one argument must be supplied (input file).n", call.=FALSE)
}

library("ggplot2")
library("gridExtra")
library("ggthemes")
library("ggsci")
t1<-read.csv(args[1],header=TRUE)
p<- ggplot(t1, aes(x=Sample, y=mean),xaxt="n") + 
  geom_bar(stat="identity", width = 0.6, aes(fill=factor(Group)),color="black",alpha=0.5, 
           position=position_dodge()) + 
  geom_errorbar(aes(ymin=mean-std, ymax=mean+std), width=.2,
                position=position_dodge(.9)) +
  theme_few()+
  theme(legend.position='none') +
  labs(y="Relative Expression")
#print(p)

if (args[4]==TRUE) {
  pp <- p+scale_fill_npg()
  ggsave(pp, filename = paste0("ggsci_",gsub("_R\\.csv","",args[1]),".pdf"), device = cairo_pdf, width = as.integer(args[2]), height = as.integer(args[3]), units = "in")
} else {
  ggsave(p, filename = paste0(gsub("_R\\.csv","",args[1]),".pdf"), device = cairo_pdf, width = as.integer(args[2]), height = as.integer(args[3]), units = "in")
}
