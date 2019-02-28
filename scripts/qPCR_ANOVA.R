args = commandArgs(trailingOnly=TRUE)
# test if there is at least one argument: if not, return an error
if (length(args)==0) {
  stop("At least one argument must be supplied (input file).n", call.=FALSE)
}

par(mar=c(5,10,4,1)+.1); #set margin for plot bottom,left top, right
library(multcomp)
strains<-read.csv(args[1],header=TRUE)
strains$Sample = relevel(strains$Sample,args[2])
test<-summary(glht(aov(X2log ~ Sample, data=strains), linfct=mcp(Sample="Dunnett")))
test
pdf(paste0(gsub("ANOVA\\.csv","T-test",args[1]),".pdf"),width=8, height=6,useDingbats=FALSE)
plot(glht(aov(X2log ~ Sample, data=strains), linfct=mcp(Sample="Dunnett")))
dev.off()
## Significance Test
a = TukeyHSD( aov(X2log ~ Sample, data=strains) )$Sample
b=as.data.frame(a)
names(b)[names(b) == 'p adj'] <- 'padj'
c=b[which(b$padj<0.05), ]
c$sig[c$padj <= 0.05 ] <- "*"
c$sig[c$padj <= 0.01 ] <- "**"
c$sig[c$padj <= 0.001 ] <- "***"
print("The results of Significance Test")
c
print("Signif. codes:  <= 0.001 ‘***’ <= 0.01 ‘**’ <= 0.05 ‘*’ ")
