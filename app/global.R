#--------------------------------------------------------------------
###############################Install Related Packages #######################
if (!require("data.table")) {
  install.packages("data.table")
  library(data.table)
}
if (!require("reshape2")) {
  install.packages("reshape2")
  library(reshape2)
}

if (!require("dplyr")) {
  install.packages("dplyr")
  library(dplyr)
}
if (!require("tibble")) {
  install.packages("tibble")
  library(tibble)
}
if (!require("tidyverse")) {
  install.packages("tidyverse")
  library(tidyverse)
}
if (!require("shinythemes")) {
  install.packages("shinythemes")
  library(shinythemes)
}

if (!require("sf")) {
  install.packages("sf")
  library(sf)
}
if (!require("RCurl")) {
  install.packages("RCurl")
  library(RCurl)
}
if (!require("tmap")) {
  install.packages("tmap")
  library(tmap)
}
if (!require("rgdal")) {
  install.packages("rgdal")
  library(rgdal)
}
if (!require("leaflet")) {
  install.packages("leaflet")
  library(leaflet)
}
if (!require("shiny")) {
  install.packages("shiny")
  library(shiny)
}
if (!require("shinythemes")) {
  install.packages("shinythemes")
  library(shinythemes)
}
if (!require("plotly")) {
  install.packages("plotly")
  library(plotly)
}
if (!require("ggplot2")) {
  install.packages("ggplot2")
  library(ggplot2)
}
if (!require("viridis")) {
  install.packages("viridis")
  library(viridis)
}
if (!require("rvest")) {
  install.packages("rvest")
  library(rvest)
}
if (!require("robotstxt")) {
  install.packages("robotstxt")
  library(robotstxt)
}
if (!require("stringr")) {
  install.packages("stringr")
  library(stringr)
}
if (!require("ggdark")) {
  install.packages("ggdark")
  library(ggdark)
}
if (!require("DT")) {
  install.packages("DT")
  library(DT)
}
if (!require("openair")) {
  install.packages("openair")
  library(openair)
}
if (!require("readr")) {
  install.packages("readr")
  library(readr)
}
if (!require("ggthemes")) {
  install.packages("ggthemes")
  library(ggthemes)
}
if (!require("gganimate")) {
  install.packages("gganimate")
  library(gganimate)
}
if (!require("geosphere")) {
  install.packages("geosphere")
  library(geosphere)
}
if (!require("scales")) {
  install.packages("scales")
  library(scales)
}
if (!require("shinyWidgets")) {
  install.packages("shinyWidgets")
  library(shinyWidgets)
}
if (!require("viridisLite")) {
  install.packages("viridisLite")
  library(viridisLite)
}
if (!require("maps")) {
  install.packages("maps")
  library(maps)
}
if (!require("htmltools")) {
  install.packages("htmltools")
  library(htmltools)
}
if (!require("RColorBrewer")) {
  install.packages("RColorBrewer")
  library(RColorBrewer)
}
if (!require("shinydashboard")) {
  install.packages("shinydashboard")
  library(shinydashboard)
}
if (!require("leaflet.extras")) {
  install.packages("leaflet.extras")
  library(leaflet.extras)
}
if (!require("highcharter")) {
  install.packages("highcharter")
  library(highcharter)
}
if (!require("zoo")) {
  install.packages("zoo")
  library(zoo)
}
if (!require("lubridate")) {
  install.packages("lubridate")
  library(lubridate)
}
if (!require("plotly")) {
  install.packages("plotly")
  library(plotly)
}
if (!require("dichromat")) {
  install.packages("dichromat")
  library(dichromat)
}
if (!require("htmltools")) {
  install.packages("htmltools")
  library(htmltools)
}
if (!require("reactable")) {
  install.packages("reactable")
  library(reactable)
}

