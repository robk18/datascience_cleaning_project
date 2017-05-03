clean_uci_data<-function(type="meanofmeans"){
#setwd("./r_working_dir")

#Get Features Data and read into R
features<-"./UCI HAR Dataset/features.txt"
features_data<-read.table(features)

#find the means and standard deviations columns
selectedRows <- features_data[grep("[Mm]ean|[Ss]td", features_data[,2]), ]

#Clean up the names
selectedRows[,2]<-gsub("\\()","",selectedRows[,2])
selectedRows[,2]<-gsub("-","_",selectedRows[,2])
selectedRows[,2]<-gsub(" ","",selectedRows[,2])
selectedRows[,2]<-gsub(",*$","",selectedRows[,2])
selectedRows[,2]<-gsub("\\(","_",selectedRows[,2])
selectedRows[,2]<-gsub("\\)","_",selectedRows[,2])
selectedRows[,2]<-gsub("\\)*$","",selectedRows[,2])
selectedRows[,2]<-gsub("_*$","",selectedRows[,2])
selectedRows[,2]<-gsub(",","",selectedRows[,2])
cols_mean_std<-selectedRows[,1]
data_names<-selectedRows[,2]
#Get X training data and X test data and read data into R
x_train<-"./UCI HAR Dataset/train/X_train.txt"
x_test<-"./UCI HAR Dataset/test/X_test.txt"
x_train_data<-read.table(x_train)
x_test_data<-read.table(x_test)
merged_x<-rbind(x_train_data,x_test_data)
#Get the means and standard deviations of the merged train and test data
reduced_data<-merged_x[,cols_mean_std]

#Get Y train and Y test data - Type of Activity by number for each row, Read into R and combine
y_train<-"./UCI HAR Dataset/train/y_train.txt"
y_test<-"./UCI HAR Dataset/test/y_test.txt"
y_train_data<-read.table(y_train)
y_test_data<-read.table(y_test)
merged_y<-rbind(y_train_data,y_test_data)

#Get the Activities Data and read into R
activities<-"./UCI HAR Dataset/activity_labels.txt"
activities_data<-read.table(activities)
#Look up activity names by activity number
activities_names<-merge(merged_y,activities_data,by=1)
order<-1:nrow(merged_y)
merged_y[order(order),]

#Get the subject numbers for train and test and read into R
train_subjects<-"./UCI HAR Dataset/train/subject_train.txt"
test_subjects<-"./UCI HAR Dataset/test/subject_test.txt"
train_subjects_data<-read.table(train_subjects)
test_subjects_data<-read.table(test_subjects)

#Combine the Subject Data for train and test 
merged_subjects<-rbind(train_subjects_data,test_subjects_data)

#combine subject numbers, activity_num,activity_name, and means/std data
data_means_std<-cbind(merged_subjects,activities_names,reduced_data)
names(data_means_std)<-c("subject_num","activity_num","activity_name",data_names)
#load the dplyr library
library("dplyr")
#get the means by column for grouping by subject and activity
mean_of_means<-data_means_std %>% group_by_(.dots=c("activity_num","activity_name","subject_num")) %>% summarise_each_(vars=data_names,funs=funs(Mean="mean"))

if ( type == "means" ) {
data_means_std
}
else if ( type == "meanofmeans" ) {
mean_of_means
}
else if ( type == "both" ) {
data_means_std
mean_of_means
}

}