###���ڵ� �������� ��ũ�ٿ� ������. 

##1. ���� ���������� ���� openAPI��������
# �뿩�� ��ġ ���� 

#http://��û�ּ�/����Ű/��û����Ÿ��/OpenAPIȣ�⼭�񽺸�/��û������ġ/��û������ġ/

#http://openapi.seoul.go.kr:8088/7a53766a64737570323951724c4878/xml/PublicBicycleRenTIdinfo/1/5/

rm(list = ls())
install.packages("XML")
library(XML)
#1~1460��  ,�ѹ��� ��û�� �� �ִ°� 1000������ �ι� ��� �����;���; 
url1<-"http://openapi.seoul.go.kr:8088/"
url2<-"/xml/"
url3<-"/1001/"  #���� 1001 ~ 1460�ϸ�� 
url4<-"1460/"

KEY="7a53766a64737570323951724c4878"
SERVICE="PublicBicycleRenTIdinfo"

table <-data.frame()

requestUrl<-paste(url1,KEY,url2,SERVICE,url3,url4,sep = "")
doc <-xmlToDataFrame(requestUrl)

##������ ��ü ���� �ľ� = 1460�� 
totaldatanumber = as.numeric(doc[1,1])
datanumber <- totaldatanumber

requestUrl<-paste(url1,KEY,url2,SERVICE,url3,url4,sep = "")
doc <-xmlToDataFrame(requestUrl)

#���ʿ��� �κ� ��,�� ����
table1<-doc[3:nrow(doc),4:ncol(doc)]

#table0,1��ħ ,1460��, ����8�� 
station<-rbind(table0,table1)
str(station)

bike_2018 <- na.omit(station)
bike_2018$CRADLE_COUNT <- as.numeric(gsub(",", "",station$CRADLE_COUNT))


#hcboxplot
install.packages("highcharter")
library(highcharter)

#����� ���� - ��ġ��� ���� 
hcboxplot(x = bike_2018$CRADLE_COUNT , var = bike_2018$ADDR_GU,
          name = "Test", color = "#2980b9") 


#end