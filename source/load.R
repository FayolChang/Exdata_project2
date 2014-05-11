
# make sure in the working directory, there is a directory named 'data', in which are  
# summarySCC_PM25.rds and Source_Classification_Code.rds
#  
setwd("./data")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
setwd("../")