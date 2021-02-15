#--------------------------------------------------------------------
###############################Install Related Packages #######################
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
  
data_transformer_variant

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
variants <- read.csv("../data/raw_map_data/variant_data.csv")
variants <- variants[-c(175,176,177,178,179,180,181,182,183,184),]

# get GDP data
GDP <- read.csv("../data/raw_map_data/GDP_data.csv")

# get personal income data
income <- read.csv("../data/raw_map_data/personal_income_data.csv")

# get vaccination data
#get the updated vaccination data by states
web_scrape <- read_html("https://www.beckershospitalreview.com/public-health/states-ranked-by-percentage-of-covid-19-vaccines-administered.html")
write_html(web_scrape, "../data/raw_map_data/Vaccination_Rates.html")
VR <- read_html('../data/raw_map_data/Vaccination_Rates.html')
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
  states <- readOGR(dsn ="../data/ne_10m_admin_1_states_provinces",
                       layer = "ne_10m_admin_1_states_provinces",
                       encoding = "utf-8",use_iconv = T,
                       verbose = FALSE)
  save(states, file=output_shapefile_filepath)
}


#make a copy of aggre_cases dataframe
aggre_cases_copy <- as.data.frame(aggre_cases)
aggre_cases_copy$state_names <- as.character(rownames(aggre_cases_copy))

#make a copy of aggre_death dataframe
aggre_death_copy <- as.data.frame(aggre_death)
aggre_death_copy$state_names <- as.character(rownames(aggre_death_copy))

binning<- function(x) {10^(ceiling(log10(x)))}

#use save.image() at any time to save all environment data into an .RData file
save.image(file='./output/covid-19.RData')
