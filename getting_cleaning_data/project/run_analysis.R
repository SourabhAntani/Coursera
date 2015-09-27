#You should create one R script called run_analysis.R that does the following. 
#1 Merges the training and the test sets to create one data set.
#2 Extracts only the measurements on the mean and standard deviation for each measurement. 
#3 Uses descriptive activity names to name the activities in the data set
#4 Appropriately labels the data set with descriptive variable names. 
#5 From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


#Load the meta data from files
activityLabels = read.table("UCI HAR Dataset//activity_labels.txt");
names(activityLabels) = c("activity", "lbl");

featureLabels = read.table("UCI HAR Dataset//features.txt")
names(featureLabels) = c("featureSeq","featureName");

#Load data
testX=read.table("UCI HAR Dataset//test//X_test.txt");
test_subject = read.table("UCI HAR Dataset//test//subject_test.txt");
test_activity = read.table("UCI HAR Dataset//test//y_test.txt");
trainX=read.table("UCI HAR Dataset//train//X_train.txt");
train_subject = read.table("UCI HAR Dataset//train//subject_train.txt");
train_activity = read.table("UCI HAR Dataset//train//y_train.txt");

#Create data tables for easier manipulation
library(data.table);
dtTest = data.table(subject=test_subject, activity = test_activity,  activity_label = rep("UNK",nrow(testX)), testX);
dtTrain = data.table(subject=train_subject, activity = train_activity, activity_label = rep("UNK",nrow(trainX)), trainX);

#Merge the test and train data
final = rbind(dtTest, dtTrain);

#Assign meaningful variable names (column names)
finalNames = c("subject", "activity", "activity_label")
for(n in featureLabels$featureName){
  finalNames = c(finalNames,n);
}
setnames(final, finalNames);

#Assign text activity labels to the rows based on the activity number
j = match("activity_label", colnames(final));
for(i in 1:nrow(activityLabels)){
  final[final$activity==i, activity_label := {activityLabels[activityLabels$activity==i,][2]},];
}

#Extract mean and standard deviation values with subject and activity_label
library(dplyr)
reqdCols = finalNames[grep("subject|activity_label|mean()|Mean)|std()", finalNames)];
newFinal = final %>% select(match(reqdCols,names(.)));

newFinalNames = names(newFinal);
newFinalNames = gsub("-","_", newFinalNames);
newFinalNames = gsub("\\(","", newFinalNames);
newFinalNames = gsub("\\)","", newFinalNames);
newFinalNames = gsub(",","", newFinalNames);
setnames(newFinal, newFinalNames);

#tBodyAcc_mean_X:angleZgravityMean
avgFinal = newFinal[,lapply(.SD, mean), by="subject,activity_label", .SDcols=3:ncol(newFinal)];
avgFinalNames = names(newFinal);
for(i in 3:ncol(newFinal)){
  avgFinalNames[i] = paste0("avg_",avgFinalNames[i]);
}
setnames(avgFinal,avgFinalNames);
avgFinal = avgFinal[order(avgFinal$subject, avgFinal$activity_label),]
write.table(avgFinal,file="tidyResult.txt", row.names = F);
