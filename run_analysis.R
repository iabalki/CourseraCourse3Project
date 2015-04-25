CleanData<- function (Path ="~/Data Science Classes/Course 3 Project/UCI HAR Dataset/")
{
## Coursera: Course: Cleaning of data: Project
  
## This script does the following:
## Requirement 1 -- Merges the training and the test sets to create one data set.
## Requirement 2 -- Extracts only the measurements on the mean and standard deviation for each measurement.
## Requirement 3 -- Uses descriptive activity names to name the activities in the data set;  
## Requirement 4 -- Appropriately labels the data set with descriptive variable names. 
## Requirement 5  -- From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  
## We first need to load all relevant data

activity_labels<- read.table ("./activity_labels.txt")
headings <- read.table ("./features.txt")
test.subject<- read.table ("./test/subject_test.txt")
test.x_test<- read.table ("./test/X_test.txt")
test.activity<- read.table ("./test/y_test.txt")
train.subject<- read.table ("./train/subject_train.txt")
train.x_test<- read.table ("./train/X_train.txt")
train.activity<- read.table ("./train/y_train.txt")

## Merge all of the data in the main folders (excluding Inertial Signals) by joining vertically test and train data
## anb horizontally subject, activitity code, activity, and all of the data
## This satisfies requirements 1 & 3

library (dplyr)
dat1 <- cbind (rbind (test.subject, train.subject), left_join (rbind (test.activity, train.activity),activity_labels), rbind (test.x_test, train.x_test)) 

## Name all columns appropriately. Requirement 4

## First transpose the heading file and convert into character vector
headings <- as.vector(t(headings$V2))

## then update all column names
names (dat1) <- c ("Subject", "Activity.Code", "Activity.Label", headings)

## Subset only the columns that have mean or "mean" and Standard deviation "std" in the column name 
## to satisfy requirement 2

## Find the list of measurements first
include <-c (grep ("mean", names(dat1)), grep ("std", names(dat1)))
             
## Subset the measurements to only include those that are mean and std
source.dat2 <- dat1 [,c(1:3,include)]
     
## Calcualte average for all variables by subject and activity

## Create a unique key of subject and activity == observation in our tidy dataset
source.dat2 <- cbind (paste ("Person:", source.dat2$Subject, "-", source.dat2$Activity.Label, "(", source.dat2$Activity.Code, ")", sep = ""), source.dat2)
## Name appropriately:
names (source.dat2) [1] <- "Description" 

library (reshape)

## melt first -- create a line item per observation, column for the variable and the value of the variable
source.dat2 <- source.dat2 [ , c(1, 5:ncol(source.dat2))]
melt.source.dat2 <- melt (source.dat2, id = "Description")

## combine / cast now maning aggregate back by observation
library (reshape2)
output <- dcast (melt.source.dat2, Description ~ variable, mean)

## Save the file locally
write.csv (output, "Output.csv")
             
## output the function
output

## IGNORE: ---------- Unused stuff i might need later 
## filenames <- list.files(pattern="*.txt", full.names=TRUE, recursive = TRUE)

## Calcualte average for all variables by subject and activity
##library (reshape)
## melt.source.dat2 <- melt (dat2, id = c("Subject", "Activity.Code","Activity.Label"))

## library (reshape2)
## dat3 <-dcast (melt.source.dat2, c("Subject", "Activity.Code","Activity.Label") ~ variable, mean)

}