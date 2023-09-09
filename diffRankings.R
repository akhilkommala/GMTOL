library(ggplot2)
library(dplyr)
ars=read.table("D:\\Chrome Downloads/V3-V4-p-Differential-Rankings.csv",sep=',',header=TRUE)
ars
OTUs <- ars %>%
  mutate(collected_value = ifelse(is.na(Species), Genus, Species))
OTUs=ars[,c('Class')]
pARS=ggplot(ars,aes(reorder(OTUs, Value),Value,fill=Value < 0))+
  geom_bar(stat="identity")+
  theme_classic()+
  ylab("Value")+
  labs(title = "Differentials by Climate Variable",fill="") +
  facet_wrap(~Variable) +
  scale_fill_manual(labels = c("Positive", "Negative"), values = c("#FF6E54","#444E86" ))+
  theme(axis.text.x = element_text(angle = 0,hjust=0.95,vjust=0.2,size=12),
        axis.text.y = element_text(size=12),
        axis.title.y = element_blank(),
        axis.title.x=element_text(size=12),
        title=element_text(size=12))+
  theme(plot.title = element_text(hjust = 0.65,vjust=1))+
  coord_flip()+
  theme(legend.text=element_text(size=12))
pARS
