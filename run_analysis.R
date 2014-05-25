## Getting and Cleaning Data: Peer Assessment 
## By Binusha Perera

# Objective 
# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation for each measurement. 
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive activity names. 
# Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

# Loading required package: data.table and reshape2
library(data.table)
library(reshape2)

file_url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
path <- getwd()
data_dir <- file.path(path)
src_zip <- "Dataset.zip"

if (!file.exists(data_dir))
{
  dir.create(data_dir)
}
if (!file.exists(src_zip)) 
{
  download.file(url=file_url, destfile=src_zip, mode="w", method="curl")
  unzip(src_zip)  
}
# unzip the data set
path_unzipped <- file.path(data_dir, "UCI HAR Dataset")
path_unzipped
list.files(".", recursive = TRUE)

## read the files and store the training and test in separate variables to merge
#- 'train/X_train.txt': Training set.
#- 'train/y_train.txt': Training labels.
#- 'test/X_test.txt': Test set.
#- 'test/y_test.txt': Test labels.

# load x and y for test and train
x_train <- read.table(paste(path_unzipped, "/train/X_train.txt", sep=""))
y_train <- read.table(paste(path_unzipped, "/train/Y_train.txt", sep=""))
x_test <- read.table(paste(path_unzipped, "/test/X_test.txt", sep=""))
y_test <- read.table(paste(path_unzipped, "/test/Y_test.txt", sep=""))

# load variable names
variable_names <- read.table(paste(path_unzipped, "/features.txt", sep="")); 
variable_names <- variable_names[,2];
activity_labels <- read.table(paste(path_unzipped, "/activity_labels.txt", sep="")); 

# correctly name the columns of the data
names(x_train) <- variable_names
names(x_test) <- variable_names

# merges the training and the test sets to create one data set.
x_matrix <- rbind(x_test,x_train) 
y_vector <- rbind(y_test,y_train) 

# extracts only the measurements on the mean and standard deviation for each measurement. 
which_means <- grep("[m]ean", variable_names)

# correspondingly update ReducedDataset
reduced_dataset <- x_matrix[,which_means]

# write it as csv file
write.csv(reduced_dataset,file=paste(data_dir, "/ReducedDataset.csv", sep=""))

# appropriately labels the data set with descriptive activity names. 
y_vector_labels=vector(mode="character", length=length(y_vector))


# for each of the 6 different activity label, actually put in a factor variable with the 
# name of the activity
no_activities <- 6
for(activities in 1:no_activities){
  inds <- which(y_vector == activities)
  y_vector_labels[inds] <- as.character(activity_labels[activities,2])
}

# loading subject IDs
subject_train <- read.table(paste(path_unzipped, "/train/subject_train.txt", sep=""))
subject_test <- read.table(paste(path_unzipped, "/test/subject_test.txt", sep=""))

## renaming IDs to more appropriate 
# first create a function to add the word "Subject" to the number ID
subjectify <- function(x){return(paste("Subject", as.character(x), sep=""))}

# sapply function to every element 
subject_names_train <- sapply(subject_train, FUN=subjectify)
subject_names_test <- sapply(subject_test, FUN=subjectify)

# also merge the test and train subject names
subject_names_vector <- rbind(subject_names_train, subject_names_test)


# creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
tidy_data <- matrix(ncol=length(names(reduced_dataset)), nrow=length(unique(subject_names_vector)))
rownames(tidy_data) <- unique(subject_names_vector); 
colnames(tidy_data) <- names(reduced_dataset);

# for each subject calculate the mean of all variables
for(s in unique(subject_names_vector)){
  w <- which(subject_names_vector == s)
  cm <- colMeans(reduced_dataset[w,])
  tidy_data[s,] = cm
}

# write it as csv file
write.csv(tidy_data,file=paste(data_dir, "/TidyDataset.csv", sep=""))
