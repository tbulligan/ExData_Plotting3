# Compare emissions from motor vehicle sources in Baltimore City with emissions
# from motor vehicle sources in Los Angeles County, California (fips ==
# "06037"). Which city has seen greater changes over time in motor vehicle
# emissions?

# Load required libraries
library(plyr)
library(ggplot2)

# Import and merge data
nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")
df <- merge(nei, scc)

# Prepare data for plotting
baltimore.and.la <- df[(df$fips == "24510") | (df$fips == "06037"), ]
vehicle.baltimore.and.la <- subset(baltimore.and.la[grepl("Vehicles",
                                                          baltimore.and.la$SCC.Level.Two), ])
vehicle.b.la.year <- ddply(vehicle.baltimore.and.la, .(year, fips),
                               function(x) sum(x$Emissions))
names(vehicle.b.la.year) <- c("Year", "Area", "Emissions")
vehicle.b.la.year$Area <- with(vehicle.b.la.year, ifelse(Area == "24510", "Baltimore City",
                                                    "Los Angeles, CA"))

# Make plot 6: vehicle emissions Baltimore vs Los Angeles
png("plot6.png", type = "cairo", width = 800, height = 800, bg = "transparent")
qplot(data = vehicle.b.la.year, x = Year, y = log(Emissions), color = Area, geom = "line") +
  ggtitle(expression("PM"[2.5] ~ "vehicle emissions - Baltimore City and Los Angeles, CA"))
# + title("Vehicle emissions in Baltimore City and Los Angeles, CA")
dev.off()