Codebook
========

This file describes the purpose of run_analysis.R and the output files produced by running said script.

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. 

Each person performed six activities wearing a smartphone (Samsung Galaxy S II) on the waist.  These activities included:

* WALKING, 
* WALKING_UPSTAIRS, 
* WALKING_DOWNSTAIRS, 
* SITTING, 
* STANDING, 
* LAYING 

Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. 

The run_analysis.R works by reading in the files from test and training sets, loading in variable names and appropriately name the R variables columns and rows. The Test and Train datasets are merged into a single matrix. The script proceeds to creating a reduced version of the dataset where only "means" of the data are included in the "reduced" version of the dataset. This reduced dataset is write to the path in a csv format to the file ReducedDateset.csv.  

The script run_analysis.R also produces a tidy dataset which creates a second, independent tidy data set with the average of each variable for each activity and each subject.  This tidy dataset is writen to the path in a csv format to the file TidyDateset.csv.

