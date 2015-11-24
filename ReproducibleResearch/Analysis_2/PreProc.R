library(dplyr)
storm <- read.csv("repdata_data_StormData.csv", as.is = T)
#create a bag of words of the event types
#The event names are inconsistent (with some spelling mistakes to add to the fun), 
#we need to devise a strategy to identify correct event names.
#we can create a table of the occurances of unique event names in the DB. This results in ~400 event names.

#we can create a bag of words of event names from this list of events. 
#To start with, we choose only single words After giving the event names a thorough look, we can use single word names for events  

storm_lifeDamages <- storm %>% 
    select(EVTYPE, FATALITIES, INJURIES) %>%
    mutate(lifeDamages = FATALITIES + INJURIES) %>%
    group_by(EVTYPE) %>%
    summarise(allLifeDamages = sum(lifeDamages)) %>%
    arrange(desc(allLifeDamages))

storm_lifeDamages2 <- storm_lifeDamages[storm_lifeDamages$allLifeDamages > 0, ]


storm_propDamages <- storm %>% 
    select(EVTYPE, PROPDMG, PROPDMGEXP, CROPDMG, CROPDMGEXP)

storm_propDamages2 <- storm_propDamages
rm(storm)

storm_propDamages <- storm_propDamages2
dmgSymbol <- unique(tolower(c(storm_propDamages$PROPDMGEXP, storm_propDamages$CROPDMGEXP)))
dmgSymbol <- dmgSymbol[!dmgSymbol %in% c(0:9)]
dmgValue <- c(3, 6, 1, 9, 1, 1, 3, 1)

storm_damages$PROPDMGEXP <- storm_damages$PROPDMGEXP2
storm_damages$CROPDMGEXP <- storm_damages$CROPDMGEXP2
subInData <- function(x){
    #print(dmgSymbol[x])
    #print(dmgValue[x])
    #storm_damages$PROPDMGEXP <<- as.numeric(gsub(dmgSymbol[x], as.numeric(dmgValue[x]), storm_damages$PROPDMGEXP, ignore.case = T)); 
    #storm_damages$CROPDMGEXP <<- as.numeric(gsub(dmgSymbol[x], as.numeric(dmgValue[x]), storm_damages$CROPDMGEXP, ignore.case = T)); 
    storm_damages$PROPDMGEXP[tolower(storm_damages$PROPDMGEXP) == dmgSymbol[x]] <<- as.numeric(dmgValue[x])
    storm_damages$CROPDMGEXP[tolower(storm_damages$CROPDMGEXP) == dmgSymbol[x]] <<- as.numeric(dmgValue[x])
}

for (i in c(1:length(dmgSymbol))){
    subInData(i)
}

storm_damages$PROPDMGEXP <- as.factor(storm_damages$PROPDMGEXP)

damages <- storm_propDamages2 %>% filter(CROPDMGEXP %in% c(0:9) | PROPDMGEXP %in% c(0:9))
