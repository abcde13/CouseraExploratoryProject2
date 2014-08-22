#########################################
# Coursera Exploratory Data Analysis    #
# Course Project 2                      #
# August 22th 2014                      #
#########################################

# Question
# Across the United States, how have emissions from coal combustion-related 
# sources changed from 1999–2008?


# Necessary Lines to read files
setwd("~/Documents/Dev/R/CourseraExploratory/CourseProject2/")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Load libraries to handle data
library(tidyr)
library(dplyr)
library(ggplot2)

# Plan of attack: First, I have to get all the emissions that only involve 
# coal combustion related-sources. To do this, I will merge the SCC set with the
# NEI set by the "SCC" variable. Then, I will filter it looking for coal
# combustion sources. Finally, I'll use the summarize to sum up the emissons 
# by year

all_data <- merge(NEI,SCC,by="SCC")
coal <- filter(all_data,EI.Sector %in% levels(EI.Sector)[c(13,18,23)]) %>%
    select(Emissions,year) %>%
    group_by(year) %>%
    summarize(emissions = sum(Emissions))

g <- ggplot(coal)
g <- g + geom_line(aes(year,emissions),size=1)
g <- g + geom_point(aes(year,emissions),size=3)
g <- g + scale_x_continuous(breaks = as.numeric(levels(factor(emission_sums$year))))
g <- g + ggtitle("PM 2.5 Emissions in the United States from Coal Combustion Sources") +
    xlab("Year") + ylab("PM 2.5 Emissions in tons")
g <- g + theme_bw()
print(g)
dev.copy(png, file="plot4.png",width=600)
dev.off()
