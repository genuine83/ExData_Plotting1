library(data.table)

rm(list = ls())
in_file <- "household_power_consumption.txt"

in_data <- fread(in_file, sep = ";", header = TRUE, na.strings = "?")
hpc <- in_data[Date %in% c("1/2/2007", "2/2/2007")]
dt <- strptime(paste(hpc$Date, hpc$Time, sep=" "), "%d/%m/%Y %H:%M:%S")

make_hist2 <- function() {
  par(mfrow = c(1, 1))
  pl <- Sys.getlocale("LC_TIME")
  Sys.setlocale("LC_TIME", "en_US")
  plot(dt, hpc$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
  Sys.setlocale("LC_TIME", pl)
}


make_hist2()
png("plot2.png", width = 480, height = 480)
make_hist2()
dev.off()