#--------------------------------------------------------------------
###############################Define Functions#######################
data_cooker_variants <- function(df){
  #input dataframe and change the Country/Region column into standard format
  df$State[df$State == "AL"] <- "Alabama"
  df$State[df$State == "AK"] <- "Alaska"
  df$State[df$State == "AS"] <- "American Samoa"
  df$State[df$State == "AZ"] <- "Arizona"
  df$State[df$State == "AR"] <- "Arkansas"
  df$State[df$State == "CA"] <- "California"
  df$State[df$State == "CO"] <- "Colorado"
  df$State[df$State == "CT"] <- "Connecticut"
  df$State[df$State == "DE"] <- "Delaware"
  df$State[df$State == "FL"] <- "Florida"
  df$State[df$State == "GA"] <- "Georgia"
  df$State[df$State == "GU"] <- "Guam"
  df$State[df$State == "HI"] <- "Hawaii"
  df$State[df$State == "ID"] <- "Idaho"
  df$State[df$State == "IL"] <- "Illinois"
  df$State[df$State == "IN"] <- "Indiana"
  df$State[df$State == "IA"] <- "Iowa"
  df$State[df$State == "KS"] <- "Kansas"
  df$State[df$State == "KY"] <- "Kentucky"
  df$State[df$State == "LA"] <- "Louisiana"
  df$State[df$State == "ME"] <- "Maine"
  df$State[df$State == "MH"] <- "Marshall Islands"
  df$State[df$State == "MD"] <- "Maryland"
  df$State[df$State == "MA"] <- "Massachusetts"
  df$State[df$State == "MI"] <- "Michigan"
  df$State[df$State == "FM"] <- "Micronesia"
  df$State[df$State == "MN"] <- "Minnesota"
  df$State[df$State == "MS"] <- "Mississippi"
  df$State[df$State == "MO"] <- "Missouri"
  df$State[df$State == "MT"] <- "Montana"
  df$State[df$State == "NE"] <- "Nebraska"
  df$State[df$State == "NV"] <- "Nevada"
  df$State[df$State == "NH"] <- "New Hampshire"
  df$State[df$State == "NJ"] <- "Neo Jersey"
  df$State[df$State == "NM"] <- "New Mexico"
  df$State[df$State == "NY"] <- "New York"
  df$State[df$State == "NC"] <- "North Carolina"
  df$State[df$State == "ND"] <- "North Dakota"
  df$State[df$State == "MP"] <- "Northern Marianas"
  df$State[df$State == "OH"] <- "Ohio"
  df$State[df$State == "OK"] <- "Oklahoma"
  df$State[df$State == "OR"] <- "Oregon"
  df$State[df$State == "PW"] <- "Palau"
  df$State[df$State == "PA"] <- "Pennsylvania"
  df$State[df$State == "PR"] <- "Puerto Rico"
  df$State[df$State == "RI"] <- "Rhode Island"
  df$State[df$State == "SC"] <- "South Carolina"
  df$State[df$State == "SD"] <- "South Dakota"
  df$State[df$State == "TN"] <- "Tennessee"
  df$State[df$State == "TX"] <- "Texas"
  df$State[df$State == "UT"] <- "Utah"
  df$State[df$State == "VT"] <- "Vermont"
  df$State[df$State == "VI"] <- "Virgin Islands"
  df$State[df$State == "VA"] <- "Washington"
  df$State[df$State == "WA"] <- "West Virginia"
  df$State[df$State == "WV"] <- "West Virginia"
  df$State[df$State == "WI"] <- "Wisconsin"
  df$State[df$State == "WY"] <- "Wyoming"
  return(df)
}

data_transformer_variants <- function(df) {
  df <- data_cooker_variants(df)
  not_select_cols <- c("Range")
  aggre_df <- df %>% select(-one_of(not_select_cols)) 
  return(aggre_df)
}


data_transformer_GDP <- function(df) {
  not_select_cols <- c("GeoFips")
  #aggregate the province into country level
  aggre_df <- df %>% select(-one_of(not_select_cols)) 
  return(aggre_df)
}

