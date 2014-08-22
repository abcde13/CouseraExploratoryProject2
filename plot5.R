#########################################
# Coursera Exploratory Data Analysis    #
# Course Project 2                      #
# August 22th 2014                      #
#########################################

# Question
# How have emissions from motor vehicle sources changed from 1999–2008 
# in Baltimore City?


# Necessary Lines to read files
setwd("~/Documents/Dev/R/CourseraExploratory/CourseProject2/")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Load libraries to handle data
library(tidyr)
library(dplyr)
library(ggplot2)

# Plan of attack: This will follow the same protocol as plot4.R. However, I will
# first filter to get the results for Baltimore City so the merge is faster.

mobile <- filter(NEI,fips=="24510") %>%
    merge(SCC,by="SCC") %>%
    filter(EI.Sector %in% levels(EI.Sector)[44:52]) %>%
    select(Emissions,year) %>%
    group_by(year) %>%
    summarize(emissions = sum(Emissions))
mobile <- as.data.frame(mobile)

g <- ggplot(mobile)
g <- g + geom_line(aes(year,emissions),size=1)
g <- g + geom_point(aes(year,emissions),size=3)
g <- g + scale_x_continuous(breaks = as.numeric(levels(factor(emission_sums$year))))
g <- g + ggtitle("PM 2.5 Emissions in the Baltimore City, Maryland from Mobile Sources") +
    xlab("Year") + ylab("PM 2.5 Emissions in tons")
g <- g + theme_bw()
print(g)
dev.copy(png, file="plot5.png",width=600)
dev.off()