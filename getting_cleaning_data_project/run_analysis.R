#load the dplyr library needed for the last question
library(dplyr)

#Function read_and_concatenate
# Load and concatenate 2 files. Concatenation occurs with file1 on top of file2:
# Both files must have the same number of columns. Columns of both files must be ordered in the same order:
#Parameters: 
#   file1: filename to load
#   file2: filename to load
#Result:
#  Concatenated files as:
#     file1
#     file2
read_and_concatenate <- function(file1, file2)
{
	#read both files
	file1_table <- read.table(file1, stringsAsFactors = FALSE)
	file2_table <- read.table(file2, stringsAsFactors = FALSE)
	#concatenate them
	full_table <- rbind(file1_table, file2_table)
	#and return the result
	full_table
}

#Function run_analysis
# Read and merge all the 3 files (subject, X and Y) of train and test. 
# Extract the mean and the standard deviation 
# Warning: must be executed in a directory containing the 'UCI HAR Dataset' directory of the extracted 'UCI HAR Dataset' archive.
run_analysis <- function ()
{
	##1. Merges the training and the test sets to create one data set
	#The different file will be merged in the same row order
	subject <- read_and_concatenate("UCI HAR Dataset\\train\\subject_train.txt", "UCI HAR Dataset\\test\\subject_test.txt")
	#  name the column
	names(subject) <- "subject"
	
	#  read and merge the X files  (the truth is out there ...)
	X <- read_and_concatenate("UCI HAR Dataset\\train\\X_train.txt", "UCI HAR Dataset\\test\\X_test.txt")
	#  read the feature file
	feature <- read.table("UCI HAR Dataset\\features.txt")
	#  and name all the columns
	names(X) <- feature[,2]
	
	#  read and merge the Y files  (the truth is out there ...)
	Y <- read_and_concatenate("UCI HAR Dataset\\train\\y_train.txt", "UCI HAR Dataset\\test\\y_test.txt")
	#  name the column
	names(Y) <- "activity"
	#  OK we now have one big data set with all column names set.
	#  Appropriately labels the data set with descriptive variable names. (Step 4)
	human_activity_reco <- cbind(X,Y,subject)
	
	##2. Extracts only the measurements on the mean and standard deviation for each measurement.
	#  Extract a logical index of the all the labels containing 'mean', 'std', 'activity' and 'subject' thanks to the grep function
	feature_to_keep <- grepl("mean|std|activity|subject", names(human_activity_reco))
	#  Apply the index to the column data keep only the selected columns
	extracted_feature <- human_activity_reco[,feature_to_keep]

	##3. Uses descriptive activity names to name the activities in the data set
	#  read the activity file. The 'stringsAsFactors' flag must be set to FALSE to avoid R auto creating a factor.
	activity_labels <- read.table("UCI HAR Dataset\\activity_labels.txt", stringsAsFactors = FALSE)
	#  Lookup activity name from activity level
	activity_names <- activity_labels[extracted_feature$activity,2]
	#  Insert the activity name into the table
	extracted_feature$activityNames <- activity_names
	
	##4. Appropriately labels the data set with descriptive variable names. 
	# Done during the step 1 
	
	##5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
	#  Thanks to dplyr, we can group by subject and activity, calculate the mean of the result of the goup by in one line 
	mean_extracted_feature <- extracted_feature %.% group_by(subject, activity) %.% summarise_each (funs(mean))
	#  convert the result in data.frame
	mean_extracted_feature_df <- as.data.frame(mean_extracted_feature)
	#  recalculate the activity name which has been lost during the mean operation
	activity_names <- activity_labels[mean_extracted_feature_df$activity, 2]
	#  Replace the activity name column into the table
	mean_extracted_feature_df$activityNames <- activity_names
	mean_extracted_feature_df
}

