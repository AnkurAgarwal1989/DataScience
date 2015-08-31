#1.Merges the training and the test sets to create one data set.
#2.Extracts only the measurements on the mean and standard deviation for each measurement. 
#3.Uses descriptive activity names to name the activities in the data set
#4.Appropriately labels the data set with descriptive variable names.
#5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#clear out workpsace
rm(list= ls())

#using dplyr package
library(dplyr)

#1. Merge test and train data sets
#read in both data sets
#'train/X_train.txt': Training set
#'test/X_test.txt': Test set

#storing path to data
dir <- "getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/"

#filenames
trainFile <- paste(dir, "train/X_train.txt", sep = "")
testFile <- paste(dir, "test/X_test.txt", sep = "")
featureFile <- paste(dir, "features.txt", sep = "")

#read in the text files as data frames
trainData <- read.table(trainFile)
testData <- read.table(testFile)
#read the names of the variables from features.txt file
features <- read.table(featureFile)
#We need a vector to apply colnames...second column of features has names
featureNames <- as.vector(features[,2])

#convert data frames to tables
train <- tbl_df(trainData)
test <- tbl_df(testData)

#combine train and test data
combined <- bind_rows(train, test)

#Read the activity labels now
trainFile <- paste(dir, "train/y_train.txt", sep = "")
testFile <- paste(dir, "test/y_test.txt", sep = "")
#read in the text files as data frames
trainData <- read.table(trainFile)
testData <- read.table(testFile)
activityData <- tbl_df(rbind(trainData, testData))
colnames(activityData) <- "Activity"

#Read subject data now
trainFile <- paste(dir, "train/subject_train.txt", sep = "")
testFile <- paste(dir, "test/subject_test.txt", sep = "")
#read in the text files as data frames
trainData <- read.table(trainFile)
testData <- read.table(testFile)
subjectData <- tbl_df(rbind(trainData, testData))
colnames(subjectData) <- "SubjectID"

rm(testData)
rm(trainData)
rm(test)
rm(train)

#2. Extracts only the measurements on the mean and standard deviation

#Apply the feature names to combined
#4. This also takes care of the descriptive feature names
#we re-use the names of features in the dataset
colnames(combined) <- featureNames

#Some names like "fBodyAccJerk-bandsEnergy()-1,8" are repeated..dafuq
#Lets remove them for now...there is a better way to handle these....but no time
#remove the duplicated columns
combined <- combined[, which(!duplicated(colnames(combined)))]
#then only keep columns which contain "mean" and "std"
combined <- combined %>%
    select(matches("mean"), matches("std"))

#3. Uses descriptive activity names to name the activities
#Adding activity and subject columns to combined data
#order: subject, activity, features
combined  <- subjectData %>% 
    bind_cols(activityData, combined)

#Naming activities...
#First we'll factor the activity column so its easy to rename the factors
combined$Activity <- factor(combined$Activity)
levels(combined$Activity) <- c("walking", "walking_upstairs", "walking_downstairs", "sitting", "standing", "laying")

#5. Tidy Data
library(reshape2)

#melt data into a narrow form
#our ids are Subject and Activity
melted <- melt(combined, id.vars = c("Activity", "SubjectID"))

#dcast this into the means of the variables
tidyData <- dcast(melted, Activity + SubjectID ~ variable, mean)

write.table(tidyData, "tidyData.txt", row.names = FALSE)
tidyData <- read.table("tidyData.txt", header = T)



