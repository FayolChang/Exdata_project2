library(dplyr)
library(ggplot2)


rm(list = ls(pattern="[^NEI|SCC]"))

# only load NEI and SCC when it is not in the environment
if(! all( c("NEI","SCC") %in% ls() )  )
    source("./source/load.R")

# Here Assuming emissions from motor vehicle sources are
# the type == "ON-ROAD"

motor_Bal_LA = NEI %>% 
    filter(fips == "24510" | fips == "06037" & type=="ON-ROAD") %>%
    mutate(year = factor(year),
           fips = factor(fips,levels = c("06037","24510"),labels = c("Los Angeles","Baltimore")) )%>%
    group_by(year,fips) %>%
    summarise(total.emissions = sum(Emissions))



#calculate emissions growth based on 1999
emissions1999 = with(motor_Bal_LA,
                     motor_Bal_LA[year=='1999' , "total.emissions"])

motor_Bal_LA = motor_Bal_LA %>%
                mutate(growth = (total.emissions - emissions1999)/emissions1999  )



png("./figure/plot6.png")

p = ggplot(motor_Bal_LA,aes(year,total.emissions,fill=fips))

p + geom_bar(stat='identity',position="dodge") + 
    ggtitle("emissions and its growth(based on 1999)--BAL vs LA,motor vehicles ") +
    ylab("PM2.5 Total Emissions (tons)")+
    geom_text(aes(label = paste(sprintf("%.1f", growth*100), "%", sep=""),
                  y     = total.emissions+100,
                  ymax  = total.emissions+200),
              position = position_dodge(width=0.9))

dev.off()
