library(data.table)

rm(list = ls())
in_file <- "household_power_consumption.txt"

in_data <- fread(in_file, sep = ";", header = TRUE, na.strings = "?")
hpc <- in_data[Date %in% c("1/2/2007", "2/2/2007")]
dt <- strptime(paste(hpc$Date, hpc$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
sm1 <- hpc$Sub_metering_1
sm2 <- hpc$Sub_metering_2
sm3 <- hpc$Sub_metering_3

make_hist3 <- function() {
  par(mfrow = c(1, 1))
  pl <- Sys.getlocale("LC_TIME")
  Sys.setlocale("LC_TIME", "en_US")
  plot(dt, sm1, type="l", ylab="Energy Submetering", xlab="")
  lines(dt, sm2, type="l", col="red")
  lines(dt, sm3, type="l", col="blue")
  legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
         lty=1, lwd=2.5, col=c("black", "red", "blue"))
  Sys.setlocale("LC_TIME", pl)
}

make_hist3()
png("plot3.png", width=480, height=480)
make_hist3()
dev.off()