library(dplyr)
library(ggplot2)
# delete all the variables except NEI or SCC
rm(list = ls(pattern="[^NEI|SCC]"))

# only load NEI and SCC when it is not in the environment
if(! all( c("NEI","SCC") %in% ls() )  )
    source("./source/load.R")

#get data of Baltimore
#transform year and type to factors
#group data by year and type
#calculate total emissions by group
Baltimore = NEI %>%
    filter(fips== '24510' ) %>%
    mutate(year = factor(year),type = factor(type)) %>%
    group_by(year,type) %>%
    summarise(total.emissions = sum(Emissions))


png(filename="./figure/plot3.png")
p = ggplot(Baltimore,aes(year,total.emissions,group = type))
p + geom_line() + 
    facet_wrap(~type,scales = 'free') + 
    ggtitle("Four types of Pollutants of Baltimore (PM2.5)") + 
    xlab("") +
    ylab("total emissions (tons)")
dev.off()