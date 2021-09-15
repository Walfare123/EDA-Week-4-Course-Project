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

#Question #3: 
#Of the four types of sources indicated by the type 
#(point, nonpoint, onroad, nonroad) variable, which of these four sources have 
#seen decreases in emissions from 1999-2008 for Baltimore City? Which have seen 
#increases in emissions from 1999-2008? Use the ggplot2 plotting system to make 
#a plot answer this question.

Baltimore_City <- filter(NEI, fips == "24510")
BCM_by_year_type <- group_by(Baltimore_City, year, type)
BCM_Emission_by_year_type <- summarize(BCM_by_year_type, Emissions = sum(Emissions))



#creating plot3
png("plot3.png", height = 480, width = 480)

ggplot(data = BCM_Emission_by_year_type, aes(factor(year), Emissions)) +
        geom_bar(stat = "identity") +
        facet_wrap(~type, nrow = 1) +
        ggtitle("Baltimore City, Maryland Emissions by Type from 1999 to 2008")

dev.off()
