suppressPackageStartupMessages(library(shiny))
suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(htmltab))
suppressPackageStartupMessages(library(data.table))
suppressPackageStartupMessages(library(tigris))
suppressPackageStartupMessages(library(sf))
suppressPackageStartupMessages(library(elections))

ui <- fluidPage(
    titlePanel('Election Results Viewer'),
    sidebarLayout(
        sidebarPanel(
            h3('Presidential Election Years 1964-2016'),
            selectInput(
                inputId = 'year',
                label = 'Pick a Year:',
                choices = years
            )
        ),
        mainPanel(
            h1('Election Results'),
            h3(textOutput('winner')),
            plotOutput('graph')
        )
    )
)