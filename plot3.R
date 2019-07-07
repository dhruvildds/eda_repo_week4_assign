
##This is a Rscript to generate the plot png to answer the following question:-
#Of the four types of sources indicated by the \color{red}{\verb|type|}type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.


## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

head(NEI)
head(SCC)

#Aggregating the total emissions for each year
total_pm25_by_year_fips_type<-with(NEI,aggregate(Emissions ~ year++fips+type, FUN = sum))

#Filtering the NEI data for Baltimore city
total_pm25_by_year_fips_type<-total_pm25_by_year_fips_type[total_pm25_by_year_fips_type$fips=='24510',]
head(total_pm25_by_year_fips_type)


#Using ggplot generating a barplot of the total emissions in Baltimore city over the years by type
library(ggplot2)
png(file="./plot3.png",width=480,height=480)
gplot_pm25 <- ggplot(data=total_pm25_by_year_fips_type,aes(x=as.factor(year),y=Emissions,fill=type))  +labs(x="Year",y="Emission in tons",title="Emissions over the years by type in Baltimore, Maryland") +facet_wrap(type~.)
gplot_pm25 + geom_bar(stat="identity")
dev.off()




