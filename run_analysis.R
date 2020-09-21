# This script uses the RAW data downloaded with download_RAW_data.R. Please run
# it first.

# Exercises:
# 1 - Merges the training and the test sets to create one data set.
# 2 - Extracts only the measurements on the mean and standard deviation for each
#     measurement.
# 3 - Uses descriptive activity names to name the activities in the data set
# 4 - Appropriately labels the data set with descriptive variable names.
# 5 - From the data set in step 4, creates a second, independent tidy data set 
#     with the average of each variable for each activity and each subject.


library(data.table)
library(plyr); library(dplyr)


# Exercise 1
# ----------
# Read X
X_train <- fread("./data/train/X_train.txt")
X_test <- fread("./data/test/X_test.txt")
X <- rbind(X_train, X_test)

# Rename X columns  <--- Exercise 4 Part 1
features <- fread("./data/features.txt", sep = " ", header = FALSE)
names(X) <- features[[2]]


# Read subject
subject_train <- fread("./data/train/subject_train.txt")
subject_test <- fread("./data/test/subject_test.txt")
subject <- rbind(subject_train, subject_test)
names(subject) <- "subject" #  <--- Exercise 4 Part 2


# Read y
y_train <- fread("./data/train/y_train.txt")
y_test <- fread("./data/test/y_test.txt")
y <- rbind(y_train, y_test)
names(y) <- "activity" #  <--- Exercise 4 Part 3

# Exercise 3
# ----------
# Convert y to factor
activities <- fread("./data/activity_labels.txt", sep = " ", header = FALSE)
y[, activity := factor(activity, levels = activities[[1]], labels = str_to_lower(activities[[2]])) ]


# Join into 1 data.table
full_data <- cbind(X, subject, y)


# Exercise 2 Part 1
# -----------------
# Select columns with mean and std on the name 
selected_columns <- grep("(mean|std)", names(full_data), ignore.case = TRUE)


# Exercise 5 and Exercise 2 Part 2
# --------------------------------
# Grouped by means
tidy_means <- full_data %>% select(all_of(selected_columns), subject, activity) %>% 
                            group_by(activity, subject) %>% 
                            summarise_all(mean)

# Write tidy data set
if (!file.exists("output")) {
  dir.create("output")
}
write.table(tidy_means, "./output/tidy_means.txt", row.names = FALSE)
