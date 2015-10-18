
setwd("~/GitHub/ExData_Plotting2")

## Load data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# some data wrangling
library(dplyr)
NEI <- tbl_df(NEI)

# form plot data
plot_data <- NEI %>% group_by(year) %>% summarise(totalPM25 = sum(Emissions))

# render plot
png("plot1.png", height = 480, width = 480)
plot(plot_data, type = 'b', main = "Total PM2.5 emissions", ylab = "total PM2.5 emissions")
dev.off()