data_transformer_income <- function(df) {
  not_select_cols <- c("GeoFips")
  #aggregate the province into country level
  aggre_df <- df %>% select(-one_of(not_select_cols)) 
  return(aggre_df)
}

data_transformer_variant <- function(df) {
  df <- data_cooker_variants(df)
  not_select_cols <- c("Range")
  aggre_df <- df %>% select(-one_of(not_select_cols)) 
  return(aggre_df)
}

data_transformer_case <- function(df) {
  #################################################################
  ##Given dataframe tranform the dataframe into aggregate level with
  ##rownames equal to countries name, and colnames equals date
  #################################################################
  #clean the country/regionnames
  #  df <- data_cooker(df)
  #columns that don't need 
  not_select_cols <- c("UID","iso2","iso3","code3","FIPS","Admin2","Country_Region","Combined_Key","Lat","Long_")
  #aggregate the province into country level
  aggre_df <- df %>% group_by(Province_State) %>% 
    select(-one_of(not_select_cols)) %>% summarise_all(sum)
  #assign the country name into row names 
  aggre_df <- aggre_df %>% remove_rownames %>% 
    tibble::column_to_rownames(var="Province_State")
  #change the colume name into date format
  date_name <- colnames(aggre_df)
  #change e.g: "x1.22.20" -> "2020-01-22"
  date_choices <- as.Date(date_name,format = 'X%m.%d.%y')
  #assign column nam
  colnames(aggre_df) <- date_choices
  return(aggre_df)
}

data_transformer_death <- function(df) {
  #################################################################
  ##Given dataframe tranform the dataframe into aggregate level with
  ##rownames equal to countries name, and colnames equals date
  #################################################################
  #clean the country/regionnames
  #  df <- data_cooker(df)
  #columns that don't need 
  not_select_cols <- c("UID","iso2","iso3","code3","FIPS","Admin2","Country_Region","Combined_Key","Population", "Lat","Long_")
  #aggregate the province into country level
  aggre_df <- df %>% group_by(Province_State) %>% 
    select(-one_of(not_select_cols)) %>% summarise_all(sum)
  #assign the country name into row names 
  aggre_df <- aggre_df %>% remove_rownames %>% 
    tibble::column_to_rownames(var="Province_State")
  #change the colume name into date format
  date_name <- colnames(aggre_df)
  #change e.g: "x1.22.20" -> "2020-01-22"
  date_choices <- as.Date(date_name,format = 'X%m.%d.%y')
  #assign column nam
  colnames(aggre_df) <- date_choices
  return(aggre_df)
}
#--------------------------------------------------------------------
###############################Data Preparation#######################
#Data Sources
"Dong E, Du H, Gardner L. An interactive web-based dashboard to track COVID-19 in real time. 
Lancet Inf Dis. 20(5):533-534. doi: 10.1016/S1473-3099(20)30120-1"

###### Time Series Data ##########
# get the time series U.S. cases data from API
Cases_Time_URL <- "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_US.csv"
us_cases <- read.csv(Cases_Time_URL)

# get the time series U.S. death data from API
Death_Time_URL <- "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_deaths_US.csv"
us_death <- read.csv(Death_Time_URL)

############ One Time Data ############
# get variants data
variants <- read.csv("./data/raw_map_data/variant_data.csv")
variants <- variants[-c(175,176,177,178,179,180,181,182,183,184),]

# get GDP data
GDP <- read.csv("./data/raw_map_data/GDP_data.csv")

# get personal income data
income <- read.csv("./data/raw_map_data/personal_income_data.csv")

