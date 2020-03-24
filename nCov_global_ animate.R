library(tidyverse)
library(remotes)
require(chinamap)
library(maps)
library(sp)
library(mapproj)
require(nCov2019)
library(magick)
###global confirm data animate###
data=load_nCov2019(lang = "en")
d <- c(paste0("2020-01-0", 1:9),paste0("2020-01-", 10:31),
       paste0("2020-02-0", 1:9),paste0("2020-02-", 10:29),
       paste0("2020-03-0", 1:9),paste0("2020-03-", 10:23))
img <- image_graph(600, 450, res = 96)
out <- lapply(d, function(date){
  p <- plot(data, date=date,
            label=FALSE, continuous_scale=FALSE)
  print(p)
})
dev.off()
animation <- image_animate(img, fps = 2)
image_write(animation, "ncov_global_animate.gif")

