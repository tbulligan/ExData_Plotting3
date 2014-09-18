# Have total emissions from PM2.5 decreased in the United States from 1999 to
# 2008? Using the base plotting system, make a plot showing the total PM2.5
# emission from all sources for each of the years 1999, 2002, 2005, and 2008.

# Import data
nei <- readRDS("summarySCC_PM25.rds")

# Prepare data for plotting
pm25.by.year <- tapply(nei$Emissions, nei$year, sum)

# Make plot 1: emissions for each year
png("plot1.png", type = "cairo", width = 800, height = 800, bg = "transparent")
plot(names(pm25.by.year), pm25.by.year, type = "l", xaxt = "n",
     main = expression("PM"[2.5] ~ "emissions - USA"),
     xlab = "Year", ylab = "Emissions")
axis(side = 1, at = names(pm25.by.year))
dev.off()