# get vaccination data
#get the updated vaccination data by states
web_scrape <- read_html("https://www.beckershospitalreview.com/public-health/states-ranked-by-percentage-of-covid-19-vaccines-administered.html")
write_html(web_scrape, "./output/Vaccination_Rates.html")
VR <- read_html("./output/Vaccination_Rates.html")
State <- VR %>% html_nodes("ol") %>% html_nodes("li") %>% html_nodes("strong") %>% html_text()
state_data = VR %>% html_nodes("ol") %>% html_nodes("li") %>% html_text()
Distributed = rep(NA,50)
Administered = rep(NA,50)
Percentage = rep(NA,50)
for (i in 1:length(State)){
  split_data <- str_split(state_data[[i]],":")
  Distributed[i] = parse_number(split_data[[1]][2])
  Administered[i] = parse_number(split_data[[1]][3])
  Percentage[i] = parse_number(split_data[[1]][4])
}
vaccine_data = data.frame(cbind(State,Distributed,Administered,Percentage))


# get aggregate cases 
aggre_cases <- as.data.frame(data_transformer_case(us_cases))
# get aggregate death
aggre_death <- as.data.frame(data_transformer_death(us_death))
# get aggregate GDP
aggre_GDP <- as.data.frame(data_transformer_GDP(GDP))

# get aggregate variants
aggre_variants <- as.data.frame(data_transformer_variants(variants))

# get aggregate personal income
aggre_income <- as.data.frame(data_transformer_income(income))

#define date_choices 
date_choices <- as.Date(colnames(aggre_cases),format = '%Y-%m-%d')
#define state_names
state_names_choices <- rownames(aggre_cases)

#Download the spatial polygons dataframe in this link
# https://www.naturalearthdata.com/downloads/50m-cultural-vectors/50m-admin-0-countries-2/

output_shapefile_filepath <- "./output/states_shapeFile.RData"

#if already has countries_shapeFile.RData under output folder, no need to process it again
#otherwise, read files from data folder to create countries_shapeFile.RData under output folder
if(file.exists(output_shapefile_filepath)){
  load(output_shapefile_filepath)
}else{
  states <- readOGR(dsn ="./data/ne_10m_admin_1_states_provinces",
                    layer = "ne_10m_admin_1_states_provinces",
                    encoding = "utf-8",use_iconv = T,
                    verbose = FALSE)
  save(states, file=output_shapefile_filepath)
}
################################################
######## Draw Map function Bigins ############
################################################
draw_map = function(df, indicator){
  mapusa = maps::map("state", fill = TRUE, plot = FALSE)
  
  Names = tibble(State = mapusa$names) %>%
    group_by(State) %>% mutate(Name = strsplit(State,':')[[1]][1])
  
  df = df %>%
    right_join(Names, by = c('Province_State' = 'Name'))
  
  state = c(unlist(df['Province_State']))
  values <- c(unlist(df['Value']))
  
  
  if(indicator %in% colnames(data)[c(11,14,18)])
    labels = sprintf("%s<br/>%s:%g%%", str_to_upper(state), indicator, signif(values,4))
  else
    labels = sprintf("%s<br/>%s:%g", str_to_upper(state), indicator, signif(values,4))
  labels = labels %>%
    lapply(htmltools::HTML)
  pal <- colorBin("YlOrRd", domain = values, bins = 9)
  
  print(labels)
  
  leaflet(data = mapusa) %>% 
    setView(-96, 37.8, 5) %>%
    addTiles() %>%
    addResetMapButton() %>% 
    addPolygons(
      fillColor = pal(values),
      weight = 2, 
      opacity = 1, 
      color='white',
      dashArray = 3,
      fillOpacity = .7,
      highlight = highlightOptions(
        weight = 5,
        color = "#666",
        dashArray = "",
        fillOpacity = .75,
        bringToFront = T
      ),
      label = labels,
      labelOptions = labelOptions(
        style = list("font-weight" = "normal", 'padding' = "10px 15px"),
        textsize = "15px",
        direction = "auto")
    ) %>%  
    addLegend(pal = pal,
              values = values,
              opacity = 0.85,
              title = NULL,
              position = "bottomright")
}
################# Draw Map function Ends #################
# Reference of Group 5, Fall 2020


