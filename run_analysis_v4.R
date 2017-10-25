
library(dplyr)
library(readxl)
library(readr)

setwd("C:/Users/hlevy/Documents/R/HumanActivity")

#reading and assembling test data
testingDF <- read_xlsx("testxyz.xlsx") #read in test data
SubjectID1 <- read_xlsx("subjectnumbers.xlsx")
Activity1 <- read_xlsx("activity.xlsx")
Colvar <- read_xlsx("MeasurementValues - 10.19.17.xlsx", col_names = FALSE)

#Add subject id to results
testingDF <- cbind(testingDF, SubjectID = SubjectID1)

#Add descriptive activity names to each result
testingDF <- cbind(testingDF, Activity = Activity1)

#Add column names to test data set
colnames(testingDF) <- Colvar

#reading and assembling train data
trainingDF <- read_xlsx("trainxyz.xlsx") #read in train data
SubjectID2 <- read_xlsx("subjectnumberstr.xlsx")
Activity2 <- read_xlsx("activity2.xlsx")

#Add subject id to results
trainingDF <- cbind(trainingDF, SubjectID = SubjectID2)

#Add activity as a name to each result
trainingDF <- cbind(trainingDF, Activity = Activity2)

#Add column names to train data set
colnames(trainingDF) <- as.character(Colvar)

#Add trainingDF to testingDF making one complete DF
testingDF <- rbind(testingDF, trainingDF)

#Extract mean and standard deviation for each measurement
extractmean <- select(testingDF, contains("mean"))
extractstd <- select(testingDF, contains("std"))
extractmean
extractstd

#Create second, independent tidy data set with average of variable for each activity and subject id
testing2 <- testingDF
testing2 %>% group_by(`562_SubjectID`, `563_Activity`) %>% summarize_all(funs(mean))

#submit formatting
write.table(testingDF, "r_analysis_v3.txt", row.names = FALSE)
