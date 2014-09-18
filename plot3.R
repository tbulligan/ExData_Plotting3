# Of the four types of sources indicated by the type (point, nonpoint, onroad,
# nonroad) variable, which of these four sources have seen decreases in
# emissions from 1999-2008 for Baltimore City? Which have seen increases in
# emissions from 1999-2008? Use the ggplot2 plotting system to make a plot
# answer this question.

# Load required libraries
library(plyr)
library(ggplot2)

# Import data
nei <- readRDS("summarySCC_PM25.rds")

# Prepare data for plotting
baltimore <- subset(nei, fips == "24510")
pm25.baltimore.by.type.by.year <- ddply(baltimore, .(year, type), function(x)
  sum(x$Emissions))
colnames(pm25.baltimore.by.type.by.year) <- c("Year", "Type", "Emissions")

# Make plot 3: emissions over sources in Baltimore for each year
png("plot3.png", type = "cairo", width = 800, height = 800, bg = "transparent")
qplot(Year, Emissions, col = Type, data = pm25.baltimore.by.type.by.year,
      geom = "line",
      main = expression("PM"[2.5] ~ "emissions by type - Baltimore City"))
dev.off()