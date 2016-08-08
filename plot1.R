library(data.table)

rm(list = ls())
in_file <- "household_power_consumption.txt"

in_data <- fread(in_file, sep = ";", header = TRUE, na.strings = "?")
hpc <- in_data[Date %in% c("1/2/2007", "2/2/2007")]

make_hist1 <- function() {
  par(mfrow = c(1, 1))
  hist(hpc$Global_active_power, col="red", main="Global Active Power", 
     xlab="Global Active Power (kilowatts)")
}

make_hist1()
png("plot1.png", width = 480, height = 480)
make_hist1()
dev.off()