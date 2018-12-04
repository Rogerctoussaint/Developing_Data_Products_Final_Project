suppressPackageStartupMessages(library(shiny))
suppressPackageStartupMessages(library(htmltab))
suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(data.table))
suppressPackageStartupMessages(library(tigris))
suppressPackageStartupMessages(library(sf))
suppressPackageStartupMessages(library(elections))

#' sever function for presidential election shiny app
#'
#' @param input the ui input
#' @param output the output to the ui function
#'
#' @return
#' @export
#'
#' @examples
shinyServer(function(input, output) {
    ## Function to get year from UI
    get_year <- reactive({
        input$year
    })
  
    ## Outputs a sentence describing the election results (who beat who)
    output$winner <- renderText({
        year <- get_year()
        
        data <- eldat %>%
          filter(electionyear == year) %>%
          as.data.frame()
        
        winner <- paste(data$winner, data$winnerparty, 'defeated', data$runnerup, data$runnerupparty)
        winner
    })
      
    # Creates a graph of the US and how each state voted excuding Hawaii and Alaska
    output$graph <- renderPlot({
        year <- get_year()
        
        colors <- c('red', 'blue', 'grey')
        names(colors) <- c('Republican','Democrat','Independent')
        
        states %>%
            filter(State != 'Alaska') %>%
            filter(State != 'Hawaii') %>%
            filter(Year == year) %>%
            ggplot(aes(fill = Voted)) + 
                geom_sf() + 
                scale_fill_manual(values = colors) +
                theme_minimal() + 
                theme(
                    axis.text.x = element_blank(),
                    axis.title.x = element_blank(),
                    axis.ticks.x = element_blank(),
                    axis.text.y = element_blank(),
                    axis.title.y = element_blank(),
                    axis.ticks.y = element_blank(),
                    legend.title = element_blank(),
                    panel.grid.major = element_blank(),
                    panel.grid.minor = element_blank(),
                    panel.background = element_blank(),
                    panel.border = element_blank()
                )
    })
})