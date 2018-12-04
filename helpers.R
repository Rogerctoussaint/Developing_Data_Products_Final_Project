## Helper functions for the Presidential elections app

load_states <- function(years) {
    suppressPackageStartupMessages(library(shiny))
    suppressPackageStartupMessages(library(lubridate))
    suppressPackageStartupMessages(library(tidyverse))
    suppressPackageStartupMessages(library(htmltab))
    suppressPackageStartupMessages(library(tidyverse))
    suppressPackageStartupMessages(library(data.table))
    suppressPackageStartupMessages(library(tigris))
    suppressPackageStartupMessages(library(sf))
    suppressPackageStartupMessages(library(elections))
  
    ## Scrape the election data from wikipedia by state
    url <- 'https://en.wikipedia.org/wiki/List_of_United_States_presidential_election_results_by_state'
    states <- url %>%
        htmltab(1, rm_nodata_cols = FALSE)
  
  
    ## Clean and tidy the scraped web data
    names(states) <- states[1,]
    states <- states[-1,]
    states <- states[ ,c('State', years)]
    states <- states %>%
        melt(
            id.vars = 'State',
            variable.name = 'Year',
            value.name = 'Voted'
        ) %>%
        mutate(
            Voted = ifelse(Voted == 'R', 'Republican', Voted),
            Voted = ifelse(Voted == 'D', 'Democrat', Voted),
            Voted = ifelse(Voted %in% c('AI','I'), 'Independent', Voted)
        ) %>%
        as.data.frame()
  
    ## State shapefiles
    options(tigris_class = 'sf')
    shapefiles <- states() %>% rename(State = 'NAME')
  
    ## Join shapefile onto the election results by state
    states <- states %>%
        left_join(shapefiles, by = 'State') %>%
        select(State, Year, Voted, geometry) %>%
        as.data.frame() %>%
        st_as_sf()
  
    states
}

load_winners <- function() {
    suppressPackageStartupMessages(library(shiny))
    suppressPackageStartupMessages(library(lubridate))
    suppressPackageStartupMessages(library(tidyverse))
    suppressPackageStartupMessages(library(htmltab))
    suppressPackageStartupMessages(library(tidyverse))
    suppressPackageStartupMessages(library(data.table))
    suppressPackageStartupMessages(library(tigris))
    suppressPackageStartupMessages(library(sf))
    suppressPackageStartupMessages(library(elections))
  
    ## Get election winners and losers
    data(eldat)
    eldat <- eldat %>%
        filter(electionyear >= 1964) %>%
        mutate(
            winnerparty = paste0('(', winnerparty, ')'),
            runnerupparty = paste0('(', runnerupparty, ')')
        ) %>%
        select(electionyear, winner, winnerparty, runnerup, runnerupparty) %>%
        as.data.frame()
  
    eldat
}