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

#Question #5: 
#How have emissions from motor vehicle sources changed from 1999-2008 in 
#Baltimore City?

vehicles <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vehiclesSCC <- SCC[vehicles,]$SCC
vehiclesNEI <- NEI[NEI$SCC %in% vehiclesSCC,]

Baltimore_City <- filter(vehiclesNEI, fips == "24510")
BCM_by_year <- group_by(Baltimore_City, year)
BCM_Emission_by_year <- summarize(BCM_by_year, Emissions = sum(Emissions))



#creating plot5
png("plot5.png", height = 480, width = 480)

barplot(
        BCM_Emission_by_year$Emissions,
        names.arg=BCM_Emission_by_year$year,
        xlab="Year",
        ylab="PM2.5 Emissions (Tons)",
        main="Emissions from Motor Vehicle Sources from 1999 to 2008 in Baltimore City"
)

dev.off()
