## Script Name: plot4.R

## Libraries needed:
library(plyr)
library(ggplot2)

setwd("./project2")

## Step 1: read in the data
NEI <- readRDS("expdata_prj2/summarySCC_PM25.rds")
SCC <- readRDS("expdata_prj2/Source_Classification_Code.rds")

## Step 2: subset our data for only coal-combustion
coalcomb.scc <- subset(SCC, EI.Sector %in% c("Fuel Comb - Comm/Instutional - Coal", 
                                             "Fuel Comb - Electric Generation - Coal", "Fuel Comb - Industrial Boilers, ICEs - 
                                             Coal"))

## Step 3: comparisons so that we didn't omit anything weird
coalcomb.scc1 <- subset(SCC, grepl("Comb", Short.Name) & grepl("Coal", Short.Name))

nrow(coalcomb.scc) 

nrow(coalcomb.scc1) 

## Step 4: set the differences 
dif1 <- setdiff(coalcomb.scc$SCC, coalcomb.scc1$SCC)
dif2 <- setdiff(coalcomb.scc1$SCC, coalcomb.scc$SCC)

length(dif1)

length(dif2)

coalcomb.codes <- union(coalcomb.scc$SCC, coalcomb.scc1$SCC)
length(coalcomb.codes) 

## Step 5: subset again for what we want
coal.comb <- subset(NEI, SCC %in% coalcomb.codes)

##Step 6: get the PM25 values as well
coalcomb.pm25year <- ddply(coal.comb, .(year, type), function(x) sum(x$Emissions))

#rename the col
colnames(coalcomb.pm25year)[3] <- "Emissions"

##Step 7: finally plot4.png prepare to plot to png
png("plot4.png")
qplot(year, Emissions, data=coalcomb.pm25year, color=type, geom="line") + stat_summary(fun.y = "sum", fun.ymin = "sum", fun.ymax = "sum", color = "purple", aes(shape="total"), geom="line") + geom_line(aes(size="total", shape = NA)) + ggtitle(expression("Coal Combustion" ~ PM[2.5] ~ "Emissions by Source Type and Year")) + xlab("Year") + ylab(expression("Total" ~ PM[2.5] ~ "Emissions (tons)"))
dev.off()

## Step 8: prepare to plot to markdown
qplot(year, Emissions, data=coalcomb.pm25year, color=type, geom="line") + stat_summary(fun.y = "sum", fun.ymin = "sum", fun.ymax = "sum", color = "purple", aes(shape="total"), geom="line") + geom_line(aes(size="total", shape = NA)) + ggtitle(expression("Coal Combustion" ~ PM[2.5] ~ "Emissions by Source Type and Year")) + xlab("Year") + ylab(expression("Total" ~ PM[2.5] ~ "Emissions (tons)"))