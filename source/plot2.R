library(dplyr)
# delete all the variables except NEI or SCC
rm(list = ls(pattern="[^NEI|SCC]"))

# only load NEI and SCC when it is not in the environment
if(! all( c("NEI","SCC") %in% ls() )  )
    source("./source/load.R")

Baltimore = NEI %>%
    filter(fips== '24510' ) %>%
    mutate(year = factor(year))%>%
    group_by(year) %>%
    summarise(total.emssions = sum(Emissions))

total.emissions = Baltimore$total.emssions
names(total.emissions) = Baltimore$year

png("./figure/plot2.png")
barplot(total.emissions,
        main = "Total Emissions of Baltimore",
        ylab = "PM2.5 (tons)")
dev.off()