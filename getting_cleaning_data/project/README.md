### Introduction
The script run_analysis.R performs the following tasks:
1) Reads the data in activity_labels.txt and features.txt and loads them in memory for future reference. It also names the columns appropriately for ease of use.
2) Reads the data in the test and train folders in separate tables
3) Uses the data.table library to create two data tables which create the complete datasets with subjects, activities and variables measured. This step adds a new column 'activity_label' will be populated later.
4) Merges both the datasets.
5) Assigns the human readable column names from the data loaded in step 1 from file feature.txt
6) Assigns the human readable activity_label based on the activity column and data from activity_labels.txt file.
7) Creates a new data table by extracting the mean and standard deviation columns from the dataset. This is achieved by lookign for certain keywords in the column names.
8) The column names are cleaned up by removing columns that can cause problems with R processing commands.
9) Creates a new data table which contains averages of all the selected columns (mean and standard deviation), grouped by subject and activity.
10) Updates the column names by adding 'avg_' prefix to signify that these columns contain average values.
11) Sorts the dataset on subject and activity_label
12) Writes the dataset to a file.

### About the dataset
The data set is obtained from the website of UCI Machine Learning Repository(see [1]). The dataset description per the UCI website is as follows:
```
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.
The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.
```

###
subject - The study participant who performed the activities.
activity_label - The type of activity performed by the subject.
avg_tBodyAcc_mean_X - The average value of mean body acceleration along X axis in time domain
avg_tBodyAcc_mean_Y - The average value of mean body acceleration along Y axis in time domain
avg_tBodyAcc_mean_Z - The average value of mean body acceleration along Z axis in time domain
avg_tBodyAcc_std_X - The average value of standard deviation in body acceleration along X axis in time domain
avg_tBodyAcc_std_Y - The average value of standard deviation in body acceleration along Y axis in time domain
avg_tBodyAcc_std_Z - The average value of standard deviation in body acceleration along Z axis in time domain
avg_tGravityAcc_mean_X - The average value of mean gravity acceleration along X axis in time domain
avg_tGravityAcc_mean_Y - The average value of mean gravity acceleration along Y axis in time domain
avg_tGravityAcc_mean_Z - The average value of mean gravity acceleration along Z axis in time domain
avg_tGravityAcc_std_X - The average value of standard deviation in gravity acceleration along X axis in time domain
avg_tGravityAcc_std_Y - The average value of standard deviation in gravity acceleration along Y axis in time domain
avg_tGravityAcc_std_Z - The average value of standard deviation in gravity acceleration along Z axis in time domain
avg_tBodyAccJerk_mean_X - The average value of mean body jerk along X axis in time domain
avg_tBodyAccJerk_mean_Y - The average value of mean body jerk along Y axis in time domain
avg_tBodyAccJerk_mean_Z - The average value of mean body jerk along Z axis in time domain
avg_tBodyAccJerk_std_X - The average value of standard deviation in body jerk along X axis in time domain
avg_tBodyAccJerk_std_Y - The average value of standard deviation in body jerk along Y axis in time domain
avg_tBodyAccJerk_std_Z - The average value of standard deviation in body jerk along Z axis in time domain
avg_tBodyGyro_mean_X - The average value of mean angular velocity along X axis in time domain
avg_tBodyGyro_mean_Y - The average value of mean angular velocity along Y axis in time domain
avg_tBodyGyro_mean_Z - The average value of mean angular velocity along Z axis in time domain
avg_tBodyGyro_std_X - The average value of standard deviation in angular velocity along X axis in time domain
avg_tBodyGyro_std_Y - The average value of standard deviation in angular velocity along Y axis in time domain
avg_tBodyGyro_std_Z - The average value of standard deviation in angular velocity along Z axis in time domain
avg_tBodyGyroJerk_mean_X - The average value of mean angular velocity jerk along X axis in time domain
avg_tBodyGyroJerk_mean_Y - The average value of mean angular velocity jerk along Y axis in time domain
avg_tBodyGyroJerk_mean_Z - The average value of mean angular velocity jerk along Z axis in time domain
avg_tBodyGyroJerk_std_X - The average value of standard deviation in angular velocity jerk along X axis in time domain
avg_tBodyGyroJerk_std_Y - The average value of standard deviation in angular velocity jerk along Y axis in time domain
avg_tBodyGyroJerk_std_Z - The average value of standard deviation in angular velocity jerk along Z axis in time domain
avg_tBodyAccMag_mean - The average value of mean body acceleration in time domain
avg_tBodyAccMag_std  - The average value of standard deviation in body acceleration in time domain
avg_tGravityAccMag_mean - The average value of mean gravity acceleration in time domain
avg_tGravityAccMag_std  - The average value of standard deviation in gravity acceleration in time domain
avg_tBodyAccJerkMag_mean - The average magnitude of mean body acceleration jerk calculated using Euclidean norm in time domain
avg_tBodyAccJerkMag_std  - The average magnitude of standard deviation in body acceleration jerk calculated using Euclidean norm in time domain
avg_tBodyGyroMag_mean - The average value of mean angular velocity in time domain
avg_tBodyGyroMag_std  - The average value of standard deviation in angular velocity in time domain
avg_tBodyGyroJerkMag_mean - The average magnitude of mean angular velocity jerk calculated using Euclidean norm in time domain
avg_tBodyGyroJerkMag_std  - The average magnitude of standard deviation in angular velocity jerk calculated using Euclidean norm in time domain
avg_fBodyAcc_mean_X - The average value of mean body acceleration along X axis in frequency domain.
avg_fBodyAcc_mean_Y - The average value of mean body acceleration along Y axis in frequency domain.
avg_fBodyAcc_mean_Z - The average value of mean body acceleration along Z axis in frequency domain.
avg_fBodyAcc_std_X - The average value of standard deviation in body acceleration along X axis in frequency domain.
avg_fBodyAcc_std_Y - The average value of standard deviation in body acceleration along Y axis in frequency domain.
avg_fBodyAcc_std_Z - The average value of standard deviation in body acceleration along Z axis in frequency domain.
avg_fBodyAcc_meanFreq_X - The average value of mean frequency in body acceleration along X axis in frequency domain.
avg_fBodyAcc_meanFreq_Y - The average value of mean frequency in body acceleration along Y axis in frequency domain.
avg_fBodyAcc_meanFreq_Z - The average value of mean frequency in body acceleration along Z axis in frequency domain.
avg_fBodyAccJerk_mean_X - The average value of mean body acceleration jerk along X axis in frequency domain.
avg_fBodyAccJerk_mean_Y - The average value of mean body acceleration jerk along Y axis in frequency domain.
avg_fBodyAccJerk_mean_Z - The average value of mean body acceleration jerk along Z axis in frequency domain.
avg_fBodyAccJerk_std_X - The average value of standard deviation in body acceleration jerk along X axis in frequency domain.
avg_fBodyAccJerk_std_Y - The average value of standard deviation in body acceleration jerk along Y axis in frequency domain.
avg_fBodyAccJerk_std_Z - The average value of standard deviation in body acceleration jerk along Z axis in frequency domain.
avg_fBodyAccJerk_meanFreq_X
avg_fBodyAccJerk_meanFreq_Y
avg_fBodyAccJerk_meanFreq_Z
avg_fBodyGyro_mean_X
avg_fBodyGyro_mean_Y
avg_fBodyGyro_mean_Z
avg_fBodyGyro_std_X
avg_fBodyGyro_std_Y
avg_fBodyGyro_std_Z
avg_fBodyGyro_meanFreq_X
avg_fBodyGyro_meanFreq_Y
avg_fBodyGyro_meanFreq_Z
avg_fBodyAccMag_mean
avg_fBodyAccMag_std
avg_fBodyAccMag_meanFreq
avg_fBodyBodyAccJerkMag_mean
avg_fBodyBodyAccJerkMag_std
avg_fBodyBodyAccJerkMag_meanFreq
avg_fBodyBodyGyroMag_mean
avg_fBodyBodyGyroMag_std
avg_fBodyBodyGyroMag_meanFreq
avg_fBodyBodyGyroJerkMag_mean
avg_fBodyBodyGyroJerkMag_std
avg_fBodyBodyGyroJerkMag_meanFreq
avg_angletBodyAccJerkMeangravityMean
avg_angletBodyGyroMeangravityMean
avg_angletBodyGyroJerkMeangravityMean
avg_angleXgravityMean
avg_angleYgravityMean
avg_angleZgravityMean

### Notes
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the 'X' and 'y' files.
- The units used for the accelerations (total and body) are 'g's (gravity of earth -> 9.80665 m/seg2).
- The gyroscope units are rad/seg.

### References
[1] http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
[2] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. A Public Domain Dataset for Human Activity Recognition Using Smartphones. 21th European Symposium on Artificial Neural Networks, Computational Intelligence and Machine Learning, ESANN 2013. Bruges, Belgium 24-26 April 2013.