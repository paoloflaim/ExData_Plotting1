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

png(file = "plot1.png", width = 480, height = 480)
hist(df$Global_active_power, main = "Global Active Power", col="red", xlab="Global Active Power (kilowatts)")
dev.off()