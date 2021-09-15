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

#Question #6: 
#Compare emissions from motor vehicle sources in Baltimore City with emissions 
#from motor vehicle sources in Los Angeles County, California 
#(fips == "06037"). Which city has seen 
#greater changes over time in motor vehicle emissions?

vehicles <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vehiclesSCC <- SCC[vehicles,]$SCC
vehiclesNEI <- NEI[NEI$SCC %in% vehiclesSCC,]

Baltimore_City <- filter(vehiclesNEI, fips == "24510")
BCM_by_year <- group_by(Baltimore_City, year)
BCM_Emission_by_year <- summarize(BCM_by_year, Emissions = sum(Emissions))

LA_California <- filter(vehiclesNEI, fips == "06037")
LAC_by_year <- group_by(LA_California, year)
LAC_Emission_by_year <- summarize(LAC_by_year, Emissions = sum(Emissions))


#creating plot6
png("plot6.png", height = 480, width = 480)

par(mfrow=c(1,2), oma = c(0,0,1,0))
barplot(
        BCM_Emission_by_year$Emissions,
        names.arg=BCM_Emission_by_year$year,
        xlab="Year",
        ylab="PM2.5 Emissions (Tons)",
        main="Baltimore City",
        ylim= c(0,7500)
)

barplot(
        LAC_Emission_by_year$Emissions,
        names.arg=LAC_Emission_by_year$year,
        xlab="Year",
        ylab="PM2.5 Emissions (Tons)",
        main="Los Angeles",
        ylim= c(0,7500)
)

mtext("Motor Vehicle Emissions from LA & Baltimore City on 1999 and 2008", cex = 1, side = 3, outer = TRUE)
dev.off()
