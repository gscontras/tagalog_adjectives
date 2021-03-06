library(hydroGOF)
library(dplyr)
#library(tidyr)

#setwd("~/Documents/git/tagalog_adjectives/experiments/2-tagalog-preference/Submiterator-master")
setwd("~/git/tagalog_adjectives/experiments/2-tagalog-preference/Submiterator-master")

source("../results/helpers.r")

# Bootstrap 95% CI for R-Squared
library(boot)
# function to obtain R-Squared from the data 
rsq <- function(formula, data, indices) {
  d <- data[indices,] # allows boot to select sample 
  fit <- lm(formula, data=d)
  return(summary(fit)$r.square)
} 

num_round_dirs = 10
df = do.call(rbind, lapply(1:num_round_dirs, function(i) {
  return (read.csv(paste(
    'round', i, '/tagalog-preference.csv', sep=''),stringsAsFactors=FALSE) %>% 
      mutate(workerid = (workerid + (i-1)*9)))}))

d = subset(df, select=c("workerid","noun","nounclass","slide_number", "predicate1", "predicate2", "class1","class2","response","language","born","age","assess","agemove","live","dialects","education","gender"))

# re-factorize
d[] <- lapply( d, factor) 

unique(d$language)

t = d[d$language=="Tagalog"|d$language=="tagalog"|d$language=="Bisaya"|d$language=="filipino"|d$language=="Filipino"|d$language=="bisaya"|d$language=="TAGALOG"|d$language=="FILIPINO"|d$language=="Kapampagan"|d$language=="Wikang Pilipino",]

t$response = as.numeric(as.character(t$response))

t$age = as.numeric(as.character(t$age))

length(unique(t$workerid)) #24

summary(t)

#write.csv(t,"~/Documents/git/tagalog_adjectives/experiments/1-order-preference/results/order-preference-tagalog-only.csv")

#####
## duplicate observations by first predicate
#####

library(tidyr)

o <- t
o$rightpredicate1 = o$predicate2
o$rightpredicate2 = o$predicate1
o$rightresponse = 1-o$response
agr = o %>% 
        select(predicate1,rightpredicate1,response,rightresponse,workerid,noun,nounclass,class1,class2) %>%
        gather(predicateposition,predicate,predicate1:rightpredicate1,-workerid,-noun,-nounclass,-class1,-class2)
agr$correctresponse = agr$response
agr[agr$predicateposition == "rightpredicate1",]$correctresponse = agr[agr$predicateposition == "rightpredicate1",]$rightresponse
agr$correctclass = agr$class1
agr[agr$predicateposition == "rightpredicate1",]$correctclass = agr[agr$predicateposition == "rightpredicate1",]$class2
head(agr[agr$predicateposition == "rightpredicate1",])
agr$response = NULL
agr$rightresponse = NULL
agr$class1 = NULL
agr$class2 = NULL
nrow(agr) #XXX
#write.csv(agr,"~/git/tagalog_adjectives/experiments/2-tagalog-preference/results/naturalness-duplicated.csv")

adj_agr = aggregate(correctresponse~predicate*correctclass,FUN=mean,data=agr)
adj_agr

class_agr = aggregate(correctresponse~correctclass,FUN=mean,data=agr)

class_s = bootsSummary(data=agr, measurevar="correctresponse", groupvars=c("correctclass"))
#write.csv(class_s,"../results/tagalog_class_s.csv")

ggplot(data=class_s,aes(x=reorder(correctclass,-correctresponse,mean),y=correctresponse))+
  geom_bar(stat="identity",fill="lightgray",color="black")+
  geom_errorbar(aes(ymin=bootsci_low, ymax=bootsci_high, x=reorder(correctclass,-correctresponse,mean), width=0.1))+
  geom_hline(yintercept=0.5,linetype="dashed") + 
  xlab("\nadjective class")+
  ylab("preferred distance from noun\n")+
  ylim(0,1)+
  #labs("order\npreference")+
  theme_bw()#+
  #theme(axis.text.x=element_text(angle=90,vjust=0.35,hjust=1))
#ggsave("../results/class_distance.pdf",height=3)
#ggsave("../results/LSA_class_distance.png",height=2,width=4.3)
#ggsave("../results/tagalog-ordering.pdf",height=2.5,width=7)

#### comparison with faultless disgareement

f = read.csv("../../3-faultless-disagreement/results/pred-subjectivity.csv",header=T)

adj_agr$subjectivity = f$response[match(adj_agr$predicate,f$predicate)]

gof(adj_agr$correctresponse,adj_agr$subjectivity)
# r = 0.73, r2 = 0.54
results <- boot(data=adj_agr, statistic=rsq, R=10000, formula=correctresponse~subjectivity)
boot.ci(results, type="bca") 
# 95%   ( 0.2224,  0.7323 ) 

ggplot(adj_agr, aes(x=subjectivity,y=correctresponse)) +
  geom_point() +
  #geom_smooth()+
  stat_smooth(method="lm",color="black")+
  #geom_text(aes(label=predicate),size=2.5,vjust=1.5)+
  ylab("preferred distance from noun\n")+
  xlab("\nsubjectivity score")+
  ylim(0,1)+
  theme_bw()
#ggsave("../results/naturalness-subjectivity.pdf",height=3,width=4)
#ggsave("../results/LSA-naturalness-subjectivity.png",height=3,width=3.5)
#ggsave("../results/tagalog-scatter.pdf",height=2.75,width=3.15)

ggplot(adj_agr, aes(x=subjectivity,y=correctresponse)) +
  geom_point() +
  #geom_smooth()+
  stat_smooth(method="lm",color="black")+
  #geom_text(aes(label=predicate),size=2.5,vjust=1.5)+
  ylab("preferred\ndistance from noun\n")+
  # ylab("")+
  xlab("\nsubjectivity score")+
  ggtitle("Tagalog")+
  ylim(0.2,0.8)+
  # xlim(0.2,0.8)+
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))
#ggsave("../results/naturalness-subjectivity-tagalog.png",height=2,width=2.5)