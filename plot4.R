
setwd("~/GitHub/ExData_Plotting2")

## Load data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(ggplot2)

# some data wrangling
library(dplyr)
NEI <- tbl_df(NEI)
SCC <- tbl_df(SCC)

SCC_codes <- SCC[, "SCC"]
SCC_codes <- data.frame(lapply(SCC_codes, as.character), stringsAsFactors = FALSE)
SCC[, "SCC"] <- SCC_codes

# coal combustion sectors
coal_sectors <- c("Fuel Comb - Electric Generation - Coal","Fuel Comb - Industrial Boilers, ICEs - Coal","Fuel Comb - Comm/Institutional - Coal")

# form plot data
plot_data <- NEI %>% left_join(SCC, by = "SCC") %>% filter(EI.Sector %in% coal_sectors) %>% group_by(year) %>% summarise(totalPM25 = sum(Emissions))

# render plot
png("plot4.png", height = 480, width = 480)
ggplot(plot_data, aes(year, totalPM25)) + geom_line() + ggtitle("Total PM2.5 emissions for Coal Combustion sources in US")
dev.off()
