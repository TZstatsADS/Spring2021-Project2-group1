setwd("~/Desktop/clean")


##### mobility
mobi<-read.csv("mobi_csv.csv")
library(dplyr)

mobi2<-
  mobi%>%mutate(sum_mobility=retail_and_recreation_percent_change_from_baseline+
                  grocery_and_pharmacy_percent_change_from_baseline+
                  parks_percent_change_from_baseline+
                  transit_stations_percent_change_from_baseline+
                  workplaces_percent_change_from_baseline+
                  residential_percent_change_from_baseline
                  ) %>%select(sub_region_1,sum_mobility)
mobi2<-na.omit(mobi2)
# typeof(mobi2$sum_mobility)
# mobi2$sum_mobility<-as.numeric(mobi2$sum_mobility)

bystate<- mobi2%>%group_by(sub_region_1)%>%summarise(avg=mean(sum_mobility))
bystate<-rename(bystate, c(Mobility=avg))
bystate<-rename(bystate, c(State=sub_region_1))
bystate<-bystate%>%select(State,Mobility)
write.csv(bystate,file = "mobility_bystate.csv")

##### hos beds
bed<-read.csv("hospital_beds_USA_v1.csv")
bed2<-bed%>%group_by(state)%>%summarise(avg=mean(beds))
bed2<-as.data.frame(bed2)
bed2<-rename(bed2, c(HospitalBeds=avg))

bed2%>%select(state, HospitalBeds)
write.csv(bed2, file = "bed_bystate.csv")

##### vaccines
vacper100 <- read.csv("us-state-covid-vaccines-per-100.20210212214810444.csv")
vacused <- read.csv("us-share-covid-19-vaccine-doses-used.csv")
vacshare<-read.csv("us-covid-19-share-people-vaccinated.20210212215912385.csv")
total_vac<-read.csv("us-covid-19-total-people-vaccinated.csv")

vac100<-vacper100%>%filter(Date=='2021/2/11')
vacused2<-vacused%>%filter(Date=='2021/2/11')
vacshare2<-vacshare%>%filter(Date=='2021/2/11')
tvac<-total_vac%>%filter(Date=='2021/2/11')
vaccine<-vac100%>%left_join(vacused2,by="Entity")
vaccine<-vaccine%>%left_join(vacshare2,by="Entity")
vaccine<-vaccine%>%left_join(tvac,by="Entity")
vaccine<-vaccine%>%select(Entity, people_vaccinated_per_hundred, total_vaccinations_per_hundred,
                 share_doses_used,people_vaccinated)
vaccine<-rename(vaccine, c(State=Entity))


mdata<-read.csv("indictors_of_model.csv")
mdata1<-mdata%>%left_join(bystate,by="State")
mdata1<-mdata1%>%left_join(vaccine,by="State")

state<-read.csv("state.csv")
bed2<-bed2%>%left_join(state,by='state')
mdata1<-mdata1%>%left_join(bed2,by="State")

##### other data
lock<-read.csv("lockdown_bystate.csv")
lock<-rename(lock, c(State=RegionName))

chron<-read.csv("chronic_respiratory_bystate.csv")
chron<-rename(chron, c(State=Location))


low<-read.csv("lower_respiratory_infections_mortality_rate_bystate.csv")
low<-rename(low, c(State=Location))

fat<-read.csv("obesity_bystate.csv")

mdata1<-mdata1%>%left_join(lock,by="State")
mdata1<-mdata1%>%left_join(chron,by="State")
mdata1<-mdata1%>%left_join(low,by="State")
mdata1<-mdata1%>%left_join(fat,by="State")

write.csv(mdata1,file = "modeldata.csv")
