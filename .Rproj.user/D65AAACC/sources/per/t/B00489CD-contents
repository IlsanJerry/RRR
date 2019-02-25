str(bike_2018)

##
install.packages("purrr")
library(purrr)
install.packages("dplyr")
library(dplyr)
install.packages("data.table")
library(data.table)

##
bike_2018_MAP <- bike_2018 %>% group_by(ADDR_GU) %>% summarise(n = n(), mean = round(mean(CRADLE_COUNT), 0))
bike_2018[,7]
aa<-select(bike_2018,LATITUDE,LONGITUDE)
bike_2018_MAP<-as.data.table(bike_2018_MAP)


bike_2018_MAP_purr <- bike_2018_MAP %>% 
  mutate(level = cut(mean,
                     c(0, 40, 50, 60, 70),
                     labels = c("~ 5",
                                "5 ~ 10",
                                "10 ~ 20",
                                "20 ~ 50")))
bike_2018_MAP_purr_split <- split(bike_2018_MAP_purr,
                                  bike_2018_MAP_purr$level)


#######################
install.packages("leaflet")
library(leaflet)

install.packages("maps")
library(maps)
test_map <- leaflet(width = "100%") %>% addTiles()

install.packages("reprex")
library(reprex)
########################

abc<-select(bike_2018,ADDR_GU,CRADLE_COUNT,CONTENT_NM,LATITUDE,LONGITUDE)

##error bbb...
test_map <- names(abc) %>%
  walk( function(df) {
    test_map <<- test_map %>%
      addMarkers(data = abc[[df]],
                 lng = ~LATITUDE, lat = ~LONGITUDE,
                 popup = ~as.character(ADDR_GU),
                 label = ~as.character(CRADLE_COUNT),
                 labelOptions = labelOptions(noHide = T,
                                             textsize = "15px",
                                             direction  =  'auto'),
                 group  =  df,
                 clusterOptions  = markerClusterOptions(
                   removeOutsideVisibleBounds  =  F))
  })
