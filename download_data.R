## Set working directory
setwd("./project2")

## Download the data
fileUrl = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
my.file = "expdata_prj2.zip"
if (!file.exists(my.file)) {
  retval = download.file(fileUrl, destfile = my.file)
}

