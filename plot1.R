#########################################
# Coursera Exploratory Data Analysis    #
# Course Project 2                      #
# August 22th 2014                      #
#########################################

# Question
# Have total emissions from PM2.5 decreased in the United States from 
# 1999 to 2008? Using the base plotting system, make a plot showing the total 
# PM2.5 emission from all sources for each of the years 
# 1999, 2002, 2005, and 2008.


# Necessary Lines to read files
setwd("~/Documents/Dev/R/CourseraExploratory/CourseProject2/")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Load libraries to handle data
library(tidyr)
library(dplyr)

# Plan of attack: First, I'll give the NEI$year factor levels so that
# I can make a data frame that is grouped by the year. Then, I should
# be able to summarize over the sum of emissions (all are of the same
# pollutant type) to get the emmissions for each year.

emission_sums <- group_by(just_emissions,year) %>%
    summarize(emissions = sum(Emissions))
emission_sums <- as.data.frame(emission_sums)

# Pretty simple. To plotting

plot(emission_sums$year,emission_sums$emissions/1000000,type='o',
     xaxt = 'n',pch=21,bg='grey',lwd=2,xlab="Year",ylab="Emissions (in millions)",
     main= 'Emission Levels in the United States')
axis(1,at =emission_sums$year,labels=emission_sums$year)
dev.copy(png, file="plot1.png")
dev.off()
