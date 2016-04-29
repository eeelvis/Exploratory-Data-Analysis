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
png("plot2.png", width = 480, height = 480, units = "px")
# global active power by minute
plot(dateTime, as.numeric(as.character(global_active_power)), type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()