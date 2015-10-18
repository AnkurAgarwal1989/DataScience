library(dplyr)
library(ggplot2)
library(lubridate)
activity <- read.csv("activity/activity.csv", as.is = T)

activity_byDay <- activity %>% group_by(date) %>% 
    summarise(totalSteps = sum(steps, na.rm=T), 
              meanSteps = floor(mean(steps, na.rm=T)),
              medianSteps = median(steps, na.rm=T))

activity_byTime <- activity %>% group_by(interval) %>% 
    summarise(totalSteps = sum(steps, na.rm=T), 
              meanSteps = floor(mean(steps, na.rm=T)),
              medianSteps = median(steps, na.rm=T))

hist(activity_byDay$totalSteps, breaks = 10)

qplot(y = activity_byTime$meanSteps, x =activity_byTime$interval, geom = "line" )
timePeriod_MaxSteps <- which.max(activity_byTime$meanSteps)
strftime(Sys.Date() + 
             hm(paste("0:", activity_byTime$interval[timePeriod_MaxSteps], sep = "")), format="%H:%M:%S")

#Dealing with NAs
#number of rows with missing data
sum(!complete.cases(activity))

#imputing
activity2 <- activity %>% group_by(interval) %>% 
    mutate(meanSteps = floor(mean(steps, na.rm=T)))

activity2$steps[is.na(activity2$steps)] <- activity2$meanSteps[is.na(activity2$steps)]
activity2_byDay <- activity2 %>% group_by(date) %>%
    summarise(totalSteps = sum(steps))
hist(activity2_byDay$totalSteps)


#separate weekday/ weekend
library(chron)
activity_byWday <- activity2
activity_byWday$w <- as.factor(is.weekend(as.Date(activity_byWday$date)))
levels(activity_byWday$w) <- c("wday", "wend")
activity_byWdaymean <- activity_byWday %>% 
    group_by(w, interval) %>% 
    summarise(meanSteps = ceiling(mean(steps)))
