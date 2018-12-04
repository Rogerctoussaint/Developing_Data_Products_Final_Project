#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
suppressPackageStartupMessages(library(shiny))
suppressPackageStartupMessages(library(lubridate))
suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(htmltab))
suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(data.table))
suppressPackageStartupMessages(library(tigris))
suppressPackageStartupMessages(library(sf))
suppressPackageStartupMessages(library(elections))

source('helpers.R')

## Load necessary data
years <- c('2016','2012','2008','2004','2000','1996','1992','1988',
           '1984','1980','1976','1972','1968','1964')
states <- load_states(years)
eldat <- load_winners()