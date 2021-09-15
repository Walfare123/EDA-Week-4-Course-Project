#dataset
dataFile <- "exdata_data_NEI_data.zip"

#file path
if (!file.exists(dataFile)) {
        download.file(dataUrl, dataFile, mode = "wb")
}

library(dplyr)
library(ggplo2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Question #2: 
#Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
#(fips == "24510") from 1999 to 2008? 
#Use the base plotting system to make a plot answering this question.

Baltimore_City <- filter(NEI, fips == "24510")
BCM_by_year <- group_by(Baltimore_City, year)
BCM_Emission_by_year <- summarize(BCM_by_year, Emissions = sum(Emissions))


#creating plot2
png("plot2.png", height = 480, width = 480)
barplot(
        (BCM_Emission_by_year$Emissions),
        names.arg=BCM_Emission_by_year$year,
        xlab="Year",
        ylab="PM2.5 Emissions (Tons)",
        main="Total PM2.5 Emissions From All Baltimore City,Maryland Sources"
)
dev.off()
