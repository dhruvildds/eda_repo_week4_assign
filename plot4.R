
##This is a Rscript to generate the plot png to answer the following question:-
#Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?


## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

head(NEI)
head(SCC)


#Merging NEI and SCC data to get details of the SCC realted information for every emission
pm25_nei_scc<-merge(NEI,SCC,by="SCC",all.x = TRUE)


#Filtering the pm25_nei_scc data for coal related emission sources
pm25_nei_scc<-pm25_nei_scc[grepl("comb",tolower(pm25_nei_scc$EI.Sector)) & grepl("coal",tolower(pm25_nei_scc$EI.Sector)),]
head(pm25_nei_scc)


#Aggregating the total emissions for each year
total_pm25_by_year<-with(pm25_nei_scc,aggregate(Emissions ~ year, FUN = sum))

#Generating a barplot of the Coal related total emissions in United States over the years
library(ggplot2)
png(file="./plot4.png",width=480,height=480)
gplot_pm25 <- ggplot(data=total_pm25_by_year,aes(x=as.factor(year),y=Emissions,fill=as.factor(year)))  +labs(x="Year",y="Emission in tons",title="Coal realated Emissions over the years across United States",fill="Year")
gplot_pm25 + geom_bar(stat="identity")
dev.off()

