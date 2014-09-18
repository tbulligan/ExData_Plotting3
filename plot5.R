# How have emissions from motor vehicle sources changed from 1999-2008 in
# Baltimore City?

# Import and merge data
nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")
df <- merge(nei, scc)

# Prepare data for plotting
baltimore <- subset(df, fips == "24510")
vehicle.baltimore <- baltimore[grepl("Vehicles", baltimore$SCC.Level.Two), ]
vehicle.baltimore.by.year <- tapply(vehicle.baltimore$Emissions,
                                    vehicle.baltimore$year, sum)

# Make plot 5: vehicle emissions by year in Baltimore
png("plot5.png", type = "cairo", width = 800, height = 800, bg = "transparent")
plot(names(vehicle.baltimore.by.year), vehicle.baltimore.by.year, type = "l",
     xaxt = "n", xlab = "Year", ylab = "Emissions",
     main = expression("PM"[2.5] ~ "vehicle emissions - Baltimore City"))
axis(side = 1, at = c(names(vehicle.baltimore.by.year)))
dev.off()