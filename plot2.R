# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland
# (fips == "24510") from 1999 to 2008? Use the base plotting system to make a
# plot answering this question.

# Import data
nei <- readRDS("summarySCC_PM25.rds")

# Prepare data for plotting
baltimore <- subset(nei, fips == "24510")
pm25.baltimore.by.year <- tapply(baltimore$Emissions, baltimore$year, sum)

# Make plot 2: emissions in Baltimore for each year
png("plot2.png", type = "cairo", width = 800, height = 800, bg = "transparent")
plot(names(pm25.baltimore.by.year), pm25.baltimore.by.year, type = "l",
     xaxt = "n", main = expression("PM"[2.5] ~ "emissions - Baltimore City"),
     xlab = "Year", ylab = "Emissions")
axis(side = 1, at = names(pm25.baltimore.by.year))
axis(side = 1, at = names(pm25.by.year))
dev.off()