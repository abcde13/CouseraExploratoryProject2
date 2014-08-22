#########################################
# Coursera Exploratory Data Analysis    #
# Course Project 2                      #
# August 22th 2014                      #
#########################################

# Question
# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (
# fips == "24510") from 1999 to 2008? Use the base plotting system to make a 
# plot answering this question.


# Necessary Lines to read files
setwd("~/Documents/Dev/R/CourseraExploratory/CourseProject2/")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Load libraries to handle data
library(tidyr)
library(dplyr)

# Plan of attack: This is similar to the first question. First, I'll filter
# the NEI data frame, looking for the specified fips. Then, Ill group by the 
# years, and summarize them.

emission_sums <- filter(NEI,fips=="24510") %>%
    select(Emissions,year) %>%
    group_by(year) %>%
    summarize(emissions = sum(Emissions))
emission_sums <- as.data.frame(emission_sums)

# Pretty simple. To plotting

plot(emission_sums$year,emission_sums$emissions/1000000,type='o',
     xaxt = 'n',pch=21,bg='grey',lwd=2,xlab="Year",ylab="PM 2.5 Emissions (in millions of tons)",
     main= 'PM 2.5 Emission Levels in Baltimore City, Maryland')
axis(1,at =emission_sums$year,labels=emission_sums$year)
dev.copy(png, file="plot2.png")
dev.off()
