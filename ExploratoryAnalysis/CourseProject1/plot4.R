source("readDataFunc_sqldf.R")
#read the required data. A separate function takes care of reading
df <- readDataFunc()
par(mfrow=c(2,2), mar = c(4,4,2,1), oma=c(0,0,0,0))
with(df, {
    #1,1
    plot(x = df$DateTime, y = df$Global_active_power, type='l',
         ylab = "Global Active Power", xlab = "");
    
    #2,1
    plot(x = df$DateTime, y = df$Voltage, type='l',
         ylab = "Voltage", xlab = "")
    title(sub = 'datetime', line = 3)
    
    #1,2
    plot(x = df$DateTime, y = df$Sub_metering_1, type='l',
         ylab = "Energy Sub Metering", xlab = "")
    lines(x = df$DateTime, y = df$Sub_metering_2, col = 'red')
    lines(x = df$DateTime, y = df$Sub_metering_3, col = 'blue');
    legend("topright",lty = 1,
           col = c("black","blue", "red"), 
           bty = 'n',
           cex = 0.8,
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    
    
    #2,2
    plot(x = df$DateTime, y = df$Global_reactive_power, type='l',
         ylab = "Global Reactive Power", xlab = "")
    title(sub = 'datetime', line = 3)
})

dev.copy(png, 'plot4.png', width = 640, height = 480)
dev.off()
