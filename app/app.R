#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
library(reactable)
library(htmltools)
library(dichromat)
library(shiny)

setwd("~/Downloads/GitHub/Spring2021-Project2-group1/data/cleaned_model_data")
rank_data<- read.csv("final_model_table.csv",stringsAsFactors = FALSE)


covid_cols<-c("One_Month_Cases","One_month_fatality_rate","Total_Deaths","Positive_Test_Rate")
human_cols<-c("lockdown_severity","Mobility","Gross_State_Product","Rank_health","HDI")
vul_cols<-c("assess_to_vaccines_per_hundred",
            "doses_per_hundred",
            "HospitalBeds",
            "respiratory_mortality_rate",
            "respiratory_infections_rate",
            "obesity_prevalence")

rank_data<-rank_data[,c("Rank","State","Score",covid_cols,vul_cols,human_cols)]

library(shiny)
library(reactable)

ui <- fluidPage(
    titlePanel("reactable example"),
    reactableOutput("table")
)

server <- function(input, output, session) {
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
                      Rank=colDef(class="rank-cell",maxWidth = 55, name="RANK",align="left",
                                  style = sticky_style, headerStyle = sticky_style),
                      #STATE need to insert pictures 
                      State = colDef(defaultSortOrder = "asc",
                                     maxWidth = 110,
                                     headerStyle = list(fontWeight = 700), 
                                     cell = function(value) {
                                         div(
                                             class = "state-cell",
                                             img(class = "flag",  src = sprintf("images/%s.png", value)),
                                             div(class = "state-name", value)
                                         )
                                         #    alt = paste(value, "flag"),             
                                         #                 
                                         #               image<-img(src = sprintf("images/%s.png", value), height = "24px", alt =value)
                                         # tagList(
                                         #   div(style = list(display = "inline-block", width = "45px"), image)
                                     }),
                      #SCORE need colors 
                      Score=colDef(name="RESILIENCE SCORE",
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
                                                       format=colFormat(currency = "USD"),
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
    )}


shinyApp(ui, server)
