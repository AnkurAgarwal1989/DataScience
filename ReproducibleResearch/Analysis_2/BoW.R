library(dplyr)
storm <- read.csv("repdata_data_StormData.csv.bz2", as.is = T)
#create a bag of words of the event types
#The event names are inconsistent (with some spelling mistakes to add to the fun), 
#we need to devise a strategy to identify correct event names.
#we can create a table of the occurances of unique event names in the DB. This results in ~400 event names.

#we can create a bag of words of event names from this list of events. 
#To start with, we choose only single words After giving the event names a thorough look, we can use single word names for events  

storm_damages <- storm %>% 
    select(EVTYPE, FATALITIES, INJURIES, PROPDMG, PROPDMGEXP, CROPDMG, CROPDMGEXP) %>%
    filter((as.numeric(FATALITIES) + as.numeric(INJURIES) + as.numeric(PROPDMG) +
               as.numeric(CROPDMG)) > 0)

#rm(storm)

#Make all names uppercase
storm_damages$EVTYPE <- toupper(storm_damages$EVTYPE)
#find all unique entries
eventNames <- unique(storm_damages$EVTYPE)

#To start with, get all event names with 1 word names
#get length of one word event types, this will be our Bag Of Words for events
l <- lapply(eventNames, function(x){length(strsplit(x, '[ -?./\\]')[[1]])})
event_BoW <- eventNames[which(l == 1)]
#There are names with plurals and . in the end. Remove the extra characters
event_BoW <- unique(sapply(event_BoW, function(x) {
    if(substring(x, nchar(x)) %in% c("S", ".", "?", "-")){
        x <- substr(x, 1, nchar(x)-1)
    }
    else
        x <- x}))
#Removing entries with 0 length
event_BoW <- sort(event_BoW[nchar(event_BoW) > 0])

#group of names entered in error, these need to be removed explicitly
namesForRemoval <- c("AVALANCE", "FLOODING", "GUSTNADO", "HAILSTORM", "HIGH", 
                  "LIGHTING", "LIGNTNING", "RAINSTORM",  
                 "THUNDERSNOW", "THUNDERSTORMW", "THUNDERSTORMWIND", "TORNADOE",
                 "TORNDAO", "TSTMW" )
event_BoW <- event_BoW[!event_BoW %in% namesForRemoval]

#another set of names that do not exist and need to be added to the list of events
namesToAdd <- c("WINTER", "CURRENT")
event_BoW <- sort(c(event_BoW, namesToAdd))
event_BoW

#Replace TSTM by THUNDERSTORM
storm_damages$EVTYPE <- gsub("TSTM", "THUNDERSTORM", storm_damages$EVTYPE)
#Rename EVTYPE to the Bag of Words
d <- adist(storm_damages$EVTYPE, event_BoW,  costs=list(insertions=20, deletions=1, substitutions=10), partial = F)

#Find the closest match
minOfRows=apply(d, 1, function(x) which.min(x) )
storm_damages$cleanedEVTYPE <- event_BoW[minOfRows]


