
setwd("~/GitHub/ExData_Plotting2")

## Load data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(ggplot2)

# some data wrangling
library(dplyr)
NEI <- tbl_df(NEI)

# form plot data
plot_data <- NEI %>% filter(fips == 24510) %>% group_by(year, type) %>% summarise(totalPM25 = sum(Emissions))

# render plot
png("plot3.png", height = 480, width = 480)
ggplot(plot_data, aes(year, totalPM25, group = type)) + geom_line(aes(colour = type)) +ggtitle("Total PM2.5 emissions for Baltimore City")
dev.off()
