#dataset
dataFile <- "exdata_data_NEI_data.zip"

#file path
if (!file.exists(dataFile)) {
        download.file(dataUrl, dataFile, mode = "wb")
}

library(dplyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Question #1:
#Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
#Using the base plotting system, make a plot showing the total PM2.5 emission from 
#all sources for each of the years 1999, 2002, 2005, and 2008.

by_year <- group_by(NEI, year)
Emission_by_year <- summarize(by_year, Emissions = sum(Emissions))


#creating plot1
png("plot1.png", height = 480, width = 480)
barplot(
        (Emission_by_year$Emissions)/10^6,
        names.arg=Emission_by_year$year,
        xlab="Year",
        ylab="PM2.5 Emissions (10^6 Tons)",
        main="Total PM2.5 Emissions From All US Sources"
)
dev.off()
