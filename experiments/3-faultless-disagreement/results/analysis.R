library(ggplot2)
library(reshape2)
library(lme4)

setwd("~/git/tagalog_adjectives/experiments/3-faultless-disagreement/Submiterator-master/")

source("../results/helpers.r")

df = read.csv("round1/faultless-disagreement.csv")

num_round_dirs = 1
df = do.call(rbind, lapply(1:num_round_dirs, function(i) {
  return (read.csv(paste(
    'round', i, '/faultless-disagreement.csv', sep=''),stringsAsFactors=FALSE) %>% 
      mutate(workerid = (workerid + (i-1)*9)))}))

d = subset(df, select=c("workerid","firstutterance","noun","nounclass","slide_number", "predicate",  "class","response","language","born","age","assess","agemove","live","dialects","education","gender"))

t = d[d$language=="Tagalog"|d$language=="tagalog"|d$language=="Bisaya"|d$language=="filipino"|d$language=="Filipino"|d$language=="bisaya"|d$language=="TAGALOG"|d$language=="FILIPINO"|d$language=="Kapampagan"|d$language=="Wikang Pilipino"|d$language=="Cebuano"|d$language=="Tagalog ",]


t$age = as.numeric(as.character(t$age))
mean(t[!is.na(t$age),]$age)

summary(t)

aggregate(response~class,data=t,mean)

t$class <- factor(t$class,levels=c("quality","size","age","texture","color","shape","material"))

table(t$class,t$nounclass)

## class plot
d_s = bootsSummary(data=t, measurevar="response", groupvars=c("class"))
# save data for aggregate plot
#write.csv(d_s,"~/Documents/git/cocolab/adjective_ordering/presentations/DGfS/plots/faultless.csv")

class_plot <- ggplot(d_s, aes(x=reorder(class,-response,mean),y=response)) +
  geom_bar(stat="identity",fill="lightgray",color="black")+
  geom_errorbar(aes(ymin=bootsci_low, ymax=bootsci_high, x=reorder(class,-response,mean), width=0.1),position=position_dodge(width=0.9))+
  ylab("faultless\ndisagreement\n")+
  xlab("\nadjective class") +
  ylim(0,1) +
  theme_bw()
class_plot
#ggsave("../results/class_faultless.png",height=2,width=4.3)

agr_pred = aggregate(response~predicate*class,data=t,mean)

#write.csv(agr_pred,"../results/pred-subjectivity.csv")


