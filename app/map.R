# Map only
knitr::opts_chunk$set(fig.width=12, fig.height=8, fig.path='figs/',
                      echo=T, warning=FALSE, message=FALSE)

if (!require("DT")) install.packages('DT')
if (!require("dtplyr")) install.packages('dtplyr')
if (!require("lubridate")) install.packages('lubridate')
if (!require("ggmap")) install.packages('ggmap')
if (!require("choroplethrZip")) {
  # install.packages("devtools")
  library(devtools)
  install_github('arilamstein/choroplethrZip@v1.5.0')}
if (!require("shiny")) install.packages("shiny")
if (!require("choroplethr")) install.packages("choroplethr")
if (!require("devtools")) install.packages("devtools")
library(devtools)
if (!require("choroplethrZip")) 
devtools::install_github('arilamstein/choroplethrZip@v1.5.0')
if (!require("ggplot2")) devtools::install_github("hadley/ggplot2")
if (!require("ggmap")) devtools::install_github("dkahle/ggmap")
library(shiny)
library(dtplyr)
library(dplyr)
library(DT)
library(lubridate)
library(choroplethrZip)
library(ggmap)

######### Visualizing Data ###############
ggmap(get_map("Manhattan", source="google", 
              maptype = "hybrid",
              zoom=12, color = "bw")) + 
  geom_point(data=mh2009.selgeo, aes(x=lon,y=lat),  color='red') 
