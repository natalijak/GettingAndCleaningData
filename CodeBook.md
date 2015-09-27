Getting and Cleaning Data Course Project Code Book
================================================
Data provided to be used : https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Data description: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

###The R script "run_analysis.R" procedure consist of five steps:

* First Step: Read tables and merge data set
  Reads the tables provided within the zip file
  Merges the training and test sets which creates a one data set
  train/X_train.txt with test/X_test.txt 
  The merge procedure results into total 10299x561 data frame 
  (attributes=561, Instances=10299 x_train.txt #7352 plus x_test.txt #2947). 

  In the next following step it merges
  train/subject_train.txt with test/subject_test.txt (subject IDs)
  This merge results into instances 10299x1 (with 1 variable)

  In the next step it merges
  train/y_train.txt with test/y_test.txt
  Also a data frame  10299x1 with activity IDs

* Second Step: Mean/Standard deviation.
  After reading tables and merging data sets the next step within the R script is reading the table    "features.txt" and extracting only the mean and standard deviation for each variable. 
 The result is a 10299x66 data frame, only 66 out of 561 attributes are mean and std measurements. 


* Thrid Step:  Apply Descriptiv activity names to the name of the activities in the data set
  First read "activity_labels.txt" 
  apply descriptive activity names to name the activities, see below:
                
             walking
             walkingupstairs
             walkingdownstairs
             sitting
             standing
             laying     

Labeling of the data set with descriptive naming.
Converting to lower case and removing underscores.
* Fourth Step :Appropriately labels the data set with descriptive activity names.
  Then it merges the data frame (10299x66) containing features with 10299x1 data frames containing activity    labels and subject IDs. The output is saved as "cleaned_and_merged_data.txt"", a 10299x68 data frame where   the first column contains subject IDs, the second column activity names, and the last 66 columns are  measurements. 

        e.g attributes first 10:
        tbodyacc-mean-x
        tbodyacc-mean-y
        tbodyacc-mean-z
        tbodyacc-std-x
        tbodyacc-std-y
        tbodyacc-std-z
        tgravityacc-mean-x
        tgravityacc-mean-y
        tgravityacc-mean-z
        tgravityacc-std-x

        last 10:
        fbodygyro-std-y
        fbodygyro-std-z
        fbodyaccmag-mean
        fbodyaccmag-std
        fbodybodyaccjerkmag-mean
        fbodybodyaccjerkmag-std
        fbodybodygyromag-mean
        fbodybodygyromag-std
        fbodybodygyrojerkmag-mean
        fbodybodygyrojerkmag-std


* Fifth Step: functions creates an independent tidy data set with the average of each measurement 
  for each activity and each subject  => colMeans. 
  The output is saved as "data_set_with_the_averages_each.txt", data frame (180x68) 
  the first column =subject IDs
  the second column=contains activity names:
        laying
        sitting
        standing
        walking
        walkingdownstairs
        walkingupstairs

The averages for 66 attributes start from the columns 3-68. 
Data set consist out of 180 rows, with 6 activities and 30 subjects.


END CODE BOOK 




