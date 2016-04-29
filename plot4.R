# check file size in memory
size <- format(object.size(read.table("household_power_consumption.txt")), units = "Mb")
# load file
txt <- read.table("household_power_consumption.txt", sep = ";", skip = 1, na.strings = "?")
# name column correctly
names(txt) <- c("date", "time", "global_active_power", "global_reactive_power", "voltage", "global_intensity", "sub_metering_1", "sub_metering_2", "sub_metering_3")
# subseting by date
txt2 <- txt[as.character(txt$date) %in% c("1/2/2007", "2/2/2007"),]
# concatenate date and time in a new column
txt2$dateTime <- paste(txt2$date, txt2$time)
# convert to datetime
txt2$dateTime <- strptime(txt2$dateTime, "%d/%m/%Y %H:%M:%S")
attach(txt2)
# time to generate de plot in file
png("plot4.png", width = 480, height = 480, units="px")
# plot energy sub metering
par(mfrow = c(2,2))
# one
plot(dateTime, as.numeric(as.character(global_active_power)), type = "l", xlab = "", ylab = "Global Active Power")
# two
plot(dateTime, as.numeric(as.character(voltage)), type = "l", xlab = "datetime", ylab = "Voltage")
#three
plot(dateTime, as.numeric(as.character(sub_metering_1)), type = "l", xlab = "", ylab = "Energy sub metering", ylim = c(0,40))
lines(dateTime, as.numeric(as.character(sub_metering_2)), col = "red")
lines(dateTime, as.numeric(as.character(sub_metering_3)), col = "blue")
legend("topright", lty = 1, bty = "n", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3" ))
#four
plot(dateTime, as.numeric(as.character(global_reactive_power)), type = "l", xlab = "datetime", ylab = "Global_reactive_power")
dev.off()