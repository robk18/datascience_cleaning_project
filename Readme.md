## Coursera - Data Science Cleaning Data Project

### Scripts and How to Use

* run_analysis.R - script to accomplish the above goals - source this file
	* Run function clean_uci_data() - input is output desired
		* means - mean and std of data, 
		* meanofmeans - mean of mean and std (default)
		* both - both of the previous
	* Uses Library dplyr
	* Original Data located [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
	* Unzip the above data and place in your R working directory under "UCI HAR Dataset"
	* Description of Study from UCI [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

### Added Files

* codebook.md - code book describing variables, summaries, what was done to clean the data

* run_analysis.R - Script to extract mean and standard deviations and create a new mean of the data by subject and activity

* Variables.txt - list of mean of means variables, the output of the script

### Goals of the Project as per the intructor

* Merges the training and the test sets to create one data set.

* Extracts only the measurements on the mean and standard deviation for each measurement.

* Uses descriptive activity names to name the activities in the data set

* Appropriately labels the data set with descriptive variable names.

* From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