#make a copy of aggre_cases dataframe
aggre_cases_copy <- as.data.frame(aggre_cases)
aggre_cases_copy$state_names <- as.character(rownames(aggre_cases_copy))

#make a copy of aggre_death dataframe
aggre_death_copy <- as.data.frame(aggre_death)
aggre_death_copy$state_names <- as.character(rownames(aggre_death_copy))

aggre_GDP_copy <- as.data.frame(aggre_GDP)
aggre_income_copy <- as.data.frame(aggre_income)
aggre_variants_copy <- as.data.frame(aggre_variants)
aggre_vaccine <- as.data.frame(vaccine_data)
aggre_vaccine_copy <- as.data.frame(aggre_vaccine)

model_data <- read.csv("./output/cleaned_model_data/final_model_table.csv")
model_data_copy <- as.data.frame(model_data)
aggre_vaccine_use <- aggre_vaccine_copy[,c(1,4)]
aggre_GDP_use <- aggre_GDP_copy[2:60,c(1,64)]
names(aggre_GDP_use) <- c("State","GDP")
names(aggre_vaccine_use) <- c("State", "Vaccine_Percentage")
aggre_income_use <- aggre_income_copy[2:60,c(1,292)]
names(aggre_income_use) <- c("State","Personal_Income")
aggre_variants_use <- aggregate(data = aggre_variants_copy, Cases ~ State, sum)
names(aggre_variants_use) <- c("State", "Variants_Cases")

##### MERGE MAP DATA ! ########
map_data <- merge(x = model_data_copy, y = aggre_GDP_use, by = "State")
map_data <- merge(x= map_data, y = aggre_vaccine_use, by = "State")
map_data <- merge(map_data, aggre_variants_use,by = "State")
map_data <- merge(map_data, aggre_income_use,by = "State")


####### Table Function ###########
model_data <- read.csv("./output/cleaned_model_data/final_model_table.csv")
model_data_copy <- as.data.frame(model_data)
rank_data <- model_data
covid_cols<-c("One_Month_Cases","One_month_fatality_rate","Total_Deaths","Positive_Test_Rate")
human_cols<-c("lockdown_severity","Mobility","Gross_State_Product","Rank_health","HDI")
vul_cols<-c("assess_to_vaccines_per_hundred",
            "doses_per_hundred",
            "HospitalBeds",
            "respiratory_mortality_rate",
            "respiratory_infections_rate",
            "obesity_prevalence")

rank_data<-rank_data[,c("Rank","State","Score",covid_cols,vul_cols,human_cols)]

covid_column <- function(maxWidth = 80, class = paste("cell number", class), ...) {
  colDef(maxWidth = maxWidth, align = "center", ...)
}

vul_column <- function(maxWidth = 80, class = "cell",...) {
  colDef(maxWidth = maxWidth, align = "center", ...)
}

human_column <- function(maxWidth = 80, class = "cell",...) {
  colDef(maxWidth = maxWidth, align = "center", ...)
}

format_pct <- function(value) {
  if (value == 0) "  \u2013 "    # en dash for 0%
  else if (value == 1) "\u2713"  # checkmark for 100%
  else if (value < 0.01) " <1%"
  else if (value > 0.99) ">99%"
  else formatC(paste0(round(value * 100), "%"), width = 4)
}

make_color_pal <- function(colors, bias = 1) {
  get_color <- colorRamp(colors, bias = bias)
  function(x) rgb(get_color(x), maxColorValue = 255)
}

good_color <- make_color_pal(colorschemes$BluetoOrange.12, bias = 2)

sticky_style <- list(position = "sticky", left = 0, background = "#fff", zIndex = 1,
                     borderRight = "1px solid #eee")
bar_chart <- function(label, width = "100%", height = "14px", fill = "#00bfc4", background = NULL) {
  bar <- div(style = list(background = fill, width = width, height = height))
  chart <- div(style = list(flexGrow = 1, marginLeft = "6px", background = background), bar)
  div(style = list(display = "flex", alignItems = "center"), label, chart)
}


