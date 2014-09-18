# Import and prepare data
nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")
df <- merge(nei, scc)

# Plot 1: emissions for each year
pm25.by.year <- tapply(nei$Emissions, nei$year, sum)
plot(names(pm25.by.year), pm25.by.year, type = "l", xaxt = "n",
     main = expression("PM"[2.5] ~ "emissions - USA"),
     xlab = "Year", ylab = "Emissions")
axis(side = 1, at = names(pm25.by.year))

# Plot 2: emissions in Baltimore for each year
baltimore <- subset(nei, fips == "24510")
pm25.baltimore.by.year <- tapply(baltimore$Emissions, baltimore$year, sum)
plot(names(pm25.baltimore.by.year), pm25.baltimore.by.year, type = "l",
     xaxt = "n", main = expression("PM"[2.5] ~ "emissions - Baltimore City"),
     xlab = "Year", ylab = "Emissions")
axis(side = 1, at = names(pm25.baltimore.by.year))

# Plot 3: emissions over sources in Baltimore for each year
library(plyr)
library(ggplot2)
baltimore <- subset(nei, fips == "24510")
pm25.baltimore.by.type.by.year <- ddply(baltimore, .(year, type), function(x)
  sum(x$Emissions))
colnames(pm25.baltimore.by.type.by.year) <- c("Year", "Type", "Emissions")
qplot(Year, Emissions, col = Type, data = pm25.baltimore.by.type.by.year,
      geom = "line",
      main = expression("PM"[2.5] ~ "emissions by type - Baltimore City"))

# Plot 4: coal emissions by year
coal <- df[(grepl("Combustion", df$SCC.Level.One))
           & (grepl("Coal", df$SCC.Level.Four)), ]
coal.by.year <- tapply(coal$Emissions, coal$year, sum)
plot(names(coal.by.year), coal.by.year, type = "l", xaxt = "n",
     main = "Coal combustion related emissions - USA",
     xlab = "Year", ylab = "Emissions")
axis(side = 1, at = c(names(coal.by.year)))

# Plot 5: vehicle emissions by year in Baltimore
baltimore <- subset(df, fips == "24510")
vehicle.baltimore <- baltimore[grepl("Vehicles", baltimore$SCC.Level.Two), ]
vehicle.baltimore.by.year <- tapply(vehicle.baltimore$Emissions,
                                    vehicle.baltimore$year, sum)
plot(names(vehicle.baltimore.by.year), vehicle.baltimore.by.year, type = "l",
     xaxt = "n", main = "Vehicle emissions - Baltimore City",
     xlab = "Year", ylab = "Emissions")
axis(side = 1, at = c(names(vehicle.baltimore.by.year)))

# Plot 6: vehicle emissions Baltimore vs Los Angeles
# BROKEN! FIX

library(plyr)
library(ggplot2)
baltimore.and.la <- df[(df$fips == "24510") | (df$fips == "06037"), ]
vehicle.baltimore.and.la.by.year <- ddply(baltimore.and.la,
                                          .(year, fips), function(x)
                                            sum(x$Emissions))
names(vehicle.baltimore.and.la.by.year) <- c("Year", "Area", "Emissions")
vehicle.baltimore.and.la.by.year <-
  ifelse(vehicle.baltimore.and.la.by.year
ggplot(data = vehicle.baltimore.and.la.by.year, aes(x = Year, y = Emissions,
                                                    color = Area)) +
  geom_line() + title("Vehicle emissions in Baltimore City and Los Angeles, CA")
