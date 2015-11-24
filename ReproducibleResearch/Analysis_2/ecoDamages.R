#Processing event types
library(xtable)
library(dplyr)
setwd("C:/ML_DS/DataScience/ReproducibleResearch/Analysis_2")
storm <- read.csv("repdata_data_StormData.csv", as.is = T)

#We only need event name and the injuries
# we only care about events where life damages do happen
# giving equal importance to fatalities and injuries
# group these values by event types; sum up the damages calculated for an event type
storm_econDamages <- storm %>% 
    select(EVTYPE, PROPDMG, PROPDMGEXP, CROPDMG, CROPDMGEXP) %>%
    filter((as.numeric(PROPDMG) + as.numeric(CROPDMG)) > 0)
    #mutate(allDamage = FATALITIES + INJURIES, EVTYPE = toupper(EVTYPE)) %>%
    #filter(lifeDamages > 0) %>%
#group_by(EVTYPE) #%>%
#summarise(allLifeDamages = sum(lifeDamages)) %>%
#arrange(desc(allLifeDamages))

storm_events <- storm_econDamages %>%
    group_by(toupper(EVTYPE)) %>%
    summarise(cnt = n()) %>%
    arrange(desc(cnt))

eventNames_econ <- unique(toupper(storm_econDamages$EVTYPE))
    
#remove large db from memory
rm(storm)

#making a copy
storm_lifeDamages2 <- storm_lifeDamages
#getting event names for processing
eventNames <- sort(storm_lifeDamages2$EVTYPE)

#get length of one word event types, this will be our Bag Of Words for events
l <- lapply(eventNames, function(x){length(strsplit(x, '[ ./]')[[1]])})
event_BoW <- eventNames[which(l == 1)]
event_BoW <- unique(sapply(event_BoW, function(x) {
    if(substring(x, nchar(x)) %in% c("S", ".")){
        x <- substr(x, 1, nchar(x)-1)
    }
    else
        x <- x}))

# we could do some more NLP magic to find nouns (event types should be valid nouns, right?!?!).
#But since these names reduce to a list of 35 I was able to go through this list

#group of names entered in error, these need to be removed explicitly
stupidNames <- c("AVALANCE", "FLOODING", "HIGH", "THUNDERSTROMW")
event_BoW <- event_BoW[!event_BoW %in% stupidNames]

#another set of names that do not exist and need to be added to the list of events
remainingNames <- c("RAIN", "WINTER", "CURRENT")
event_BoW <- sort(c(event_BoW, remainingNames))

#if the whole word can be found in the event type, replace the name by the single cleaned name
EventName <- apply(storm_lifeDamages2, 1, function(x) {
    
    replacement = event_BoW[which(event_BoW %in% unlist(strsplit(x['EVTYPE'], split="[ ./]")))][1]
    if (is.na(replacement))
        x['EVTYPE']
    
    else
        replacement
})
storm_lifeDamages2$EventName <- EventName
#Now we need to take care of certain event types which are wrongly spelt or something
#we try to match the names to their closest matching true event names
#We are weighing the insertions at a higher cost. This should take care of wrong spellings and extra letters, etc.
d <- adist(storm_lifeDamages2$EventName, event_BoW,  costs=list(insertions=20, deletions=1, substitutions=10), partial = T)

#Find the closest match
minOfRows=apply(d, 1, function(x) which.min(x) )
storm_lifeDamages2$cleanedEventNames <- event_BoW[minOfRows]

storm_lifeDamages3 <- storm_lifeDamages2 %>% 
    select(-(EVTYPE)) %>%
    group_by(cleanedEventNames) %>%
    summarise(allLifeDamages = sum(allLifeDamages)) %>%
    arrange(desc(allLifeDamages))

library(ggplot2)
g <- ggplot(data= storm_lifeDamages3, aes(x = reorder(cleanedEventNames, -allLifeDamages), y=allLifeDamages))
g + geom_bar(stat = "identity") + theme(axis.text.x=element_text(angle = -90, hjust = 0))

