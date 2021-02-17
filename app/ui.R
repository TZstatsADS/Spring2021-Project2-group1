#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#ag
#    http://shiny.rstudio.com/
#
# Define UI for application that draws a histogram
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
library(data.table)
#load('./output/covid-19.RData')
shinyUI(navbarPage(title = 'COVID-19',
                   fluid = TRUE,
                   collapsible = TRUE,
                   #Select whichever theme works for the app 
                   theme = shinytheme("yeti"),
                  
                   #--------------------------
                   #tab panel 2 - Map
                   tabPanel("Case & Death Map",icon = icon("map-marker-alt"),div(class = 'outer',
                            leafletOutput("map", width = "100%", height = "1200"),
                            absolutePanel(id = "control", class = "panel panel-default", fixed = TRUE, draggable = TRUE,
                                          top = 300, left = 20, right = "auto", bottom = "auto", width = 250, height = "auto",
                                          selectInput('choices','Which data to visualize:',
                                                      choices = c('Cases','Death'),
                                                      selected = c('Cases')),
                                          sliderInput('date_map','Input Date:',
                                                      #first day of data recording
                                                      min = as.Date(date_choices[1]),
                                                      #present day of data recording
                                                      max = as.Date(tail(date_choices,1)),
                                                     value = as.Date('2020-04-01','%Y-%m-%d'),
                                                    timeFormat = "%Y-%m-%d",
                                                     animate = TRUE, step = 5),
                                          style = "opacity: 0.80"))),
                   #Tab panel 3 - Ranking Table
                   tabPanel("Ranking Table",icon = icon("thumbs-up"),  #Need a "," here
                            ############## YOUR CODE STARTS HERE #############
                            
                            
                            dashboardPage(
                              dashboardHeader(disable = TRUE),
                              dashboardSidebar(
                                sidebarMenu(
                                  menuItem("Ranking", tabName = "ranking", icon = icon("dashboard")),
                                  menuItem("Covid Status", icon = icon("clinic-medical"), tabName = "status"),
                                  menuItem("Vulnerability", icon = icon("allergies"), tabName = "vulnerability"),
                                  menuItem("Life Quality", icon = icon("briefcase-medical"), tabName = "quality")
                                )
                              ),
                              
                              dashboardBody(
                                tabItems(
                                  tabItem(tabName = "ranking",
                                          fluidPage(
                                            titlePanel("Resilience Ranking of the States"),
                                            reactableOutput("table"),
                                            tags$link(href = "https://fonts.googleapis.com/css?family=Karla:400,700|Fira+Mono&display=fallback", rel = "stylesheet"),
                                            tags$link(rel = "stylesheet", type = "css", href = "styledef.css")
                                          )
                                  ),
                                  
                                  #####table of covid status here#####
                                  tabItem(tabName = "status",
                                          fluidPage(
                                            titlePanel("Covid Status Across States"),
                                            reactableOutput("table1"),
                                            tags$link(href = "https://fonts.googleapis.com/css?family=Karla:400,700|Fira+Mono&display=fallback", rel = "stylesheet"),
                                            tags$link(rel = "stylesheet", type = "css", href = "styledef.css")
                                          )
                                  ),
                                  
                                  #####table of vulnerability here#####
                                  tabItem(tabName = "vulnerability",
                                          fluidPage(
                                            titlePanel("Medical Vulnerability by State"),
                                            reactableOutput("table2"),
                                            tags$link(href = "https://fonts.googleapis.com/css?family=Karla:400,700|Fira+Mono&display=fallback", rel = "stylesheet"),
                                            tags$link(rel = "stylesheet", type = "css", href = "styledef.css")
                                          )
                                  ),
                                  
                                  #####table of life quality here#####
                                  tabItem(tabName = "quality",
                                          fluidPage(
                                            titlePanel("Quality of Life by State"),
                                            reactableOutput("table3"), 
                                            tags$link(href = "https://fonts.googleapis.com/css?family=Karla:400,700|Fira+Mono&display=fallback", rel = "stylesheet"),
                                            tags$link(rel = "stylesheet", type = "css", href = "styledef.css")
                                          )
                                  )
                                  
                                )
                              )
                            )
                            
                            
                            ##########  ### YOUR CODE ENDS HERE ##############
                   ),

                  
                   #Tab panel 4 - Methodology
                   
                   tabPanel("Methodology", icon = icon ("camera-retro"),
                            HTML(
                              '<h2> Methodology of Building Our Model : </h2>
                              <p><strong>How is the Ranking aggregated?</strong></p>
<p><strong>&nbsp; &nbsp; &nbsp; &nbsp;Each of the 14 data indicators is aggregated through the &ldquo;</strong><a href="https://www.un.org/development/desa/dpad/wp-content/uploads/sites/45/max-min.pdf"><strong>max-min</strong></a><strong>&rdquo; method</strong><span style="font-weight: 400;">, which is used to convert metrics expressed in different scales into a common one while maintaining the relative distance between values.</span></p>
<p><span style="font-weight: 400;">&nbsp; &nbsp; &nbsp; All the indicators are scored on a 0 to 100 scale, with 100 (blue) indicating the best performance and zero (orange) the worst. The rest fall in between, scaled by their distance from one another.&nbsp;</span><strong>The final Resilience Score is the average of a place&rsquo;s performance across the 11indicators, equally weighted.</strong></p>
<p>&nbsp;</p>
<p><strong>Detailed Definitions of Indicators:</strong></p>
<p><strong>A. Indicators for Status of Covid Severity</strong></p>
<ul>
<li style="font-weight: 400;"><span style="font-weight: 400;">1-Month Cases Per 100K:&nbsp;</span>The total number of cases per 100K people in one month.
<ul>
<li style="font-weight: 400;">[Source] <a href="https://github.com/CSSEGISandData/COVID-19/tree/master/csse_covid_19_data/csse_covid_19_time_series"><span style="font-weight: 400;">https://github.com/CSSEGISandData/COVID-19/tree/master/csse_covid_19_data/csse_covid_19_time_series</span></a></li>
</ul>
</li>
</ul>
<ul>
<li style="font-weight: 400;"><span style="font-weight: 400;">1-Month Fatality Rate:&nbsp;</span>The number of deaths in one month / the cumulative total of deaths.
<ul>
<li style="font-weight: 400;">[Source] <a href="https://github.com/CSSEGISandData/COVID-19/tree/master/csse_covid_19_data/csse_covid_19_time_series"><span style="font-weight: 400;">https://github.com/CSSEGISandData/COVID-19/tree/master/csse_covid_19_data/csse_covid_19_time_series</span></a></li>
</ul>
</li>
</ul>
<ul>
<li style="font-weight: 400;"><span style="font-weight: 400;">Total Deaths Per 1M:&nbsp;</span>The number of total deaths per 1 million population in one month.
<ul>
<li style="font-weight: 400;">[Source] <a href="https://github.com/CSSEGISandData/COVID-19/tree/master/csse_covid_19_data/csse_covid_19_time_series"><span style="font-weight: 400;">https://github.com/CSSEGISandData/COVID-19/tree/master/csse_covid_19_data/csse_covid_19_time_series</span></a></li>
</ul>
</li>
</ul>
<ul>
<li style="font-weight: 400;"><span style="font-weight: 400;">Positive Test Rate--cumulative:&nbsp;</span>The number of positives / total amount of test results, using cumulative data.
<ul>
<li style="font-weight: 400;">[Source]&nbsp;<a href="https://raw.githubusercontent.com/owid/covid-19-data/master/public/data/testing/covid-testing-all-observations.csv">https://raw.githubusercontent.com/owid/covid-19-data/master/public/data/testing/covid-testing-all-observations.csv</a></li>
</ul>
</li>
</ul>
<p>&nbsp;</p>
<p><strong>B. Indicators for Vulnerability</strong></p>
<p><span style="font-weight: 400;">&nbsp; &nbsp; &nbsp; Taking into account that Covid is a&nbsp; contagious respiratory disease, we consider a state&rsquo;s mortality rate in similar historical diseases as an indicator of its vulnerability. Besides, since obesity is also found to be correlated with infection in several studies, we also included the obesity prevalence across the states as an indicator. What&rsquo;s more, the vaccination campaign in a state also reveals how it responds to the covid status.</span></p>
<ul>
<li style="font-weight: 400;"><span style="font-weight: 400;"><strong>Historical disease mortality rate data across states</strong>:&nbsp;</span>Historical data of a state&rsquo;s chronic respiratory disease and lower respiratory Infectious disease are used to measure its historical medical vulnerability.
<ul>
<li style="font-weight: 400;">[Source]&nbsp;<a href="http://ghdx.healthdata.org/record/ihme-data/united-states-chronic-respiratory-disease-mortality-rates-county-1980-2014"><span style="font-weight: 400;">http://ghdx.healthdata.org/record/ihme-data/united-states-chronic-respiratory-disease-mortality-rates-county-1980-2014</span></a></li>
</ul>
</li>
</ul>
<ul>
<li style="font-weight: 400;"><span style="font-weight: 400;"><strong>Chronic respiratory disease</strong>:&nbsp;</span>IHME research produced estimates for age-standardized mortality rates by county from chronic respiratory diseases. The estimates were generated using de-identified death records from the National Center for Health Statistics (NCHS); population counts from the U.S. Census Bureau, NCHS, and the Human Mortality Database.
<ul>
<li style="font-weight: 400;">[Source]&nbsp;<a href="http://ghdx.healthdata.org/record/ihme-data/united-states-infectious-disease-mortality-rates-county-1980-2014"><span style="font-weight: 400;">http://ghdx.healthdata.org/record/ihme-data/united-states-infectious-disease-mortality-rates-county-1980-2014</span></a></li>
</ul>
</li>
</ul>
<ul>
<li style="font-weight: 400;"><span style="font-weight: 400;"><strong>Lower respiratory Infectious disease</strong>:&nbsp;</span>IHME research produced estimates for age-standardized mortality rates by county from lower respiratory infections.
<ul>
<li style="font-weight: 400;">[Source]&nbsp;<span style="font-weight: 400;"><a href="http://ghdx.healthdata.org/record/ihme-data/united-states-infectious-disease-mortality-rates-county-1980-2014">http://ghdx.healthdata.org/record/ihme-data/united-states-infectious-disease-mortality-rates-county-1980-2014</a></span></li>
</ul>
</li>
</ul>
<ul>
<li style="font-weight: 400;"><span style="font-weight: 400;"><strong>Obesity prevalence data across states</strong>:&nbsp;</span>The data comes from CDC&rsquo;s 2019 Adult Obesity Prevalence Maps for 49 states. It shows self-reported adult obesity prevalence by location. The raw data comes from the <a href="https://www.cdc.gov/brfss/"><span style="font-weight: 400;">Behavioral Risk Factor Surveillance System</span></a><span style="font-weight: 400;">, an on-going state-based, telephone interview survey conducted by CDC and state health departments.</span>
<ul>
<li style="font-weight: 400;">[Source]&nbsp;<span style="font-weight: 400;"><a href="https://www.cdc.gov/obesity/data/prevalence-maps.html#race">https://www.cdc.gov/obesity/data/prevalence-maps.html#race</a></span></li>
</ul>
</li>
</ul>
<ul>
<li style="font-weight: 400;"><strong>Vaccination:&nbsp;</strong>With an effective vaccine seen as the silver bullet that could end the pandemic, securing enough supply is an important component of a state&rsquo;s Covid-19 response.
<ul>
<li style="font-weight: 400;">Access to covid vaccinations<strong>&nbsp;</strong>depicted by the number of people who received vaccines.</li>
<li style="font-weight: 400;">Doses are given per 100&nbsp;Depicted by the share of vaccines that are used in the population.</li>
<li style="font-weight: 400;">[Source]&nbsp;<span style="font-weight: 400;"><a href="https://ourworldindata.org/us-states-vaccinations">https://ourworldindata.org/us-states-vaccinations</a></span></li>
</ul>
</li>
</ul>
<ul>
<li style="font-weight: 400;"><strong>Hospital bed occupancy:&nbsp;</strong>The data presents the number of hospitals in the U.S. as of May 2020, by state, and can be used to evaluate the capacity of a state&rsquo;s healthcare resources.
<ul>
<li style="font-weight: 400;">[Source]&nbsp;<a href="https://www.statista.com/statistics/710528/hospital-number-in-us-by-state/"><span style="font-weight: 400;">https://www.statista.com/statistics/710528/hospital-number-in-us-by-state/</span></a></li>
</ul>
</li>
</ul>
<p>&nbsp;</p>
<p><strong>C. Indicators for Quality of Life</strong></p>
<ul>
<li style="font-weight: 400;"><strong>Lockdown Severity:&nbsp;</strong>This indicator is based on an index which assesses the number and strictness of government policies that limit people&rsquo;s movements as a way of containing spiraling outbreaks.
<ul>
<li style="font-weight: 400;">[Source]&nbsp;<span style="font-weight: 400;"><a href="https://github.com/OxCGRT/USA-covid-policy/tree/master/data">https://github.com/OxCGRT/USA-covid-policy/tree/master/data</a></span></li>
</ul>
</li>
</ul>
<ul>
<li style="font-weight: 400;"><strong>Community Mobility:&nbsp;</strong>The data was collected from Google&rsquo;s COVID-2019 Community Mobility Report. We took an average of the six categories of mobility rate as an indicator. Given the broadness of the Lockdown Severity indicator, and the fact it reflects government policy and not its impact, we sought out another datapoint to better capture this picture.Google&rsquo;s Covid-19 Community Mobility Reports, which underpins our Community Mobility measure, tracks people&rsquo;s real-time movements and helps round out our understanding of how they are responding to virus restrictions in their everyday lives.
<ul>
<li style="font-weight: 400;">[Source]&nbsp;<span style="font-weight: 400;"><a href="https://www.gstatic.com/covid19/mobility/2021-02-05_US_Mobility_Report_en.pdf">https://www.gstatic.com/covid19/mobility/2021-02-05_US_Mobility_Report_en.pdf</a></span></li>
</ul>
</li>
</ul>
<ul>
<li style="font-weight: 400;"><strong>GSP Growth Estimate for 2021:&nbsp;</strong>It shows how a state&rsquo;s economic status looks like. The greater the expected contraction, the more challenging the economic reality is for people in these places, and therefore the weaker their performance on this measure.
<ul>
<li style="font-weight: 400;">[Source]&nbsp;<span style="font-weight: 400;"><a href="https://www.usgovernmentspending.com/gdp_by_state">https://www.usgovernmentspending.com/gdp_by_state</a></span></li>
</ul>
</li>
</ul>
<ul>
<li style="font-weight: 400;"><strong>Healthcare Coverage:&nbsp;</strong>For this indicator, we use usnews&rsquo; ranking of different states&rsquo; healthcare coverage as a reflection of the state&rsquo;s healthcare performance.
<ul>
<li style="font-weight: 400;">[Source]&nbsp;<span style="font-weight: 400;"><a href="https://www.usnews.com/news/best-states/rankings/health-care">https://www.usnews.com/news/best-states/rankings/health-care</a></span></li>
</ul>
</li>
</ul>
<ul>
<li style="font-weight: 400;"><strong>Subnational Human Development Index:&nbsp;</strong>This measure captures an economy&rsquo;s pre-pandemic performance. Still, the Human Development Index reflects a state&rsquo;s ability to withstand the Covid-19 blow and can be a proxy for how populations have reacted to the crisis.
<ul>
<li style="font-weight: 400;">[Source]&nbsp;<a href="https://globaldatalab.org/shdi/2018/indices/USA/?levels=1%2B4&amp;interpolation=0&amp;extrapolation=0&amp;nearest_real=0"><span style="font-weight: 400;">https://globaldatalab.org/shdi/2018/indices/USA/?levels=1%2B4&amp;interpolation=0&amp;extrapolation=0&amp;nearest_real=0</span></a></li>
</ul>
</li>
</ul>
<p>&nbsp;</p>
<p><strong>Having the indicators ready, we compare the state&rsquo;s status of severity, its vulnerability with its quality of life to evaluate its response towards Covid. By giving a rank of the states, we provide suggestions to people who are making travel choices, moving choices, and so forth.</strong></p>
<p>&nbsp;</p>
<p><strong>Model:</strong></p>
<p><a href="https://github.com/eparker12/nCoV_tracker"><span style="font-weight: 400;">eparker12/nCoV_tracker: Covid 2019 interactive mapping tool (github.com)</span></a></p>
<p><a href="https://vac-lshtm.shinyapps.io/ncov_tracker/?_ga=2.212563484.965134741.1612927410-394546439.1597636282#"><span style="font-weight: 400;">COVID-19 tracker (shinyapps.io)</span></a></p>
<p><span style="font-weight: 400;">&nbsp;</span></p>'
                            )),
                   # ----------------------------------
                   #Tab panel 6 - Statistical Graphs (Finish if having time, not necessary)
                   tabPanel("Interactive Trend Plots of Vaccinations",icon = icon("hospital"),  #Need a "," here
                            ############## YOUR CODE STARTS HERE ##############
                            fluidPage(
                              fluidRow(column(12,
                                              h3("Interactive Dashboard on Vaccinaitons"),
                                              "The following scatterplot gives a comparison between how the number of confirmed cases and the number of deaths were varying 
                                                 as the vaccinations are being more and more widely adopted. It therefore shows the importance of the vaccinations as to the epidemic prevention.
                                                 Considering the positive effects of the vaccinations, we include it as a measure of a state's level of healthcare for the construction of the ranking model.
                                                 ")),
                              br(),
                              pickerInput(inputId="state_dropdown",label='Select up to Five States',
                                          choices=unique(states_complete$State),multiple=TRUE,
                                          options=list(`max-options`=5),
                                          selected='Alabama'
                              ),
                              plotlyOutput("vaccine_ts",height="800px",width="100%"),
                              br(),
                              br()
                            )
                   ),
                   #Tab panel 7 - Statistical Graphs (Finish if having time, not necessary)
                   tabPanel("Interactive Trend Plots of Mobility",icon = icon("android"),  
                            ##### tab of mobility #####
                            fluidPage(
                              fluidRow(column(12,
                                              h3("Interactive Dashboard on Mobility across States"),
                                              "The Time Series plot for different categories of mobility 
                                                 shows the trend of this indicator.
                                                 Click on the dropdown button 
                                                 to select different states and compare how they differ in mobility features.")),
                              br(),
                              pickerInput(inputId="state_dropdown",label='Select up to Five States',
                                          choices=unique(states_complete$State),multiple=TRUE,
                                          options=list(`max-options`=5),
                                          selected='Alabama'
                              ),
                              plotlyOutput("mobi_ts",height="800px",width="100%"),
                              br(),
                              br()
                            )
                   ),
                   #--------------------------
                   # Basic Case/Death Graph
                   tabPanel("Basic Case/Death Graph",icon = icon("chart-line"),
                            fluidPage(
                              fluidRow(
                                column(12,
                                       h1("State-Wise Cases overview across time"),
                                       fluidRow(
                                         #select the date until now
                                         column(6,
                                                sliderInput('date','Date Unitl:',
                                                            #first day of data recording
                                                            min = as.Date(date_choices[1]),
                                                            #present day of data recording
                                                            max = as.Date(tail(date_choices,1)),
                                                            value = as.Date(date_choices[1]),
                                                            timeFormat = "%Y-%m-%d",
                                                            animate = TRUE, step = 5),
                                                fluidRow(
                                                  #select the country we want to see the trend
                                                  column(6,
                                                         selectInput('country','Which State?',
                                                                     choices = state_names_choices,
                                                                     selected = 'United States of America')),
                                                  #select whether want case number in log-scale or not
                                                  column(6,
                                                         radioButtons("log_scale", "In Log Scale:",
                                                                      choices = c(TRUE,FALSE),
                                                                      selected = FALSE))
                                                )
                                         ),
                                         #render plotly output
                                         column(width = 6,
                                                plotlyOutput('case_overtime'))
                                       )
                                )
                              )
                            )
                   ),



                   ############## YOUR CODE ENDS HERE ################
          

          
          ############## YOUR CODE ENDS HERE ################
          # Tab Panel 7 - About Us
          tabPanel("About",icon = icon("address-book"),
                   HTML(
                     ################### Your HTML Code Starts Here ##################
                     # Notice the single quote mark: '  //  Put everything between two single-quote marks
                     "<h1><strong>What to expect from our website</strong></h1>
                    <ul>
                    <li>
                    <h4>We used information about covid-19 in the US to provide an overview about how the states are performing under the pandemic, and under other health conditions in general.</h4>
                    </li>
                    <li>
                    <h4>On our website, you can find information about the US COVID-19 cases spread, daily update of vaccination information, state to state comparison, and so on.</h4>
                    </li>
                    </ul>
                    <h1>&nbsp;</h1>
                    <h1>About the Data</h1>
                    <h2> Data Source : </h2>
                              <h4> <p><li><a href='https://github.com/TZstatsADS/Spring2021-Project2-group1'>Our Github Website</a></li></h4>
                              <h4> <p><li><a href='https://coronavirus.jhu.edu/map.html'>Coronavirus COVID-19 Global Cases map Johns Hopkins University</a></li></h4>
                              <h4><li>COVID-19 Cases : <a href='https://github.com/CSSEGISandData/COVID-19' target='_blank'>Github Johns Hopkins University</a></li></h4>
                              <h4><li>State-Wise GDP : <a href='https://apps.bea.gov/itable/drilldown.cfm?reqid=70&stepnum=40&Major_Area=3&State=00000&Area=XX&TableId=532&Statistic=1&Year=-1&YearBegin=-1&Year_End=-1&Unit_Of_Measure=Levels&Rank=0&Drill=1' target='_blank'>BEA.gov</a></li></h4>
                              <h4><li>State-Wise Personal Income : <a href='https://apps.bea.gov/itable/drilldown.cfm?reqid=70&stepnum=40&Major_Area=3&State=00000&Area=XX&TableId=56&Statistic=10&Year=-1&YearBegin=-1&Year_End=-1&Unit_Of_Measure=Levels&Rank=0&Drill=1' target='_blank'>BEA.gov</a></li></h4>
                              <h4><li>Vaccination : <a href='https://www.beckershospitalreview.com/public-health/states-ranked-by-percentage-of-covid-19-vaccines-administered.html' target='_blank'>Beckershospitalreview</a></li></h4>
                              <h4><li>Variants : <a href='https://www.cdc.gov/coronavirus/2019-ncov/transmission/variant-cases.html' target='_blank'>CDC.gov</a></li></h4>
                              <h4><li>Data Using in Our Model: <a href='https://github.com/TZstatsADS/Spring2021-Project2-group1/tree/master/data/cleaned_model_data' target='_blank'>Github Project Data Folder</a></li></h4>
                              <h4><li>Spatial Polygons : <a href='https://www.naturalearthdata.com/downloads/' target='_blank'> Natural Earth</a></li></h4>
                              <h4><li>Our Methodology : <a href='https://docs.google.com/document/d/1VLP7hmsPS2AeVN4g0i98FTbXuvfSXi9kY5bHQ-PdZj4/edit?usp=sharing' target='_blank'> Google Doc</a></li></h4>
                    <p>&nbsp;</p>
                    <p>&nbsp;</p>
                    <h1>About Us</h1>
                    <p>This COVID-19 US States Ranking App is presented by Jingbin Cao, Weiwei Song, Yutong Yang, and Renyin Zhang.&nbsp;</p>
                    <p>&nbsp;</p>
                    <p>&nbsp;</p>"
                     ################### Your HTML Code Ends Here ##################
                   ))
                          
))


