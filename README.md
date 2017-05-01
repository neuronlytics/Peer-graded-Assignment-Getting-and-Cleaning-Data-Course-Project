# Peer-graded-Assignment-Getting-and-Cleaning-Data-Course-Project
Peer Graded Project 

# This assignment is used to demonstrate the ability to preprocess raw data.

# The following steps were taken to complete the project:

Downloaded zip file containing all data
Loaded all the datasets included in zip file test and train activity datasets
Merged the training and the test sets to create one data set
dataset_train = cbind(train_sub, train_y, train_x)
dataset_test  = cbind(test_sub, test_y, test_x)
dataset_all  = rbind(dataset_train, dataset_test)
Combined x, y and subject datasets into individual files to break up the work
Extracts only the measurements on the mean and standard deviation for each measurement using the grep function  
Removed junk from measurement names
Using descriptive activity names to name the activities in the data set
Appropriately labeled the data set with descriptive variable names.
Combined the x dataset with the y datasets
Used gplyr package to group data and apply a mean
Finally, created a submission file using write.table
