
Interactive Visualization Tool for Tourism
========================================================
author: logo403
date: Feb 21, 2016

Tourism Industry in Canada
========================================================

- Tourism plays a significant role in Canada's economy
- At 1.5% growth in Canada, the industry is losing share of travel market
- Significant efforts are being made to improve this situation
 + Larger marketing budgets
 + Better access, e.g. Visa policies
 + Infrastructure modernization, e.g. museums, parks, heritage sites, etc.


Interactive Tools for Tourism Stakeholders and Users
========================================================

- The tool can be used by clicking on:

> <center><strong><a href="https://logo403.shinyapps.io/FrontierCounts/">Interactive Tool</a></strong></center>

- The codes can be found here

><center><strong><a href="https://github.com/logo403/FrontierCounts">Codes in Github</a></strong></center>

How Can the Tool Be Used
========================================================
Time Series Tab
 > 1. You choose the area of interest
 > 2. You select the number of month you want to forecast
 > 3. You determine the precision of forecast
 > 4. You can expand the time series by using the slider at the bottom of the graph

Map Tab
  > 1. Click on the link to see attractions of the area of interest



R code Chunks
========================================================
Here is the R code to read the data on
<small>

```r
fileName <- "cansim-4270001-eng-5355849443735675565.csv"
cname <-c("Month", unlist(read.table(fileName, sep = ",", nrows=1, skip = 3, colClasses = "character"), use.names = FALSE)[-1])
EntryData <- read.table(fileName, sep = ",", nrows=527, skip = 5, col.names = cname)
Mapdat <- read.csv("map1.csv")
```
</small>
<small><div><strong>Source: </strong> Statistics Canada.<a href="http://www5.statcan.gc.ca/cansim/a26?lang=eng&retrLang=eng&id=4270001">Table 427-0001</a> <em>- Number of international travellers entering or returning to Canada, by type of transport, monthly (persons)</em>, CANSIM</div></small>



