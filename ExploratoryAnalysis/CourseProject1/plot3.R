source("readDataFunc_sqldf.R")
#read the required data. A separate function takes care of reading
df <- readDataFunc()
par(mfrow = c(1,1))
plot(x = df$DateTime, y = df$Sub_metering_1, type='l',
     ylab = "Energy Sub Metering", xlab = "")
lines(x = df$DateTime, y = df$Sub_metering_2, col = 'red')
lines(x = df$DateTime, y = df$Sub_metering_3, col = 'blue')
legend("topright",lty = 1,
       col = c("black","blue", "red"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.copy(png, 'plot3.png', width = 640, height = 480)
dev.off()