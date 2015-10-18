
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

# motor vehicle sectors
veh_sectors <- c("Mobile - On-Road Gasoline Light Duty Vehicles", "Mobile - On-Road Gasoline Heavy Duty Vehicles", "Mobile - On-Road Diesel Light Duty Vehicles", "Mobile - On-Road Diesel Heavy Duty Vehicles")

# form plot data
plot_data <- NEI %>% left_join(SCC, by = "SCC") %>% filter(fips %in% c("24510", "06037")) %>% filter(EI.Sector %in% veh_sectors) %>% group_by(year, fips) %>% summarise(totalPM25 = sum(Emissions))

# render plot
png("plot6.png", height = 480, width = 480)
ggplot(plot_data, aes(year, totalPM25, group = fips)) + geom_line(aes(colour = fips)) + ggtitle("Total PM2.5 emissions from Motor Vehicles in Baltimore City")
dev.off()
