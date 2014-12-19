## Getting and Cleaning Data Project

##1.Merges the training and the test sets to create one data set.
##2.Extracts only the measurements on the mean and standard deviation for each measurement. 
##3.Uses descriptive activity names to name the activities in the data set
##4.Appropriately labels the data set with descriptive variable names. 
##5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


## 0.Read Files
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
features <- read.table("UCI HAR Dataset/features.txt",col.names = c("Measure_No","Measure_Name")) 
X_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = as.vector(features[,2]))
y_test <- read.table("UCI HAR Dataset/test/y_test.txt" , col.names ="activity") 
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names ="subject")
X_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = as.vector(features[,2])) 
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names ="activity")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names ="subject") 

## 1.Merges the training and the test sets to create one data set.
X_all <- rbind(X_train,X_test)
y_all <- rbind(y_train,y_test)
subject_all <- rbind(subject_train,subject_test)
subject_all_y <- cbind(subject_all,y_all)
subject_all_y_X <- cbind(subject_all_y,X_all)

## release some memory
rm (X_train,X_test,y_train,y_test, X_all, y_all, subject_train,subject_test,subject_all,subject_all_y ) 

##2.Extracts only the measurements on the mean and standard deviation for each measurement.
MEAN_AND_STD <- subject_all_y_X[grepl("(mean|std)\\(\\)", as.vector(features[,2]))]

##3.Uses descriptive activity names to name the activities in the data set
MEAN_AND_STD$activity <- factor(MEAN_AND_STD$activity, levels = activity_labels[,1], labels = activity_labels[,2])

##4.Appropriately labels the data set with descriptive variable names. 
names(MEAN_AND_STD) <- gsub("mean\\()", "Mean", names(MEAN_AND_STD))
names(MEAN_AND_STD) <- gsub("std\\()", "Std", names(MEAN_AND_STD))

##5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
library(reshape)
Measures <- grep ("Mean|Std", names (MEAN_AND_STD), value = TRUE)
molten <- melt(MEAN_AND_STD, id.vars = c("subject", "activity"), measure.vars = Measures)
tidy <- cast(molten, subject + activity ~ variable, mean)

##Create a Output File
write.csv(tidy, file = "tidy.txt", row.names = FALSE)


