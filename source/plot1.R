library(dplyr)

# delete all the variables except NEI or SCC
rm(list = ls(pattern="[^NEI|SCC]"))

# only load NEI and SCC when it is not in the environment
if(! all( c("NEI","SCC") %in% ls() )  )
    source("./source/load.R")

# calculate total emissions grouped by year.
newdata = NEI %>%
    mutate(year = factor(year)) %>%
    group_by(year) %>%
    summarise(total.emissions = sum(Emissions))

Total_Emissions = newdata$total.emissions
names(Total_Emissions) = newdata$year

png(filename="./figure/plot1.png")
barplot(Total_Emissions/10^6,
        main = "Total Emissions of US",
        ylab="PM2.5 ( X 10^6 tons)")
dev.off()
