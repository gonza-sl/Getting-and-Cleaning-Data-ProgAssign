# This script check to see if there is a zip file with the correct MD5 hash in 
# project folder. If not, it downloads the data. It originally comes from the 
# Human Activity Recognition Using Smartphones Data Set by the UCI Machine 
# Learning Repository.
# Unzips it in data/ ready for use by run_analysis.R


library(tools)

# Check is file exists
ls_zip_files <- list.files(pattern = ".zip")
datafile <- ls_zip_files[md5sum(ls_zip_files) == "d29710c9530a31f303801b6bc34bd895"][1]
existed <- TRUE

# If not, download
if (is.na(datafile)) {
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  datafile <- "UCI_HAR_Dataset.zip"
  download.file(fileUrl, destfile = datafile)
  existed <- FALSE
}

if (file.exists(datafile) & md5sum(datafile) == "d29710c9530a31f303801b6bc34bd895") {
  print("Download OK")
} else {
  print("Error downloading")
}

print("Unzipping...")
if (file.exists("data")) {
  unlink("data", recursive=TRUE)
}
unzip(datafile)
file.rename("./UCI HAR Dataset/", "./data/")
if (!existed) {
  file.remove(datafile)
}
print("Finished")
