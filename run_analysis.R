#START WITH THE ASSIGNMENT, SET NEW WORKING DIRECTORY ETC
#getwd()
#list.files()
#list.files("R_Modul#3")

#set working directory 
#setwd("C:\\Users\\REPLACE\\Documents\\R_Modul3")
#getwd()
#list.files()
# result is "UCI HAR Dataset"
#list.files("UCI HAR Dataset")
#result is [1] "activity_labels.txt" "features.txt"        "features_info.txt"   "README.txt"          "test"               
#[6] "train"    

#setwd("C:\\Users\\REPLACE\\Documents\\R_Modul3\\UCI HAR Dataset")
#getwd()
#list.files()

#************END PREPARATION ************* # 

#*********START ASSIGNMENT REQUIREMENTS   RUN_ANALYSIS.R   ***********# 
# 1. Merges the training and the test sets to create one data set. Read the tables and merge 

#read x
t1 <- read.table("train/X_train.txt")   #7,352 entries, V100
t2 <- read.table("test/X_test.txt")  #*2'947, V100
X <- rbind(t1, t2)  #10'299 entries 

#read subject
t1 <- read.table("train/subject_train.txt")  #7'352, 1 variable
t2 <- read.table("test/subject_test.txt")  #2'947, 1 variable
Y <- rbind(t1, t2)   #10'299

#read y
t1 <- read.table("train/y_train.txt")   #7'352
t2 <- read.table("test/y_test.txt") #2'947
Z <- rbind(t1, t2)  #10'299

#*******************END reading.tbl and merging******************************************#
        
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
        
features <- read.table("features.txt")  #561
indices_of_good_features <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])  #mean, std
X <- X[, indices_of_good_features]
names(X) <- features[indices_of_good_features, 2]
names(X) <- gsub("\\(|\\)", "", names(X))
names(X) <- tolower(names(X))

# 3. Uses descriptive activity names to name the activities in the data set.
#getwd()        
#list.files("UCI HAR Dataset")

activities <- read.table("activity_labels.txt") # data loaded with capital letters and  _
activities[, 2] = gsub("_", "", tolower(as.character(activities[, 2])))   #small letters and remove underscore
Z[,1] = activities[Z[,1], 2]
names(Z) <- "activity"

# 4. Appropriately labels the data set with descriptive activity names.
names(Y) <- "subject"
cleaned <- cbind(Y, Z, X)   ##
write.table(cleaned, "cleaned_and_merged_data.txt")  #seems like it is working , file created

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
uniqueSubjects = unique(Y)[,1]
numSubjects = length(unique(Y)[,1])  #30
numActivities = length(activities[,1])  #6
numCols = dim(cleaned)[2]  #68
result = cleaned[1:(numSubjects*numActivities), ]  #180 obs. of 68 variables

row = 1
for (Y in 1:numSubjects) {
        for (a in 1:numActivities) {
                result[row, 1] = uniqueSubjects[Y]
                result[row, 2] = activities[a, 2]
                tmp <- cleaned[cleaned$subject==Y & cleaned$activity==activities[a, 2], ]
                result[row, 3:numCols] <- colMeans(tmp[, 3:numCols])
                row = row+1
        }
}
write.table(result, "data_set_with_the_averages_each.txt")



# END RUN_ANALYSIS.R #

























