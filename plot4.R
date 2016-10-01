if(!file.exists("./data2")) dir.create("./data2")
urlStr<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(urlStr, destfile = "./data/power_consumption.zip")
unzip("./data/power_consumption.zip", exdir ="./data")
list.files("./data")
powerdf<- read.table("./data/household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?",stringsAsFactors = FALSE,
                 col.names = c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dates<-c("1/2/2007","2/2/2007")
df<- subset(powerdf, Date %in% dates)
df$Time<-strptime(paste(df$Date, df$Time), "%d/%m/%Y %H:%M:%S")
df$Date<- as.Date(df$Date, "%d/%m/%Y")

png(file="./plots/plot4.png", width = 480, height = 480)
par(mfcol=c(2,2))
### First Plot
plot(df$Time, df$Global_active_power,type = "l",xlab="",ylab="Global Active Power")

### Second Plot
plot(df$Time, df$Sub_metering_1,type = "n", xlab = "",
     ylab="Energy Sub Metering")
points(df$Time,df$Sub_metering_1,type = "l",col="black")
points(df$Time,df$Sub_metering_2,type = "l",col="red")
points(df$Time,df$Sub_metering_3,type = "l",col="blue")
legend("topright",cex=0.6,bty="n",col = c("black","red","blue"),lty = c(1,1,1),
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

### Third Plot
plot(df$Time, df$Voltage,type = "l", xlab = "datetime",ylab="Valtage")

### Fourth Plot
plot(df$Time, df$Global_reactive_power,type = "l", xlab = "datetime",ylab="Global_reative_power")
dev.off()
par(mfrow=c(1,1))
