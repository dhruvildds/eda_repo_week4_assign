
##This is a Rscript to generate the plot png to answer the following question:-
#Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (\color{red}{\verb|fips == "24510"|}fips=="24510") from 1999 to 2008? Use the base plotting system to make a plot answering this question.


## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

head(NEI)
head(SCC)


#Aggregating the total emissions for each year
total_pm25_by_year_fips<-with(NEI,aggregate(Emissions ~ year+fips, FUN = sum))

#Filtering the aggregated data for Baltimore city
total_pm25_by_year_fips<-total_pm25_by_year_fips[total_pm25_by_year_fips$fips=="24510",]
head(total_pm25_by_year_fips)

#Generating a barplot of the total emissions in Baltimore city over the years
png(file="./plot2.png",width=480,height=480)
with(total_pm25_by_year_fips,barplot(height=Emissions,names=year,main="Total PM2.5 emission in Baltimore City, Maryland over the years",xlab="Year",ylab="PM2.5 Emission in tons",col=year,ylim=c(0,max(total_pm25_by_year_fips$Emissions+500))))
legend("topright", 
       legend = unique(total_pm25_by_year_fips$year), 
       fill = unique(total_pm25_by_year_fips$year), ncol = 2,
       cex = 0.75)
dev.off()
