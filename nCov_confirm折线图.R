library(tidyverse)
library(remotes)
require(chinamap)
library(maps)
library(sp)
library(mapproj)
require(nCov2019)
library(magick)
###top 10 country confirm line###
real_data=get_nCov2019(lang = "en")
data1=real_data['global']
data2=data1[order(data1$confirm,decreasing = TRUE),] 
country_top=data2$name[1:10]
his_global=data['global']
his_top=filter(his_global,country%in%country_top)
gg_top_confirm=ggplot(his_top,aes(x=time,y=cum_confirm,group=country,color=country))+
  geom_line()+
  labs(title="Top 10 cum_comfirm")
gg_top_confirm;
gg_top_log_confirm=ggplot(his_top,aes(x=time,y=log(cum_confirm),group=country,color=country))+
  geom_line()+
  labs(title="Top 10 cum_comfirm")
gg_top_log_confirm;
####Top 10 country confirm_rate line###
his_top$confirm_rate=rep(0,dim(his_top)[1])
for (i in 2:dim(his_top)[1]){
  c=his_top$country[1:(i-1)]
  a=his_top$country[i]
  if (a %in% c){
    index=which(c==a)
    j=tail(index,1)
    his_top$confirm_rate[i]=(his_top$cum_confirm[i]-his_top$cum_confirm[j])/his_top$cum_confirm[j]
  }
  else{
    his_top$confirm_rate[i]=0 
  }
  
}
gg_top_con_rate=ggplot(his_top,aes(x=time,y=confirm_rate,group=country,color=country))+
  geom_line()+
  labs(title="Top 10 comfirm_rate")
gg_top_con_rate;
##########################
require(cowplot)
pp <- plot_grid(gg_top_confirm, gg_top_log_confirm, ncol=1, labels=c("A", "B"), 
                rel_widths=c(1, 1)) 
g <- plot_grid(gg_top_con_rate, pp, ncol=2, rel_heights=c(1, 1), labels=c("C", "")) 
ggsave(g, filename = "nCov_confirm.jpg", width=28, height=20)
