library(dplyr)
library(ggplot2)
# delete all the variables except NEI or SCC
rm(list = ls(pattern="[^NEI|SCC]"))

# only load NEI and SCC when it is not in the environment
if(! all( c("NEI","SCC") %in% ls() )  )
    source("./source/load.R")


# My understanding of coal combustion-related sources is 
# combustion in SCC$SCC.Level.One and 
# coal in newdata$SCC.Level.Three


#merge NEI and SCC
newdata = NEI %>%
    left_join(SCC) # %>%
#     filter( grepl("combustion",SCC$SCC.Level.One,   ignore.case=T) &
#             grepl("coal"      ,SCC$SCC.Level.Three, ignore.case=T) )

#select coal combustion-related sources
#and calcuate sum of Emissions grouped by year
coal_combustion = newdata %>%
    filter( grepl("combustion",newdata$SCC.Level.One,   ignore.case=T) &
            grepl("coal"      ,newdata$SCC.Level.Three, ignore.case=T) ) %>%
    mutate(year = factor(year)) %>%
    select(year,Emissions) %>%
    group_by(year) %>%
    summarise(total.emissions = sum(Emissions))


png(filename="./figure/plot4.png")
p = ggplot(coal_combustion,aes(year,total.emissions/10^6))
p + geom_bar(stat='identity') +
    ggtitle( "Coal Combustion related emissions (PM2.5)" ) + 
    ylab("Total Emissions (X10^6 tons)")
dev.off()




