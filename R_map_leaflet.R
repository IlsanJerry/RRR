
rm(list=ls())

install.packages("ggmap")
library(ggmap)
lon <- 127.0147559
lat <- 37.5431424
cen <- c(lon,lat)
mk <- data.frame(lon=lon, lat=lat)
register_google(key="AIzaSyD-nx_y7aBlJgfgVZRaIwMbnShQJsxpryY")
map <- get_googlemap(center=cen, key="AIzaSyD-nx_y7aBlJgfgVZRaIwMbnShQJsxpryY", source="google", maptype="roadmap",zoom=12, marker=mk)
ggmap(map)
map <- get_googlemap(center=cen, key="AIzaSyD-nx_y7aBlJgfgVZRaIwMbnShQJsxpryY", source="google", maptype="satellite",zoom=14, marker=mk)
ggmap(map)
map <- get_googlemap(center=cen, key="AIzaSyD-nx_y7aBlJgfgVZRaIwMbnShQJsxpryY", source="google", maptype="terrain",zoom=8, marker=mk)
ggmap(map)
mk <- geocode("seoul", source = "google")#dsk")
print(mk)
cen <- c(mk$lon, mk$lat)
map <- get_googlemap(center=cen, key="AIzaSyD-nx_y7aBlJgfgVZRaIwMbnShQJsxpryY", source="google", maptype="roadmap",zoom=12, marker=mk)
ggmap(map)
mk <- geocode(enc2utf8("�λ�"), source = "google")#source = "dsk")
cen <- c(mk$lon, mk$lat)
map <- get_googlemap(center=cen, key="AIzaSyD-nx_y7aBlJgfgVZRaIwMbnShQJsxpryY", source="google", maptype="roadmap",zoom=12, marker=mk)
ggmap(map)

mk <- geocode(enc2utf8("����Ư���� ������ ���ﵿ ������� 212"), source = "google")
cen <- c(mk$lon, mk$lat)
map <- get_googlemap(center=cen, key="AIzaSyD-nx_y7aBlJgfgVZRaIwMbnShQJsxpryY", source="google", maptype="roadmap",zoom=12, marker=mk)
ggmap(map)



##############################################################################
# ���� DB Ȱ�� 

install.packages("XML")
library(XML)
API_key  <- "%2BjzsSyNtwmcqxUsGnflvs3rW2oceFvhHR8AFkM3ao%2Fw50hwHXgGyPVutXw04uAXvrkoWgkoScvvhlH7jgD4%2FRQ%3D%3D"
bus_No <- "402"
url <- paste("http://ws.bus.go.kr/api/rest/busRouteInfo/getBusRouteList?ServiceKey=", API_key, "&strSrch=", bus_No, sep="")
doc <- xmlParse(url)
top <- xmlRoot(doc) ; top
df <- xmlToDataFrame(getNodeSet(doc, "//itemList")); df
busRouteId <- df$busRouteId
busRouteId
url <- paste("http://ws.bus.go.kr/api/rest/buspos/getBusPosByRtid?ServiceKey=", API_key, "&busRouteId=", busRouteId, sep="")
doc <- xmlParse(url)
top <- xmlRoot(doc); top
df <- xmlToDataFrame(getNodeSet(doc, "//itemList")); df
# ���� �ʿ� ���� ��ġ ���
df$gpsX <- as.numeric(as.character(df$gpsX))
df$gpsY <- as.numeric(as.character(df$gpsY))
gc <- data.frame(lon=df$gpsX, lat=df$gpsY);gc
cen <- c(mean(gc$lon), mean(gc$lat))
map <- get_googlemap(center=cen, key="AIzaSyD-nx_y7aBlJgfgVZRaIwMbnShQJsxpryY", source="google", maptype="roadmap",zoom=12, marker=gc)
ggmap(map)




##################################################################
library(leaflet)
library(dplyr)
bike_2018 = read.csv("C:/Users/ChanWoo/Desktop/������ �м�/2018 ���� ������/�뿩�� ��ġ ����/�뿩������.csv", stringsAsFactors = FALSE)

str(bike_2018)
head(bike_2018)
tail(bike_2018)
leaflet(bike_2018) %>% 
  setView(lng = seoul_lonlat[1], lat = seoul_lonlat[2], zoom = 11) %>% 
  addTiles() %>% 
  addCircles(lng = ~�浵, lat=~����,popup = ~�뿩�Ҹ�)

leaflet(bike_2018) %>% 
  setView(lng = seoul_lonlat[1], lat = seoul_lonlat[2], zoom = 11) %>% 
  addProviderTiles('Stamen.Toner') %>% 
  addCircles(lng = ~�浵, lat=~����)

leaflet(bike_2018) %>% 
  setView(lng = seoul_lonlat[1], lat = seoul_lonlat[2], zoom = 11) %>% 
  addProviderTiles('CartoDB.Positron') %>% 
  addCircles(lng = ~�浵, lat=~����)

leaflet(bike_2018) %>% 
  setView(lng = seoul_lonlat[1], lat = seoul_lonlat[2], zoom = 11) %>% 
  addProviderTiles('Stamen.Toner') %>% 
  addCircles(lng = ~�浵, lat=~����, popup = ~�뿩�Ҹ�)
)

leaflet() %>% addTiles() %>%
  addPopups(126.97797,  37.56654, content,
            options = popupOptions(closeButton = FALSE)
  )

