library(dplyr)
library(ggplot2)


rm(list = ls(pattern="[^NEI|SCC]"))

# only load NEI and SCC when it is not in the environment
if(! all( c("NEI","SCC") %in% ls() )  )
    source("./source/load.R")


# Here Assuming emissions from motor vehicle sources are
# the type == "ON-ROAD"

motor_Baltimore = NEI %>% 
    filter(fips == "24510" & type=="ON-ROAD") %>%
    mutate(year = factor(year))%>%
    group_by(year) %>%
    summarise(total.emissions = sum(Emissions))

png(filename="./figure/plot5.png")
p = ggplot(motor_Baltimore,aes(year,total.emissions))
p + geom_bar(stat='identity') + 
    ggtitle("PM2.5 emissions of motor vehicle sources from Baltimore") + 
    ylab("Total Emissions (tons)")
dev.off()

