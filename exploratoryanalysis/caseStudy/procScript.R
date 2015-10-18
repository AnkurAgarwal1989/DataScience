data_1999 <- read.table("Rd_501_88101_1999//RD_501_88101_1999-0.txt",
                      sep = "|", header = F, comment.char = "#")
data_2012 <- read.table("Rd_501_88101_2012//RD_501_88101_2012-0.txt",
                      sep = "|", header = F, comment.char = "#")
cnames <- readLines("Rd_501_88101_1999//RD_501_88101_1999-0.txt", n = 1)
cnames <- strsplit(cnames, "|", fixed = T)
cnames <- make.names(cnames[[1]])

names(data_1999) <- cnames
names(data_2012) <- cnames
data_1999 <- data_1999[seq(1,13)]
data_2012 <- data_2012[seq(1,13)]

pm_99 <- data_1999$Sample.Value;
pm_12 <- data_2012$Sample.Value;
date_99 <- data_1999$Date;
date_99 <- as.Date(as.character(date_99), "%Y%m%d")
date_12 <- data_2012$Date
date_12 <- as.Date(as.character(date_12), "%Y%m%d")
hist(date_99, "month")
hist(date_12, "month")

par(mfrow=c(1,1))
boxplot(pm_99, pm_12, names = c("1999", "2012"))
par(mfrow=c(1,1))
boxplot(log10(pm_99), log10(pm_12),  names = c("1999", "2012"))

# we want to focus on a state
#36 is new york. lets stick to that 
#find one monitor which exists in both years and has high enough readings
sub_99 <- unique(subset(data_1999, State.Code == 36, select = c(County.Code, Site.ID)))
sub_99$sensor = paste(sub_99$County.Code, sub_99$Site.ID, sep=".")

sub_12 <- unique(subset(data_2012, State.Code == 36, select = c(County.Code, Site.ID)))
sub_12$sensor = paste(sub_12$County.Code, sub_12$Site.ID, sep=".")

both <- intersect(sub_99$sensor, sub_12$sensor)

data_1999$county.site <- with(data_1999, paste(County.Code, Site.ID, sep = "."))
data_2012$county.site <- with(data_2012, paste(County.Code, Site.ID, sep = ".")) 

pm_99 <- subset(data_1999, State.Code == 36 & county.site %in% both)
pm_12 <- subset(data_2012, State.Code == 36 & county.site %in% both)

sort(pm_99$county.site)
sort(pm_12$county.site)
sort(xtabs(~pm_99$county.site))
sort(xtabs(~pm_12$county.site))
prop.table(xtabs(~pm_99$county.site))*100
prop.table(xtabs(~pm_12$county.site))*100

#lets choose 5.8 as that has almost equal number of readings
#or 63.2008
sort(abs(prop.table(xtabs(~pm_12$county.site))*100 - prop.table(xtabs(~pm_99$county.site))*100))

