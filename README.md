Tidy_data description and generation procedure

========================================================


1. Creation of data frames "data_train", "act_labels_train" and "subject_train" with txt files associated to Train sets, the labels of activities performed and the subjects performing the test


2. Creation of data frames "data_test", "act_labels_tests" and "subject_test" with txt files associated to Tests sets, the labels of activities performed and the subjects performing the test

3. For activity labels, we use the activiity names provided by "activity_labels.txt" to improve understanding

4. Creation of a data frame  "feature_names" with the txt associated to features measured at both the training and test
feature_names <- read.table("features.txt",sep="",header=FALSE)

5. Adding to "data_train" and "data_tests" three columns at the beginning, one factor to indicate whether is train or test, one column to indicate the activity according to "act_labels_train" and one column to indicate the subject according to "subject_train" 

6. LAbelling of "data_merged"  frames with feature names along with "Type_of_data", "Activitity" and "Subject" labels

7. Merging of both "data_train" and "data_test" to generrate "data_merged" data_frame

8. Selection of measurements with mean and std 

9. Generation of Data Table "tidy_data". In this table, all the feture measurements are averaged by subject and by activity


CODEBOOK  for tify data is:


- Activity: the activity performed by a subject when the measuremens is obtained, activities are: WALKING, WALKING_UPSTAIRS,WALKING_DOWNSTAIRS,SITTING,STANDING,LAYING 
- Subject: the subject performing this activity (the subject is indicated by its ID - an integer)
- The rest of columns are related to the average of the measurements obtained for each activity and subject. More specifically the average of the mean and std of the following measurements (where '-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.):
tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag


