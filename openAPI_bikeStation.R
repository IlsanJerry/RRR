###인코딩 문제때매 마크다운 배제함. 

##1. 서울 열린데이터 광장 openAPI갖고오기
# 대여소 위치 정보 

#http://요청주소/인증키/요청파일타입/OpenAPI호출서비스명/요청시작위치/요청종료위치/

#http://openapi.seoul.go.kr:8088/7a53766a64737570323951724c4878/xml/PublicBicycleRenTIdinfo/1/5/

rm(list = ls())
install.packages("XML")
library(XML)
#1~1460개  ,한번에 요청할 수 있는게 1000개여서 두번 끊어서 갖고와야함; 
url1<-"http://openapi.seoul.go.kr:8088/"
url2<-"/xml/"
url3<-"/1001/"  #여기 1001 ~ 1460하면됨 
url4<-"1460/"

KEY="7a53766a64737570323951724c4878"
SERVICE="PublicBicycleRenTIdinfo"

table <-data.frame()

requestUrl<-paste(url1,KEY,url2,SERVICE,url3,url4,sep = "")
doc <-xmlToDataFrame(requestUrl)

##데이터 전체 갯수 파악 = 1460개 
totaldatanumber = as.numeric(doc[1,1])
datanumber <- totaldatanumber

requestUrl<-paste(url1,KEY,url2,SERVICE,url3,url4,sep = "")
doc <-xmlToDataFrame(requestUrl)

#불필요한 부분 행,열 제거
table1<-doc[3:nrow(doc),4:ncol(doc)]

#table0,1합침 ,1460개, 변수8개 
station<-rbind(table0,table1)
str(station)

bike_2018 <- na.omit(station)
bike_2018$CRADLE_COUNT <- as.numeric(gsub(",", "",station$CRADLE_COUNT))


#hcboxplot
install.packages("highcharter")
library(highcharter)

#서울시 구별 - 거치대수 분포 
hcboxplot(x = bike_2018$CRADLE_COUNT , var = bike_2018$ADDR_GU,
          name = "Test", color = "#2980b9") 


#end