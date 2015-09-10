source("readDataFunc_sqldf.R")
#read the required data. A separate function takes care of reading
df <- readDataFunc()
par(mfrow = c(1,1))
plot(x = df$DateTime, y = df$Global_active_power, type='l',
     ylab = "Global Active Power (kilowatts)", xlab = "")

dev.copy(png, 'plot2.png', width = 480, height = 480)
dev.off()