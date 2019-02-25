library(dplyr)
setwd("C:/Users/student/Documents/Rstudy/Rproejct/2019_02_02 [ bike ]")
pdf <- read.table("product_click.log")
names(pdf) <- c("logdate", "product")
pdf <- pdf %>% select(product) %>% 
  group_by(product) %>% summarise(clickcount = n()) %>% 
  arrange(desc(clickcount)) %>% head(1)
pdf <- as.data.frame(pdf)
pdf