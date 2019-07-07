
##This is a Rscript to generate the plot png to answer the following question:-
#Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (\color{red}{\verb|fips == "06037"|}fips=="06037"). Which city has seen greater changes over time in motor vehicle emissions?


## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

head(NEI)
head(SCC)

#Merging NEI and SCC data to get details of the SCC realted information for every emission
pm25_nei_scc<-merge(NEI,SCC,by="SCC",all.x = TRUE)


#Filtering the pm25_nei_scc data for Motor related emission sources in Baltimore City
pm25_nei_scc<-pm25_nei_scc[grepl("mobile",tolower(pm25_nei_scc$EI.Sector)) & pm25_nei_scc$fips %in% c("24510","06037"),]
head(pm25_nei_scc)


#Aggregating the total emissions for each year
total_pm25_by_year_fips<-with(pm25_nei_scc,aggregate(Emissions ~ year+fips, FUN = sum))

#Labelling Fips to a factor variable
total_pm25_by_year_fips$fips<-ifelse(total_pm25_by_year_fips$fips=="24510","Baltimore City","Los Angeles")

#Generating a barplot of the Motor related total emissions in Baltimore city & Los Angeles over the years
library(ggplot2)
png(file="./plot6.png",width=480,height=480)
gplot_pm25 <- ggplot(data=total_pm25_by_year_fips,aes(x=as.factor(year),y=Emissions,fill=as.factor(year)))  +labs(x="Year",y="Emission in tons",title="Comparison of Motor related emissions over the years in Baltimore city & Los Angeles",fill="Year")+facet_wrap(fips~.,dir="v")
gplot_pm25 + geom_bar(stat="identity")
dev.off()

