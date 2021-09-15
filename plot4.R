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

#Question #4: 
#Across the United States, how have emissions from coal combustion-related 
#sources changed from 1999-2008?

combustionRelated <- grepl("comb", SCC$SCC.Level.One, ignore.case=TRUE)
coalRelated <- grepl("coal", SCC$SCC.Level.Four, ignore.case=TRUE) 
coalCombustion <- (combustionRelated & coalRelated)
combustionSCC <- SCC[coalCombustion,]$SCC
combustionNEI <- NEI[NEI$SCC %in% combustionSCC,]

combustionNEI_by_year <- group_by(combustionNEI, year)
combustionNEI_by_year <- summarise(combustionNEI_by_year, Emisssions = sum(Emissions))

#creating plot4
png("plot4.png", height = 480, width = 480)

barplot(
        (combustionNEI_by_year$Emisssions)/10^5,
        names.arg=combustionNEI_by_year$year,
        xlab="Year",
        ylab="PM2.5 Emissions (10^5 Tons)",
        main="Coal Combustion-Related Sources in US from 1999 to 2008"
)
dev.off()
