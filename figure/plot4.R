FLine <- readLines("household_power_consumption.txt")
PatReg <- grep("[12]/2/2007",substr(FLine,1,8))
DataTable <- read.table(text=FLine[PatReg], header = TRUE,sep = ";", col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))


cols = c(3:9)    
DataTable[,cols] = apply(DataTable[,cols], 2, function(x) as.numeric(as.character(x)))
DataTable$DateTime <- strptime(paste(DataTable$Date, DataTable$Time,sep=" "),"%d/%m/%Y %H:%M:%S")

png(filename='plot4.png',width=480,height=480,units='px')
par(mfrow=c(2,2))
plot(DataTable$DateTime,DataTable$Global_active_power,type="s",xlab=" ",ylab="Global Active Power")
plot(DataTable$DateTime,DataTable$Voltage,type="l",xlab = "DateTime", ylab = "Voltage")
with(DataTable,plot(DateTime,Sub_metering_1,type="l",xlab="",ylab = "Energy Sub metering",col="black"))
lines(DataTable$DateTime,DataTable$Sub_metering_2,col="red")
lines(DataTable$DateTime,DataTable$Sub_metering_3,col="blue")
legend("topright",col= c("black","red","blue"),legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty = 1, cex=0.30)
plot(DataTable$DateTime,DataTable$Global_reactive_power,type="s",xlab = "DateTime", ylab = "Global_reactive_power")
dev.off()