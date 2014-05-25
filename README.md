Getting And Cleaning Data Peer Assessment 
==========================================

This repository cotains the following files:

* README.md
* run_analysis.R
* codebook.md
* Dataset.zip
* UCI HAR Dataset
* ReducedDataset.csv
* TidyDataset.csv

The run_analysis.R works by reading in the files from test and training sets, loading in variable names and appropriately name the R variables columns and rows. The Test and Train datasets are merged into a single matrix. The script proceeds to creating a reduced version of the dataset where only "means" of the data are included in the "reduced" version of the dataset. This reduced dataset is write to the path in a csv format to the file ReducedDateset.csv.  

The script run_analysis.R also produces a tidy dataset which creates a second, independent tidy data set with the average of each variable for each activity and each subject.  This tidy dataset is writen to the path in a csv format to the file TidyDateset.csv.