## Script Name: 1_download_data.R

setwd("./project2")

## Step 1: read in the data
NEI <- readRDS("expdata_prj2/summarySCC_PM25.rds")
SCC <- readRDS("expdata_prj2/Source_Classification_Code.rds")

tot.PM25yr <- tapply(NEI$Emissions, NEI$year, sum)

###Step 2: prepare to plot to png
png("plot1.png")
plot(names(tot.PM25yr), tot.PM25yr, type="l", xlab = "Year", ylab = expression
     ("Total" ~ PM[2.5] ~"Emissions (tons)"), main = expression("Total US" ~ 
                                                                  PM[2.5] ~ "Emissions by Year"), col="Purple")
dev.off()

###Step 3: prepare to plot to the markdown file
plot(names(tot.PM25yr), tot.PM25yr, type="l", xlab = "Year", ylab = expression ("Total" ~ PM[2.5] ~"Emissions (tons)"), main = expression("Total US" ~ PM[2.5] ~ "Emissions by Year"), col="Purple")