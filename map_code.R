##################################################################
library(leaflet)
library(dplyr)
bike_2018 = read.csv("C:/Users/ChanWoo/Desktop/따릉이 분석/2018 공공 자전거/대여소 위치 정보/대여소정보.csv", stringsAsFactors = FALSE)

str(bike_2018)
head(bike_2018)
tail(bike_2018)
leaflet(bike_2018) %>% 
  setView(lng = seoul_lonlat[1], lat = seoul_lonlat[2], zoom = 11) %>% 
  addTiles() %>% 
  addCircles(lng = ~경도, lat=~위도,popup = ~대여소명)

leaflet(bike_2018) %>% 
  setView(lng = seoul_lonlat[1], lat = seoul_lonlat[2], zoom = 11) %>% 
  addProviderTiles('Stamen.Toner') %>% 
  addCircles(lng = ~경도, lat=~위도)

leaflet(bike_2018) %>% 
  setView(lng = seoul_lonlat[1], lat = seoul_lonlat[2], zoom = 11) %>% 
  addProviderTiles('CartoDB.Positron') %>% 
  addCircles(lng = ~경도, lat=~위도)

leaflet(bike_2018) %>% 
  setView(lng = seoul_lonlat[1], lat = seoul_lonlat[2], zoom = 11) %>% 
  addProviderTiles('Stamen.Toner') %>% 
  addCircles(lng = ~경도, lat=~위도, popup = ~대여소명)

content <- paste(sep = "<br/>",
                 "<b><a href='https://www.seoul.go.kr/main/index.jsp'>서울시청</a></b>",
                 "아름다운 서울",
                 "박원순 시장님 화이팅"
)

leaflet() %>% addTiles() %>%
  addPopups(126.97797,  37.56654, content,
            options = popupOptions(closeButton = FALSE)
  )


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
mk <- geocode(enc2utf8("부산"), source = "google")#source = "dsk")
cen <- c(mk$lon, mk$lat)
map <- get_googlemap(center=cen, key="AIzaSyD-nx_y7aBlJgfgVZRaIwMbnShQJsxpryY", source="google", maptype="roadmap",zoom=12, marker=mk)
ggmap(map)

mk <- geocode(enc2utf8("서울특별시 강남구 역삼동 테헤란로 212"), source = "google")
cen <- c(mk$lon, mk$lat)
map <- get_googlemap(center=cen, key="AIzaSyD-nx_y7aBlJgfgVZRaIwMbnShQJsxpryY", source="google", maptype="roadmap",zoom=12, marker=mk)
ggmap(map)



##############################################################################
# 공공 DB 활용 

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
# 구글 맵에 버스 위치 출력
df$gpsX <- as.numeric(as.character(df$gpsX))
df$gpsY <- as.numeric(as.character(df$gpsY))
gc <- data.frame(lon=df$gpsX, lat=df$gpsY);gc
cen <- c(mean(gc$lon), mean(gc$lat))
map <- get_googlemap(center=cen, key="AIzaSyD-nx_y7aBlJgfgVZRaIwMbnShQJsxpryY", source="google", maptype="roadmap",zoom=12, marker=gc)
ggmap(map)



##MAP
########################################################################
library(ggmap)
library(dplyr)
df <- read.csv("C:/Users/student/Desktop/전국전기차충전소표준데이터.csv", stringsAsFactors=F)       
str(df) 
head(df)

df_add <- as.data.frame(bike_2018[,c("경도","위도")])
head(df_add)
names(df_add) <- c("lon", "lat")
head(df_add)


table(is.na(df_add$lat))
table(is.na(df_add$lon))
table(is.na(df_add))

map_korea <- get_map(location="southKorea", zoom=7, 
                     maptype="roadmap")       

ggmap(map_korea)
ggmap(map_korea)+geom_point(data=df_add, aes(x=lon, y=lat), alpha=0.5, size=2, color="red")


map_seoul <- get_map(location="seoul", zoom=11, maptype="roadmap")       
ggmap(map_seoul)+geom_point(data=df_add, aes(x=lon, y=lat), alpha=0.5, size=1, color="blue")



install.packages('leaflet')
library(leaflet)
library(dplyr)

seoul_lonlat = unlist(geocode('seoul', source='google'))
names(seoul_lonlat) <- NULL






############################################
leaflet() %>% setView(-118.456554, 34.09, 13) %>%
  addTiles() %>%
  addMarkers(
    lng = -118.456554, lat = 34.105,
    label = "Default Label",
    labelOptions = labelOptions(noHide = T)) %>%
  addMarkers(
    lng = -118.456554, lat = 34.095,
    label = "Label w/o surrounding box",
    labelOptions = labelOptions(noHide = T, textOnly = TRUE)) %>%
  addMarkers(
    lng = -118.456554, lat = 34.085,
    label = "label w/ textsize 15px",
    labelOptions = labelOptions(noHide = T, textsize = "15px")) %>%
  addMarkers(
    lng = -118.456554, lat = 34.075,
    label = "Label w/ custom CSS style",
    labelOptions = labelOptions(noHide = T, direction = "bottom",
                                style = list(
                                  "color" = "red",
                                  "font-family" = "serif",
                                  "font-style" = "italic",
                                  "box-shadow" = "3px 3px rgba(0,0,0,0.25)",
                                  "font-size" = "12px",
                                  "border-color" = "rgba(0,0,0,0.5)"
                                )))
#######################################################################################


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