data<-model_data
data1<- data[,c("State",covid_cols)]
data2<-data[,c("State",vul_cols)]
data3<-data[,c("State",human_cols)]

### Table Function Ends #########

###### Analysis Data Cleaning Starts #####

### data clean for statistical graphs ####
Mobility1<-read_csv("./data/graphical_data/2020_US_Region_Mobility_Report.csv")
Mobility2<-read_csv("./data/graphical_data/applemobilitytrends-2021-02-15.csv")

covid_confirmed<-read_csv("./data/graphical_data/time_series_covid19_confirmed_US.csv")%>%
  rename(State=Province_State)%>%
  select(State,`1/22/20`:`2/15/21`)%>%
  gather(key="Date",value="confirmed_number",-State)%>%

  group_by(State,Date)%>%
  summarise(total_confirmed = sum(confirmed_number))

covid_death<-read_csv("./data/graphical_data/time_series_covid19_deaths_US.csv")%>%
  rename(State=Province_State)%>%
  select(State,Population,`1/22/20`:`2/15/21`)%>%
  gather(key="Date",value="death",-Population,-State)%>%

  group_by(State,Date)%>%
  summarise(total_confirmed = sum(death))



vaccine<-read_csv("./data/graphical_data/us_state_vaccinations.csv")%>%
  rename(State=location,Date=date)%>%
  drop_na()

Mobility_place<-Mobility1%>%
  transmute(State = sub_region_1,Date=date,
            retail_and_recreation_percent_change_from_baseline,
            grocery_and_pharmacy_percent_change_from_baseline,
            parks_percent_change_from_baseline,
            transit_stations_percent_change_from_baseline,
            workplaces_percent_change_from_baseline,
            residential_percent_change_from_baseline)%>%
  drop_na()%>%
  group_by(State,Date)%>%
  summarise_all(mean)

Mobility_tans_type<-Mobility2%>%
  filter(country=="United States")%>%
  select(-geo_type,-region,-country,-alternative_name)%>%
  rename(State=`sub-region`)%>%
  drop_na()
mobdata<-melt(Mobility_tans_type,id.vars=c("State","transportation_type"),
              variable.name="Date",value.name="change")
New_Mobility_trans_type<-dcast(mobdata, State+Date ~ transportation_type, mean,
                               value.var="change", drop=TRUE)%>%
  mutate(transit_change_from_baseline = (transit-100),
         walking_change_from_baseline = (walking-100))%>%
  select(-transit,-walking)%>%
  drop_na()
New_Mobility_trans_type$Date<-as.Date(New_Mobility_trans_type$Date)

##### merging mobility
Mobility_all<-Mobility_place%>%
  left_join(New_Mobility_trans_type, by=c("State","Date"))%>%
  drop_na()


##### merging all data of states for plotting
### unifying the date
vaccine$Date<-as.Date(vaccine$Date)
covid_confirmed$Date<-strptime(covid_confirmed$Date,'%m/%d/%y')
covid_death$Date<-strptime(covid_death$Date,'%m/%d/%y')
covid_confirmed$Date<-as.Date(covid_confirmed$Date)
covid_death$Date<-as.Date(covid_death$Date)
Mobility_all$Date<-as.Date(Mobility_all$Date)
# Severity$Date<-strptime(Severity$Date,'%Y%m%d')
# Severity$Date<-as.Date(Severity$Date)

### joining all
states_complete<-covid_confirmed%>%
  left_join(covid_death, by=c("State","Date"))%>%
  left_join(vaccine, by=c("State","Date"))%>%
  left_join(Mobility_all, by=c("State","Date"))#%>%
  # left_join(Severity, by=c("State","Date"))%>%
  #filter("Date" >='2021-01-13')

binning<- function(x) {10^(ceiling(log10(x)))}

#use save.image() at any time to save all environment data into an .RData file
save.image(file='./output/covid-19.RData')

