rm(list=ls())
cat("\014")

# load test and train activity datasets
test_y  = read.table("test/y_test.txt",header = FALSE)
train_y = read.table("train/y_train.txt",header = FALSE)
test_sub  = read.table("test/subject_test.txt",header = FALSE)
train_sub = read.table("train/subject_train.txt",header = FALSE)
test_x  = read.table("test/X_test.txt",header = FALSE)
train_x = read.table("train/X_train.txt",header = FALSE)
act_labels = read.table("activity_labels.txt",header = FALSE)
feat_labels = read.table("features.txt",head=FALSE)

# 1) Merge the training and the test sets to create one data set
dataset_train = cbind(train_sub, train_y, train_x)
dataset_test  = cbind(test_sub, test_y, test_x)
dataset_all  = rbind(dataset_train, dataset_test)

# create datsets for x, y and subject
dataset_x = rbind(train_x, test_x)
dataset_y = rbind(train_y, test_y)
dataset_sub = rbind(train_sub, test_sub)

head(dataset_x,1)
names(dataset_x) = feat_labels$V2
head(dataset_y$V1)
dataset_y$V1 = factor(dataset_y$V1, levels = as.integer(act_labels$V1),
                      labels = act_labels$V2)
colnames(dataset_y)
head(dataset_y,5)
names(dataset_y)= c("Activity")
names(dataset_sub)=c("Subject")
colnames(dataset_sub)

# 2) Extracts only the measurements on the mean and standard deviation for each measurement.  
measurements = c(as.character(feat_labels$V2[grep("mean\\(\\)|std\\(\\)",
                                                feat_labels$V2)]))

names(measurements) = feat_labels [measurements,2]
names(measurements) = gsub("\\()", "", names(measurements))
names(measurements) = gsub("-mean", "Mean", names(measurements))
names(measurements) = gsub("-std", "Std", names(measurements))

# 3) Using descriptive activity names to name the activities in the data set
# 4) Appropriately labels the data set with descriptive variable names.

subdata = subset(dataset_x,select=measurements)
sub_y = cbind(dataset_sub, dataset_y)

# combine subsets
cleandataset = cbind(subdata, sub_y)
colnames(cleandataset)
# From the data set in step 4, creates a second, independent tidy data set with 
# the average of each variable for each activity and each subject.

# 5) From the data set in step 4, creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject.

# Group Data and get means using dplyr package
library(dplyr)
tidydataset = cleandataset %>%
  group_by(Subject,Activity) %>%
  summarise_each(funs(mean))

# create submission file
write.table(tidydataset, file = "tidydataset.txt", row.name = FALSE)
