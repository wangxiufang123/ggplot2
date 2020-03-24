library(tidyverse)
library(remotes)
require(chinamap)
library(maps)
library(sp)
library(mapproj)
require(nCov2019)
library(magick)
x=get_nCov2019()
plot(x)
cn = get_map_china()
plot(x, chinamap=cn)
plot(x, region='china', chinamap=cn)
plot(x, region='china', chinamap=cn,continuous_scale=FALSE,
     palette='Blues')
#previous data
y <- load_nCov2019()
plot(y, region='china',
     chinamap=cn, date='2020-02-01')
#dynamic figure
time <- c(paste0("2020-01-", 19:31), paste0("2020-02-0", 1:7))
img <- image_graph(600, 450, res = 96)
out <- lapply(time, function(date){
  p <- plot(y, region='china', chinamap=cn, date=date,
            label=FALSE, continuous_scale=FALSE)
  print(p)
})
dev.off()
animation <- image_animate(img, fps = 2)
image_write(animation, "ncov2019.gif")

#########################################


