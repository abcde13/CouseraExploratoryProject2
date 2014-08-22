#########################################
# Coursera Exploratory Data Analysis    #
# Course Project 2                      #
# August 22th 2014                      #
#########################################

# Question
# Of the four types of sources indicated by the type (point, nonpoint, onroad,
# nonroad) variable, which of these four sources have seen decreases in 
# emissions from 1999–2008 for Baltimore City? Which have seen increases in 
# emissions from 1999–2008? Use the ggplot2 plotting system to make a plot 
# answer this question.


# Necessary Lines to read files
setwd("~/Documents/Dev/R/CourseraExploratory/CourseProject2/")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Load libraries to handle data
library(tidyr)
library(dplyr)
library(ggplot2)

# Plan of attack: So this going to require a two level grouping. One, by point.
# Two, by year. However, ddplyr makes that easy. We'll just use group_by to do
# the two level factoring, and then summarize for each of those levels.

emission_sums <- filter(NEI,fips=="24510") %>%
    select(Emissions,year,type) %>%
    group_by(year,type) %>%
    summarize(emissions = sum(Emissions))
emission_sums <- as.data.frame(emission_sums)
#emission_sums$year <- factor(emission_sums$year)

# Cool. With these data frames, let's plot them.
g <- ggplot(emission_sums)
g <- g + geom_line(data=emission_sums,aes(year,emissions,color=type),size=1)
g <- g + geom_point(data=emission_sums,aes(year,emissions,color=type),size=3)
g <- g + scale_x_continuous(breaks = as.numeric(levels(factor(emission_sums$year))))
g <- g + ggtitle("PM 2.5 Emissions in Baltimore City, Maryland by Type") +
              xlab("Year") + ylab("PM 2.5 Emissions in tons")
g <- g + theme_bw(base_family = "Times")
print(g)
dev.copy(png, file="plot3.png")
dev.off()
