Assignment: Getting and Cleaning Data Course Project
===========

This project takes the data from **Human Activity Recognition Using  Smartphones 
Data Set** by the UCI Machine Learning Repository, combines the files and 
calculates the means of each variable for each activity and each subject.

The RAW data and full description is available at the site where the data was 
obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


## How To Use

In the R console, set the working directory to the downloaded folder using 
**setwd("downloaded_folder")**.

Then run the script to download the data and place it in the *./data/* folder.

    source("download_RAW_data.R")
    
Lastly run the analysis script.

    source("run_analysis.R")

that reads the data from *./data/* and combines the raw files in a **data.table**.

The output tidy data containing the means grouped by activity and subject, is 
saved in *./output/tidy_means.txt* 