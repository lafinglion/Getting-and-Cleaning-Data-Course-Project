# Getting-and-Cleaning-Data-Course-Project
This is the project for the Getting and Cleaning course. 

The R script, run_analysis.R, does the following:

Download the dataset if it does not already exist in the working directory
Read both the training and test datasets
Read the activity and feature info
keep only those columns which reflect a mean or standard deviation
Loads the activity and subject data for each dataset.
Merges the two datasets
Creates a tidy dataset that consists of the average value of each variable for each subject and activity pair.

codebook.md describes the variables, the data, and any transformations or work that was performed to clean up the data.
The end result is shown in the file tidy.txt.
