library(data.table)

rm(list = ls())
in_file <- "household_power_consumption.txt"

in_data <- fread(in_file, sep = ";", header = TRUE, na.strings = "?")
hpc <- in_data[Date %in% c("1/2/2007", "2/2/2007")]

dt <- strptime(paste(hpc$Date, hpc$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
gap <- as.numeric(hpc$Global_active_power)
v <- as.numeric(hpc$Voltage)
sm1 <- as.numeric(hpc$Sub_metering_1)
sm2 <- as.numeric(hpc$Sub_metering_2)
sm3 <- as.numeric(hpc$Sub_metering_3)
grp <- as.numeric(hpc$Global_reactive_power)

make_hist4 <- function() {
  pl <- Sys.getlocale("LC_TIME")
  Sys.setlocale("LC_TIME", "en_US")
  
  par(mfrow = c(2, 2))
  
  plot(dt, gap, type="l", xlab="", ylab="Global Active Power", cex=0.25)
  plot(dt, v, type="l", xlab="datetime", ylab="Voltage")
  plot(dt, sm1, type="l", ylab="Energy Submetering", xlab="")
  lines(dt, sm2, type="l", col="red")
  lines(dt, sm3, type="l", col="blue")
  legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
         lty=, lwd=2.5, col=c("black", "red", "blue"))
  plot(dt, grp, type="l", xlab="datetime", ylab="Global_reactive_power")
  Sys.setlocale("LC_TIME", pl)
}

make_hist4()
png("plot4.png", width=480, height=480)
make_hist4()
dev.off()