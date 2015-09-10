source("readDataFunc_sqldf.R")
#read the required data. A separate function takes care of reading
df <- readDataFunc()
par(mfrow = c(1,1))
hist(df$Global_active_power, col='red', 
     main = "Global Active Power", xlab = 'Global Active Power (kilowatts)')
dev.copy(png, 'plot1.png', width = 640, height = 480)
dev.off()