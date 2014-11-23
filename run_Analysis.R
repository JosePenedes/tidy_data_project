
library(data.table)

# Creation of data frames "data_train", "act_labels_train" and "subject_train" with txt files associated to Train sets, the labels of activities performed and the subjects performing the test
data_train<-read.table("X_train.txt",sep="",header=FALSE)
subject_train<-read.table("subject_train.txt",sep="",header=FALSE)
act_labels_train <- read.table("y_train.txt",sep="",header=FALSE)


# Creation of data frames "data_test", "act_labels_tests" and "subject_test" with txt files associated to Tests sets, the labels of activities performed and the subjects performing the test
data_test<-read.table("X_test.txt",sep="",header=FALSE)
act_labels_test<-read.table("y_test.txt",sep="",header=FALSE)
subject_test<-read.table("subject_test.txt",sep="",header=FALSE)

# For activity labels, we use the activiity names provided by "activity_labels.txt" to improve understanding
act_labels<-read.table("activity_labels.txt",sep="",header=FALSE)
act_labels_train <- factor(as.character(act_labels_train$V1), labels=as.character(act_labels$V2))
act_labels_test <- factor(as.character(act_labels_test$V1), labels=as.character(act_labels$V2))

# Creation of a data frame  "feature_names" with the txt associated to features measured at both the training and test
feature_names <- read.table("features.txt",sep="",header=FALSE)

# Adding to "data_train" and "data_tests" three columns at the beginning, one factor to indicate whether is train or test, one column to indicate the activity according to "act_labels_train" and one column to indicate the subject according to "subject_train" 
train_label <- 1:length(act_labels_train)
train_label[1:length(train_label)]="Train"
data_train <- cbind(train_label, act_labels_train, subject_train, data_train)

test_label <- 1:length(act_labels_test)
test_label[1:length(test_label)]="Test"
data_test <- cbind(test_label, act_labels_test, subject_test, data_test)


# LAbelling of "data_merged"  frames with feature names along with "Type_of_data", "Activitity" and "Subject" labels
names(data_train) <- c("Type_of_Data", "Activity", "Subject", as.character(feature_names$V2)) 
names(data_test) <- c("Type_of_Data", "Activity", "Subject", as.character(feature_names$V2)) 

# Merging of both "data_train" and "data_test" to generrate "data_merged" data_frame
data_merged <- rbind(data_train,data_test)

# Selection of measurements with mean and std 
sel_index <- c(grep("std",names(data_merged)),grep("mean",names(data_merged)))
sel_index <- sort(as.numeric(sel_index))
sel_index <- c(1:3, sel_index)
data_merged <- data_merged[,sel_index]

# Generation of Data Table "tidy_data". In this table, all the feture measurements are averaged by subject and by activity
# The codebook for tify data is:
# Activity: the activity performed by a subject when the measuremens is obtained, activities are: WALKING, WALKING_UPSTAIRS,WALKING_DOWNSTAIRS,SITTING,STANDING,LAYING 
# Subject: the subject performing this activity (the subject is indicated by its ID - an integer)
# The rest of columns are related to the average of the measurements obtained for each activity and subject
# More specifically the average of the mean and std of the following measurements (where '-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.):
#tBodyAcc-XYZ
#tGravityAcc-XYZ
#tBodyAccJerk-XYZ
#tBodyGyro-XYZ
#tBodyGyroJerk-XYZ
#tBodyAccMag
#tGravityAccMag
#tBodyAccJerkMag
#tBodyGyroMag
#tBodyGyroJerkMag
#fBodyAcc-XYZ
#fBodyAccJerk-XYZ
#fBodyGyro-XYZ
#fBodyAccMag
#fBodyAccJerkMag
#fBodyGyroMag
#fBodyGyroJerkMag


tidy_data <-data.table(data_merged[,2:length(names(data_merged))])
tidy_data <- tidy_data[,lapply(.SD,mean),by=c("Activity","Subject")]

write.table(tidy_data, file="tidy_data.txt", sep=" ", row.name=FALSE)