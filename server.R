# Libraries
library(shiny)
library(dygraphs)
library(leaflet)
library(lubridate)

#Data sets
fileName <- "cansim-4270001-eng-5355849443735675565.csv"
cname <-c("Month", unlist(read.table(fileName, sep = ",", nrows=1, skip = 3,
                                     colClasses = "character"), use.names = FALSE)[-1])
EntryData <- read.table(fileName, sep = ",", nrows=527, skip = 5,
                        col.names = cname)
Mapdat <- read.csv("map1.csv")

shinyServer(function(input, output,session) {
predicted <- reactive({
        Province <- input$Province
        Prov <- EntryData[,gsub(" ",".",Province)]
        tsData <- ts(Prov,start = c(1972,1),frequency = 12)
        hw <- HoltWinters(tsData)
        p <- predict(hw, n.ahead = input$months,
                     prediction.interval = TRUE,
                     level = as.numeric(input$interval)/100) + 180
        fit <- stl(ts(c(tsData,p[,1]),start = c(1972,1),
                      frequency = 12),s.window = 3)
        tsDatap <- fit$time.series[,2]

        cbind(tsDatap,tsData, p)
        })

        # Generate a plot of the data. Also uses the inputs to build
        # the plot label. Note that the dependencies on both the inputs
        # and the data reactive expression are both tracked, and
        # all expressions are called in the sequence implied by the
        # dependency graph
        output$dygraph <- renderDygraph({
                dygraph(predicted(), main = paste("Number of visitors entering ", input$Province)) %>%
                        dySeries("tsData", label = "Actual") %>%
                        dySeries(c("p.lwr", "p.fit", "p.upr"), label = "Predicted") %>%
                        dySeries("tsDatap", label = "Trend") %>%
                        dyRangeSelector(dateWindow = c(ymd("2011-01-01"),
                                                       ymd("2015-11-01") %m+% months(input$months) )) %>%
                        dyHighlight(highlightCircleSize = 5,
                                    highlightSeriesBackgroundAlpha = 0.2,
                                    hideOnMouseOut = FALSE)
        })

        # Mapping
        Mapd <- reactive({
                target <- toupper(input$Province)
                Mapdat[which(Mapdat$province == target),]
        })

        output$mymap <- renderLeaflet({
                leaflet(Mapd()) %>%
               setView(lng = -96.88 ,lat=, 62, zoom =3) %>%
                        addProviderTiles("MapQuestOpen.OSM") %>%
#               addTiles() %>%  # Add default OpenStreetMap map tiles
               addPopups(lng = ~long, lat = ~lat, ~content,
                        options = popupOptions(closeButton = FALSE))
                        })

        #Table
        data <- reactive({
                Province <- input$Province
                EntryData[,c("Month",gsub(" ",".",Province))]

        })

        output$table <- renderTable({
                data.frame(data())
        })
})
