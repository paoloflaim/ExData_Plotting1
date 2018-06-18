unzip("./data/household_power_consumption.zip", exdir ="./data", overwrite = TRUE)
library(sqldf)
df <- read.csv.sql("./data/household_power_consumption.txt", "select * from file where Date = '1/2/2007' or Date = '2/2/2007'", sep=";")
if (file.exists("./data/household_power_consumption.txt")){
        file.remove("./data/household_power_consumption.txt")
}
library(lubridate)
df <- mutate(df, Date = dmy(Date))
df <- mutate(df, Time = hms(Time))
df$DateTime <- df$Date + df$Time

png(file = "plot3.png", width = 480, height = 480)
plot(df$DateTime, df$Sub_metering_1, ylab="Energy sub metering", xlab="", type="n")
lines(df$DateTime, df$Sub_metering_1, type = "l", col="black")
lines(df$DateTime, df$Sub_metering_2, type = "l", col="red")
lines(df$DateTime, df$Sub_metering_3, type = "l", col="blue")
legend("topright", col=c("black", "red", "blue"), lty=c(1,1,1), lwd=1,legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3") )
dev.off()