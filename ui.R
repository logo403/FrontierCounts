#Libraries
library(shiny)
library(dygraphs)
library(leaflet)

# Define UI
shinyUI(fluidPage(
        tags$h2("Number of visitors entering Canada"),
        p(tags$div("Interactive vizualisation tool to analyse and forecast
                  tourism demand in Canada. This tool allows users to customize time series,
                   locate and access touristical information and to see raw
                   data.",tags$br(), tags$h6("Note on the Time Series: you can add
                        range selector to the bottom of the graph that provides
                        a straightforward interface for panning and zooming."))),
        hr(),
# Application title
#titlePanel("Number of visitors entering Canada"),
   sidebarLayout(
       sidebarPanel(
                    radioButtons("Province", "Select a Canadian location:",
                     c("Canada" = "Canada",
                       "Newfoundland and Labrador" = "Newfoundland and Labrador",
                       "Prince Edward Island" = "Prince Edward Island",
                       "Nova Scotia" = "Nova Scotia",
                       "New Brunswick" = "New Brunswick",
                       "Quebec" = "Quebec",
                       "Ontario" = "Ontario",
                       "Manitoba" = "Manitoba",
                       "Saskatchewan" = "Saskatchewan",
                       "Alberta" = "Alberta",
                       "British Columbia" = "British Columbia",
                       "Yukon" = "Yukon")),
           sliderInput("months", label = "Number of months to forecast:",
                          value = 25, min = 6, max = 48, step = 1),
           sliderInput("interval", label = "Forecast confidence interval (%):", min = 80,
                       max = 99, value = 95),hr(),
           p(tags$div(tags$em(tags$h6("Note: Forecasting involves making projections about future
                      performance on the basis of historical data. This tool
                      uses the Holt-Winters exponential smoothing to forecast
                      monthly entry to Canada."))))
       ),

    mainPanel(
        tabsetPanel(type = "tabs",
                    tabPanel("Time Series", dygraphOutput("dygraph")),
                    tabPanel("Map", leafletOutput("mymap")),
                    tabPanel("Table", tableOutput("table"))),
        p(tags$h6(tags$div(tags$strong("Source: "), "Statistics Canada.",
                           tags$em(
                                   tags$a(href="http://www5.statcan.gc.ca/cansim/a26?lang=eng&retrLang=eng&id=4270001",
                                          "Table 427-0001"), " - Number of international travellers
                                   entering or returning to Canada, by type of transport,
                                   monthly (persons), "), "CANSIM.",tags$br())))
    )
)))



