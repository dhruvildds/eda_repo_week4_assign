
##This is a Rscript to generate the plot png to answer the following question:-
#How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?


## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

head(NEI)
head(SCC)


#Merging NEI and SCC data to get details of the SCC realted information for every emission
pm25_nei_scc<-merge(NEI,SCC,by="SCC",all.x = TRUE)


#Filtering the pm25_nei_scc data for Motor related emission sources in Baltimore City
pm25_nei_scc<-pm25_nei_scc[grepl("mobile",tolower(pm25_nei_scc$EI.Sector)) & pm25_nei_scc$fips=="24510",]
head(pm25_nei_scc)


#Aggregating the total emissions for each year
total_pm25_by_year<-with(pm25_nei_scc,aggregate(Emissions ~ year, FUN = sum))

#Generating a barplot of the Motor related total emissions in Baltimore city over the years
library(ggplot2)
png(file="./plot5.png",width=480,height=480)
gplot_pm25 <- ggplot(data=total_pm25_by_year,aes(x=as.factor(year),y=Emissions,fill=as.factor(year)))  +labs(x="Year",y="Emission in tons",title="Motor related emissions over the years in Baltimore city",fill="Year")
gplot_pm25 + geom_bar(stat="identity")
dev.off()

