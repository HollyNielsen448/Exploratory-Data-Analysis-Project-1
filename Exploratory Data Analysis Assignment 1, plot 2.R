https://stackoverflow.com/questions/77927952/r-how-show-weekdays-at-x-axis-instead-of-dates-when-plotting-in-r

Household.power <- "household_power_consumption.txt"
data <- read.table (Household.power, header=TRUE, sep= ";", stringsAsFactors = FALSE, dec = ".",na.strings = "?")

data$Date <- as.Date(data$Date, format= "%d/%m/%Y")
subset <- subset(data, subset = (Date >= "2007-02-01" & Date <= "2007-02-02"))


###################################################################################
#Method 1:
date_converted <- as.Date(subset[, 1], format = "%d/%m/%Y")
date_converted <- format(date_converted, "%A")
time_converted <- strptime(subset[, 2], format = "%H:%M:%S")
time_axis <- as.POSIXct(paste(date_converted, subset[, 2]))

plot(date_converted, subset[, 3], xlab = "", ylab = "Global Active Power (kilowatts)", type = "l")
     #, xaxt='n')

# Custom x-axis
axis.Date(1, at = subset$time_axis, format = "%a") 

# weekday full name
# axis.Date(1, at = df$Date, format = "%a") # weekday abbreviated
# axis.Date(1, at = df$Date, format = "%b %d") # month-day


###################################################################################
#Method 2:
Datetime <- paste(as.Date(subset$Date), subset$Time)
subset$Datetime <- as.POSIXct(Datetime)

globalActivePower <- as.numeric(subset$Global_active_power)

plot(subset$GlobalActivePower~subset$Datetime, type="l",
     ylab="Global Active Power (kilowatts)", xlab="")

with(subset, plot(globalActivePower, Datetime))


axis(side = 1, labels = Time,  )
###################################################################################
#Method 3:

par(mfrow=c(1,1),mar=c(5,4.5,4,2))
plot(subset$Time,subset$Global_active_power, ylab="Global Active Power (kilowatts)", 
     xlab="", pch =".", type="l")

###################################################################################
#Method 4:

subset$Datetime<-as.POSIXlt(subset$Date, format = "%d/%m/%Y %H:%M:%S")

plot(x=Datetime,y=globalActivePower, ylab = "Global active power(Killowatts)", 
              xlab = "")
globalActivePower <- as.numeric(subset$Global_active_power)

plot(Datetime, globalActivePower)
###################################################################################
hpc <- read.csv("household_power_consumption.txt", header=T, sep=';', na.strings="?", 
                      nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
hpc$Date<-as.Date(hpc$Date, format = "%d/%m/%Y")

hpc$Time<-strptime(paste(hpc$Date,hpc$Time),"%F %T")

hpc<-subset(hpc,hpc$Date %in% as.Date(c("2007-02-01","2007-02-02")))

par(mfrow=c(1,1),mar=c(5,4.5,4,2))
plot(hpc$Time,hpc$Global_active_power, ylab="Global Active Power (kilowatts)", 
     xlab="", pch =".", type="l")
axis(side = 1, labels =Datetime, at = Datetime)
##################################################################################