#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
#-------------------------------------------------App Server----------------------------------
library(viridis)
library(dplyr)
library(tibble)
library(tidyverse)
library(shinythemes)
library(sf)
library(RCurl)
library(tmap)
library(rgdal)
library(leaflet)
library(shiny)
library(shinythemes)
library(plotly)
library(ggplot2)
library(lubridate)
library(zoo)
library(highcharter)
library(leaflet.extras)
library(shinydashboard)
library(RColorBrewer)
library(htmltools)
library(maps)
library(viridisLite)
library(shinyWidgets)
library(scales)
library(geosphere)
library(gganimate)
library(ggthemes)
library(readr)
library(openair)
library(ggdark)
library(DT)
library(stringr)
library(rvest)
library(robotstxt)
#can run RData directly to get the necessary date for the app
#global.r will enable us to get new data everyday
#update data with automated script
source("global.R")

# Notice! Not sure if we need the following "load" function.
#load('./output/covid-19.RData')

shinyServer(function(input, output) {
#----------------------------------------
#tab panel 1 - Home Plots
#preapare data for plot
output$case_overtime <- renderPlotly({
    #determin the row index for subset
    req(input$log_scale)
    end_date_index <- which(date_choices == input$date)
    #if log scale is not enabled, we will just use cases
    if (input$log_scale == FALSE) {
        #render plotly figure
        case_fig <- plot_ly()
        #add comfirmed case lines
        case_fig <- case_fig %>% add_lines(x = ~date_choices[1:end_date_index], 
                             y = ~as.numeric(aggre_cases[input$country,])[1:end_date_index],
                             line = list(color = 'rgba(67,67,67,1)', width = 2),
                             name = 'Confirmed Cases')
        #add death line 
        case_fig <- case_fig %>% add_lines(x = ~date_choices[1:end_date_index],
                               y = ~as.numeric(aggre_death[input$country,])[1:end_date_index],
                               name = 'Death Toll')
        #set the axis for the plot
        case_fig <- case_fig %>% 
            layout(title = paste0(input$country,'\t','Trend'),
                   xaxis = list(title = 'Date',showgrid = FALSE), 
                   yaxis = list(title = 'Comfirmed Cases/Deaths',showgrid=FALSE)
                   )
        }
    #if enable log scale, we need to take log of the y values
    else{
        #render plotly figure
        case_fig <- plot_ly()
        #add comfirmed case lines
        case_fig <- case_fig %>% add_lines(x = ~date_choices[1:end_date_index], 
                                           y = ~log(as.numeric(aggre_cases[input$country,])[1:end_date_index]),
                                           line = list(color = 'rgba(67,67,67,1)', width = 2),
                                           name = 'Confirmed Cases')
        #add death line 
        case_fig <- case_fig %>% add_lines(x = ~date_choices[1:end_date_index],
                                           y = ~log(as.numeric(aggre_death[input$country,])[1:end_date_index]),
                                           name = 'Death Toll')
        #set the axis for the plot
        case_fig <- case_fig %>% 
            layout(title = paste0(input$country,'<br>','\t','Trends'),
                   xaxis = list(title = 'Date',showgrid = FALSE), 
                   yaxis = list(title = 'Comfirmed Cases/Deaths(Log Scale)',showgrid=FALSE)
            )
    }
    return(case_fig)
        })
#----------------------------------------
#tab panel 2 - Case/Death Map
ouput$map<-renderLeaflet({
    leaflet(data=mapStates) %>%
    setView(-96, 37.8, 4) %>%
    addTiles() %>%
    addPolygons(
        fillColor = pal(map_data$Score),
        weight = 2,
        opacity = 1,
        color = "white",
        dashArray = "3",
        fillOpacity = 0.7,
        highlight = highlightOptions(
            weight = 5,
            color = "#666",
            dashArray = "",
            fillOpacity = 0.7,
            bringToFront = TRUE),
        label = labels,
        labelOptions = labelOptions(
            style = list("font-weight" = "normal", padding = "3px 8px"),
            textsize = "15px",
            direction = "auto"))})

# data_countries <- reactive({
#     if(!is.null(input$choices)){
#         if(input$choices == "Cases"){
#             return(aggre_cases_copy)
#             
#         }else{
#             return(aggre_death_copy)
#         }}
# })
# 
# #get the largest number of count for better color assignment
# maxTotal<- reactive(max(data_countries()%>%select_if(is.numeric), na.rm = T))    
# ##color palette
# pal <- reactive(colorNumeric(c("#FFFFFFFF" ,rev(inferno(256))), domain = c(0,log(binning(maxTotal())))))    
#     
# output$map <- renderLeaflet({
#     map <-  leaflet(states) %>%
#         addProviderTiles("Stadia.Outdoors", options = providerTileOptions(noWrap = TRUE)) %>%
#         setView(0, 30, zoom = 3) })
# 
# observe({
#     if(!is.null(input$date_map)){
#         select_date <- format.Date(input$date_map,'%Y-%m-%d')
#     }
#     if(input$choices == "Cases"){
#         #merge the spatial dataframe and cases dataframe
#         aggre_cases_join <- merge(states,
#                                   data_countries(),
#                                   by.x = 'name',
#                                   by.y = 'state_names',sort = FALSE)
#         ##pop up for polygons
#         country_popup <- paste0("<strong>State: </strong>",
#                                 aggre_cases_join$name,
#                                 "<br><strong>",
#                                 "Total Cases: ",
#                                 aggre_cases_join[[select_date]],
#                                 "<br><strong>")
#         
#         leafletProxy("map", data = aggre_cases_join)%>%
#             addPolygons(fillColor = pal()(log((aggre_cases_join[[select_date]])+1)),
#                         layerId = ~name,
#                         fillOpacity = 1,
#                         color = "#BDBDC3",
#                         weight = 1,
#                         popup = country_popup) 
#     } else {
#        #join the two dfs together
#         aggre_death_join<- merge(states,
#                                  data_countries(),
#                                  by.x = 'name',
#                                  by.y = 'state_names',
#                                  sort = FALSE)
#         ##pop up for polygons
#         country_popup <- paste0("<strong>State: </strong>",
#                                 aggre_death_join$name,
#                                "<br><strong>",
#                                 "Total Deaths: ",
#                                 aggre_death_join[[select_date]],
#                                 "<br><strong>")
#         
#         leafletProxy("map", data = aggre_death_join)%>%
#             addPolygons(fillColor = pal()(log((aggre_death_join[[select_date]])+1)),
#                       layerId = ~name,
#                         fillOpacity = 1,
#                         color = "#BDBDC3",
#                         weight = 1,
#                        popup = country_popup)
#         
#         }
#     })

# Tab Panel 5 - Ranking Table ###########

##########  #############
output$table <- renderReactable({
    reactable(rank_data,
              pagination = FALSE,
              borderless = TRUE,
              defaultSorted = "Rank",
              defaultSortOrder = "asc",
              showSortIcon = FALSE,
              searchable = TRUE, 
              minRows = 25,
              height = 800,
              showPageSizeOptions = TRUE, 
              defaultPageSize = 10,
              pageSizeOptions = c(10, 15, 20, 25), 
              defaultColDef = colDef(
                  align = "center",
                  minWidth = 100
              ), 
              theme = reactableTheme(
                  borderColor = "#dfe2e5",
                  stripedColor = "#f6f8fa",
                  highlightColor = "#f0f5f9",
                  cellPadding = "8px 12px",
                  style = list(
                      fontFamily = "-apple-system, BlinkMacSystemFont, Segoe UI, Helvetica, Arial, sans-serif"
                  )),
              # theme = reactableTheme(
              #   headerStyle = list(
              #     "&:hover[aria-sort]" = list(background = "hsl(0, 0%, 96%)"),
              #     "&[aria-sort='ascending'], &[aria-sort='descending']" = list(background = "hsl(0, 0%, 96%)"),
              #     borderColor = "#555"
              #   )),
              defaultColGroup = colGroup(headerClass = "group-header"),
              columnGroups = list(
                  colGroup(name = "COVID SEVERITY STATUS", columns = covid_cols),
                  colGroup(name = "QUALITY OF LIFE", columns = human_cols),
                  colGroup(name = "VULNERABIlITY",columns = vul_cols)),
              columns = list(
                  #RANK
                  Rank=colDef(class="rank-cell",maxWidth = 75, name="RANK",align="left",
                              style = sticky_style, headerStyle = sticky_style),
                  #STATE need to insert pictures 
                  State = colDef(name="STATE", defaultSortOrder = "asc",
                                 maxWidth = 110,
                                 headerStyle = list(fontWeight = 700), 
                                 # cell = function(value) {
                                 #     # div(
                                 #     #     class = "state-cell",
                                 #     #     img(class = "flag",  src = sprintf("%s.png", value)),
                                 #     #     div(class = "state-name", value)
                                 #     # )
                                 #     #    alt = paste(value, "flag"),             
                                 #     #                 
                                 #     #               image<-img(src = sprintf("images/%s.png", value), height = "24px", alt =value)
                                 #     # tagList(
                                 #     #   div(style = list(display = "inline-block", width = "45px"), image)
                                 # }
                                 
                  ),
                  #SCORE need colors 
                  Score=colDef(name="SCORE",
                               maxWidth = 65,
                               style = function(value) {
                                   value
                                   normalized <- 1-(value - min(rank_data$Score)) / 
                                       (max(rank_data$Score) - min(rank_data$Score))
                                   color <- good_color(normalized)
                                   list(background = color)
                               }),
                  #1-MONTH CASES, negative
                  One_Month_Cases=covid_column(name="1-MONTH CASES",
                                               format=colFormat(separators = TRUE),
                                               class = "border-left",
                                               style = function(value) {
                                                   value
                                                   normalized <- (value - min(rank_data$One_Month_Cases)) / 
                                                       (max(rank_data$One_Month_Cases) - min(rank_data$One_Month_Cases))
                                                   color <- good_color(normalized)
                                                   list(background = color)
                                               }),
                  #1-MONTH FATALITY RATE, negative 
                  One_month_fatality_rate=covid_column(name="1-MONTH FATALITY RATE",
                                                       format=colFormat(percent = TRUE,digits = 1),
                                                       style = function(value) {
                                                           value
                                                           normalized <- (value - min(rank_data$One_month_fatality_rate)) / 
                                                               (max(rank_data$One_month_fatality_rate) - min(rank_data$One_month_fatality_rate))
                                                           color <- good_color(normalized)
                                                           list(background = color)
                                                       }),
                  #TOTAL DEATHS negative
                  Total_Deaths=covid_column(name="TOTAL DEATHS",
                                            format=colFormat(separators = TRUE),
                                            style = function(value) {
                                                value
                                                normalized <- (value - min(rank_data$Total_Deaths)) / 
                                                    (max(rank_data$Total_Deaths) - min(rank_data$Total_Deaths))
                                                color <- good_color(normalized)
                                                list(background = color)
                                            }),
                  #POSITIVE TEST RATE negative
                  Positive_Test_Rate=covid_column(name="POSITIVE TEST RATE",
                                                  format=colFormat(percent = TRUE,digits = 1),
                                                  style = function(value) {
                                                      value
                                                      normalized <- (value - min(rank_data$Positive_Test_Rate)) / 
                                                          (max(rank_data$Positive_Test_Rate) - min(rank_data$Positive_Test_Rate))
                                                      color <- good_color(normalized)
                                                      list(background = color)
                                                  }),
                  #ACCESS TO COVID VACCINES, positive
                  assess_to_vaccines_per_hundred=vul_column(name="ACCESS TO COVID VACCINES",
                                                            format=colFormat(digits = 0),
                                                            class = "border-left",
                                                            style = function(value) {
                                                                value
                                                                normalized <- 1-(value - min(rank_data$assess_to_vaccines_per_hundred)) / 
                                                                    (max(rank_data$assess_to_vaccines_per_hundred) - min(rank_data$assess_to_vaccines_per_hundred))
                                                                color <- good_color(normalized)
                                                                value <- format(round(value, 1), nsmall = 1)
                                                                list(background = color)
                                                            }),
                  #DOSES GIVEN PER 100, positive
                  doses_per_hundred=vul_column(name="DOSES GIVEN PER 100", format=colFormat(digits = 0),
                                               style = function(value) {
                                                   value
                                                   normalized <- 1-(value - min(rank_data$doses_per_hundred)) / 
                                                       (max(rank_data$doses_per_hundred) - min(rank_data$doses_per_hundred))
                                                   color <- good_color(normalized)
                                                   value <- format(round(value, 1), nsmall = 1)
                                                   list(background = color)
                                               }),
                  #LOCKDOWN SEVERITY, negative
                  lockdown_severity=vul_column(name="LOCKDOWN SEVERITY",
                                               format=colFormat(digits =0),
                                               class = "border-left",
                                               style = function(value) {
                                                   value
                                                   normalized <- (value - min(rank_data$lockdown_severity)) / 
                                                       (max(rank_data$lockdown_severity) - min(rank_data$lockdown_severity))
                                                   color <- good_color(normalized)
                                                   list(background = color)
                                               }),
                  #COMMUNITY MOBILITY, positive
                  Mobility=human_column(name="COMMUNITY MOBILITY",format=colFormat(digits = 0,suffix = "%"),
                                        style = function(value) {
                                            value
                                            normalized <- (value - min(rank_data$Mobility)) / 
                                                (max(rank_data$Mobility) - min(rank_data$Mobility))
                                            color <- good_color(normalized)
                                            list(background = color)
                                        }),
                  #2021 GDP GROWTH FORECAST, positive 
                  Gross_State_Product=human_column(name="2021 GSP GROWTH FORECAST",
                                                   format=colFormat(digits = 2),
                                                   class = "gsp-cell",
                                                   style = function(value) {
                                                       value
                                                       normalized <- 1-(value - min(rank_data$Gross_State_Product)) / 
                                                           (max(rank_data$Gross_State_Product) - min(rank_data$Gross_State_Product))
                                                       color <- good_color(normalized)
                                                       list(background = color)
                                                   }),
                  #HEALTHCARE RANK, negative
                  Rank_health=human_column(name="HEALTHCARE RANK",
                                           style = function(value) {
                                               value
                                               normalized <- (value - min(rank_data$Rank_health)) / 
                                                   (max(rank_data$Rank_health) - min(rank_data$Rank_health))
                                               color <- good_color(normalized)
                                               list(background = color)
                                           }),
                  #HUMAN DEVELOPMENT INDEX:positive
                  HDI=human_column(name="HUMAN DEVELOPMENT INDEX",
                                   style = function(value) {
                                       value
                                       normalized <- 1-(value - min(rank_data$HDI)) / 
                                           (max(rank_data$HDI) - min(rank_data$HDI))
                                       color <- good_color(normalized)
                                       list(background = color)
                                   }),
                  #respiratory mortality rate: negative
                  respiratory_mortality_rate=vul_column(
                      name="RESPIRATORY MORTALITY RATE",format=colFormat(percent =TRUE,digits=0),
                      style = function(value) {
                          value
                          normalized <- (value - min(rank_data$respiratory_mortality_rate)) / 
                              (max(rank_data$respiratory_mortality_rate) - min(rank_data$respiratory_mortality_rate))
                          color <- good_color(normalized)
                          list(background = color)
                      }),
                  #respiratory infections rate: negative
                  respiratory_infections_rate=vul_column(name="RESPIRATORY INFECTIOUS RATE",
                                                         format=colFormat(percent=TRUE,digits = 0),
                                                         style = function(value) {
                                                             value
                                                             normalized <- (value - min(rank_data$respiratory_infections_rate)) / 
                                                                 (max(rank_data$respiratory_infections_rate) -min(rank_data$respiratory_infections_rate))
                                                             color <- good_color(normalized)
                                                             list(background = color)
                                                         }),
                  #OBESITY PREVALENCE, negative
                  obesity_prevalence=vul_column(name="OBESITY PREVALENCE",
                                                format=colFormat(percent=TRUE),
                                                style = function(value) {
                                                    value
                                                    normalized <- (value - min(rank_data$obesity_prevalence)) / 
                                                        (max(rank_data$obesity_prevalence) - min(rank_data$obesity_prevalence))
                                                    color <- good_color(normalized)
                                                    list(background = color)
                                                }),
                  #HOSPITAL BEDS,psotive
                  HospitalBeds=vul_column(name="HOSPITAL BEDS",
                                          format=colFormat(digits=3),
                                          style = function(value) {
                                              value
                                              normalized <-1- (value - min(rank_data$HospitalBeds)) / 
                                                  (max(rank_data$HospitalBeds) - min(rank_data$HospitalBeds))
                                              color <- good_color(normalized)
                                              list(background = color)
                                          }
                  ),
                  # Emphasize borders between groups when sorting by group
                  showSortIcon = FALSE,
                  borderless = TRUE,
                  class = "standings-table"
              ))
    
}
)


####### table of status#######
output$table1 <- renderReactable({
    reactable(data1,
              showSortIcon = FALSE,
              minRows = 25,
              defaultSorted="State",
              columns=list(
                  One_Month_Cases=colDef(name="1-MONTH CASES",
                                         format=colFormat(separators = TRUE),
                                         cell = function(value) {
                                             width <- paste0(value * 100 / max(data1$One_Month_Cases), "%")
                                             value <- format(value, big.mark = ",")
                                             
                                             # Fix each label using the width of the widest number (incl. thousands separators)
                                             value <- format(value, width = 9, justify = "right")
                                             bar_chart(value, width = width, fill = "#fc5185", background = "#e1e1e1")
                                         },align = "left",
                                         # Use the operating system's default monospace font, and
                                         # preserve white space to prevent it from being collapsed by default
                                         style = list(fontFamily = "monospace", whiteSpace = "pre")
                  ),
                  One_month_fatality_rate=colDef(name="1-MONTH FATALITY RATE",
                                                 cell = function(value) {
                                                     value <- paste0(format(value * 100, nsmall = 1), "%")
                                                     value <- format(value, width = 5, justify = "right")
                                                     
                                                     # Fix each label using the width of the widest number (incl. thousands separators)
                                                     bar_chart(value, width = value, fill = "#fc5185", background = "#e1e1e1")
                                                 },align = "left",
                                                 # Use the operating system's default monospace font, and
                                                 # preserve white space to prevent it from being collapsed by default
                                                 style = list(fontFamily = "monospace", whiteSpace = "pre")
                  ),
                  
                  Total_Deaths=colDef(name="TOTAL DEATHS",
                                      format=colFormat(separators = TRUE),
                                      cell = function(value) {
                                          width <- paste0(value * 100 / max(data1$Total_Deaths), "%")
                                          # Add thousands separators
                                          value <- format(value, big.mark = ",")
                                          value <- format(value, width = 9, justify = "right")
                                          bar_chart(value, width = width, fill = "#fc5185", background = "#e1e1e1")
                                      },align = "left",
                                      # Use the operating system's default monospace font, and
                                      # preserve white space to prevent it from being collapsed by default
                                      style = list(fontFamily = "monospace", whiteSpace = "pre"))
                  ,
                  Positive_Test_Rate=colDef(name="POSITIVE TEST RATE",
                                            format=colFormat(percent = TRUE,digits = 1),
                                            cell = function(value) {
                                                value <- paste0(format(value * 100, nsmall = 1), "%")
                                                value <- format(value, width = 5, justify = "right")
                                                
                                                # Fix each label using the width of the widest number (incl. thousands separators)
                                                bar_chart(value, width = value, fill = "#fc5185", background = "#e1e1e1")
                                            },align = "left",
                                            # Use the operating system's default monospace font, and
                                            # preserve white space to prevent it from being collapsed by default
                                            style = list(fontFamily = "monospace", whiteSpace = "pre")
                  )))
    
})

####### table of vul #######
output$table2 <- renderReactable({
    reactable(data2,
              showSortIcon = FALSE,
              minRows = 25,
              defaultSorted="State",
              columns = list(
                  assess_to_vaccines_per_hundred=colDef(name="ACCESS TO COVID VACCINES",
                                                        format=colFormat(digits = 0), cell = function(value) {
                                                            width <- paste0(value * 100 / max(data2$assess_to_vaccines_per_hundred), "%")
                                                            # Add thousands separators
                                                            value <- format(value, big.mark = ",")
                                                            value <- format(value, width = 9, justify = "right")
                                                            bar_chart(value, width = width, fill = "#3fc1c9", background = "#e1e1e1")
                                                        },align = "left",
                                                        # Use the operating system's default monospace font, and
                                                        # preserve white space to prevent it from being collapsed by default
                                                        style = list(fontFamily = "monospace", whiteSpace = "pre")),
                  doses_per_hundred=colDef(name="DOSES GIVEN PER 100", format=colFormat(digits = 0),
                                           cell = function(value) {
                                               width <- paste0(value * 100 / max(data2$doses_per_hundred), "%")
                                               # Add thousands separators
                                               value <- format(value, big.mark = ",")
                                               value <- format(value, width = 9, justify = "right")
                                               bar_chart(value, width = width, fill = "#3fc1c9", background = "#e1e1e1")
                                           },align = "left",
                                           # Use the operating system's default monospace font, and
                                           # preserve white space to prevent it from being collapsed by default
                                           style = list(fontFamily = "monospace", whiteSpace = "pre")),
                  respiratory_mortality_rate=colDef(
                      name="RESPIRATORY MORTALITY RATE",format=colFormat(percent =TRUE,digits=0),
                      cell = function(value) {
                          value <- paste0(format(value * 100, nsmall = 1), "%")
                          value <- format(value, width = 5, justify = "right")
                          
                          # Fix each label using the width of the widest number (incl. thousands separators)
                          bar_chart(value, width = value, fill = "#fc5185", background = "#e1e1e1")
                      },align = "left",
                      # Use the operating system's default monospace font, and
                      # preserve white space to prevent it from being collapsed by default
                      style = list(fontFamily = "monospace", whiteSpace = "pre")),
                  respiratory_infections_rate=colDef(name="RESPIRATORY INFECTIOUS RATE",
                                                     format=colFormat(percent=TRUE,digits = 0),
                                                     cell = function(value) {
                                                         value <- paste0(format(value * 100, nsmall = 1), "%")
                                                         value <- format(value, width = 5, justify = "right")
                                                         
                                                         # Fix each label using the width of the widest number (incl. thousands separators)
                                                         bar_chart(value, width = value, fill = "#fc5185", background = "#e1e1e1")
                                                     },align = "left",
                                                     # Use the operating system's default monospace font, and
                                                     # preserve white space to prevent it from being collapsed by default
                                                     style = list(fontFamily = "monospace", whiteSpace = "pre")),
                  obesity_prevalence=colDef(name="OBESITY PREVALENCE",
                                            format=colFormat(percent=TRUE),
                                            cell = function(value) {
                                                value <- paste0(format(value * 100, nsmall = 1), "%")
                                                value <- format(value, width = 5, justify = "right")
                                                
                                                # Fix each label using the width of the widest number (incl. thousands separators)
                                                bar_chart(value, width = value, fill = "#fc5185", background = "#e1e1e1")
                                            },align = "left",
                                            # Use the operating system's default monospace font, and
                                            # preserve white space to prevent it from being collapsed by default
                                            style = list(fontFamily = "monospace", whiteSpace = "pre")),
                  HospitalBeds=colDef(name="HOSPITAL BEDS",
                                      format=colFormat(digits=3), cell = function(value) {
                                          width <- paste0(value * 100 / max(data2$HospitalBeds), "%")
                                          # Add thousands separators
                                          value <- format(value, big.mark = ",")
                                          value <- format(value, width = 9, justify = "right")
                                          bar_chart(value, width = width, fill = "#3fc1c9", background = "#e1e1e1")
                                      },align = "left",
                                      # Use the operating system's default monospace font, and
                                      # preserve white space to prevent it from being collapsed by default
                                      style = list(fontFamily = "monospace", whiteSpace = "pre")
                  )
              ))
    
    
})

####### table of quality #######
output$table3 <- renderReactable({
    
    reactable(data3,
              showSortIcon = FALSE,
              minRows = 25,
              defaultSorted="State",
              columns=list(
                  HDI=colDef(name="HUMAN DEVELOPMENT INDEX",
                             cell = function(value) {
                                 width <- paste0(value * 100 / max(data3$HDI), "%")
                                 value <- format(value, big.mark = ",")
                                 
                                 # Fix each label using the width of the widest number (incl. thousands separators)
                                 value <- format(value, width = 9, justify = "right")
                                 bar_chart(value, width = width, fill = "#3fc1c9", background = "#e1e1e1")
                             },align = "left",
                             # Use the operating system's default monospace font, and
                             # preserve white space to prevent it from being collapsed by default
                             style = list(fontFamily = "monospace", whiteSpace = "pre")
                  ),
                  Rank_health=colDef(name="HEALTHCARE RANK",
                                     cell = function(value) {
                                         width <- paste0(value * 100 / max(data3$Rank_health), "%")
                                         value <- format(value, big.mark = ",")
                                         
                                         # Fix each label using the width of the widest number (incl. thousands separators)
                                         value <- format(value, width = 9, justify = "right")
                                         bar_chart(value, width = width, fill = "#3fc1c9", background = "#e1e1e1")
                                     },align = "left",
                                     # Use the operating system's default monospace font, and
                                     # preserve white space to prevent it from being collapsed by default
                                     style = list(fontFamily = "monospace", whiteSpace = "pre")
                  ),
                  Gross_State_Product=colDef(name="2021 GSP GROWTH FORECAST",
                                             cell = function(value) {
                                                 width <- paste0(value * 100 / max(data3$Gross_State_Product), "%")
                                                 value <- format(value, big.mark = ",")
                                                 
                                                 # Fix each label using the width of the widest number (incl. thousands separators)
                                                 value <- format(value, width = 9, justify = "right")
                                                 bar_chart(value, width = width, fill = "#3fc1c9", background = "#e1e1e1")
                                             },align = "left",
                                             # Use the operating system's default monospace font, and
                                             # preserve white space to prevent it from being collapsed by default
                                             style = list(fontFamily = "monospace", whiteSpace = "pre")
                  ),
                  Mobility=colDef(name="COMMUNITY MOBILITY",format=colFormat(digits = 0,suffix = "%"),
                                  cell = function(value) {
                                      width <- paste0(value * 100 / max(data3$Mobility), "%")
                                      value <- format(value, big.mark = ",")
                                      
                                      # Fix each label using the width of the widest number (incl. thousands separators)
                                      value <- format(value, width = 9, justify = "right")
                                      bar_chart(value, width = width, fill = "#fc5185", background = "#e1e1e1")
                                  },align = "left",
                                  # Use the operating system's default monospace font, and
                                  # preserve white space to prevent it from being collapsed by default
                                  style = list(fontFamily = "monospace", whiteSpace = "pre") ),
                  lockdown_severity=colDef(name="LOCKDOWN SEVERITY",
                                           format=colFormat(digits =0),
                                           cell = function(value) {
                                               width <- paste0(value * 100 / max(data3$lockdown_severity), "%")
                                               value <- format(value, big.mark = ",")
                                               
                                               # Fix each label using the width of the widest number (incl. thousands separators)
                                               value <- format(value, width = 9, justify = "right")
                                               bar_chart(value, width = width, fill = "#fc5185", background = "#e1e1e1")
                                           },align = "left",
                                           # Use the operating system's default monospace font, and
                                           # preserve white space to prevent it from being collapsed by default
                                           style = list(fontFamily = "monospace", whiteSpace = "pre")
                  ))
    )
    
})




div(class = "standings",
    div(class = "title",
        h2("Covid Resilience Ratings for All States"),
        ""
    ),
    tbl,
    "Reference Source:
    https://www.bloomberg.com/graphics/covid-resilience-ranking/"
)





########## YOUR CODE ENDS HERE #############
# Panel 5 ends ##############


############# Tab Panel 6 - Statistical Graphs (Finish if having time, not necessary) #########
table_data <- model_data_copy
########## YOUR CODE STARTS HERE #############



########## YOUR CODE ENDS HERE #############
############ Panel 6 ends #######################


######## Panel 7 Model Map #########



########## Panel 7 Ends #######

})