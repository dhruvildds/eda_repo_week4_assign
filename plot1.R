
##This is a Rscript to generate the plot png to answer the following question:-
#Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008


## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

head(NEI)
head(SCC)


#Aggregating the total emissions for each year
total_pm25_by_year<-with(NEI,aggregate(Emissions ~ year, FUN = sum))
head(total_pm25_by_year)

#Generating a barplot of the total emissions over the years
png(file="./plot1.png",width=480,height=480)
with(total_pm25_by_year,barplot(height=Emissions,names=year,main="Total PM2.5 emission over the years",xlab="Year",ylab="PM2.5 Emission in tons",col=year))
legend("topright", 
       legend = unique(total_pm25_by_year$year), 
       fill = unique(total_pm25_by_year$year), ncol = 2,
       cex = 0.75)
dev.off()
