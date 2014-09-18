# Across the United States, how have emissions from coal combustion-related
# sources changed from 1999-2008?

# Import and merge data
nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")
df <- merge(nei, scc)

# Prepare data for plotting
coal <- df[(grepl("Combustion", df$SCC.Level.One))
           & (grepl("Coal", df$SCC.Level.Four)), ]
coal.by.year <- tapply(coal$Emissions, coal$year, sum)

# Make plot 4: coal emissions by year
png("plot4.png", type = "cairo", width = 800, height = 800, bg = "transparent")
plot(names(coal.by.year), coal.by.year, type = "l", xaxt = "n",
     main = expression("PM"[2.5] ~ "coal combustion related emissions - USA"),
     xlab = "Year", ylab = "Emissions")
axis(side = 1, at = c(names(coal.by.year)))
dev.off()