# Load libraries
library(dplyr)

# Download and unzip the necessary data
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "dataset.zip")
if(!file.exists("UCI HAR Dataset")) {unzip("dataset.zip")}

# Read the various data sets
xTrain <- read.table("UCI HAR Dataset/train/X_train.txt")
yTrain <- read.table("UCI HAR Dataset/train/Y_train.txt")
subjectTrain <- read.table("UCI HAR Dataset/train/subject_train.txt")

xTest <- read.table("UCI HAR Dataset/test/X_test.txt")
yTest <- read.table("UCI HAR Dataset/test/Y_test.txt")
subjectTest <- read.table("UCI HAR Dataset/test/subject_test.txt")

features <- read.table("UCI HAR Dataset/features.txt")
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")

# Merges the training and the test sets to create one data set.
xMerge <- rbind(xTrain, xTest)
yMerge <- rbind(yTrain, yTest)
subjectMerge <- rbind(subjectTrain, subjectTest)

# Extracts only the measurements on the mean and standard deviation for each measurement.
selected <- features[grep("mean\\(\\)|std\\(\\)", features[,2]),]
xMerge <- xMerge[,selected[,1]]

# Uses descriptive activity names to name the activities in the data set
colnames(yMerge) <- "activity"
yMerge$activitylabel <- factor(yMerge$activity, labels = as.character(activity_labels[,2]))
activity <- yMerge[,2]

# Appropriately labels the data set with descriptive variable names.
colnames(xMerge) <- features[selected[,1],2]
colnames(subjectMerge) <- "subject"

# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
tidyData <- cbind(xMerge, activity, subjectMerge)
tidyData_mean <- tidyData %>% group_by(subject, activity) %>% summarize_each(funs(mean))
write.table(tidyData_mean, file = "UCI HAR Dataset/tidydata.txt", row.names = FALSE, col.names = TRUE)