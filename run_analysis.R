library(readr)
library(dplyr)
library(stringr)

#Load in the Train data
X_train <- read_table2("UCI HAR Dataset/train/X_train.txt", col_names = FALSE)
y_train <- read_csv("UCI HAR Dataset/train/y_train.txt", col_names = FALSE)
subject_train <- read_csv("UCI HAR Dataset/train/subject_train.txt", col_names = FALSE)

#Load in the Test data
X_test <- read_table2("UCI HAR Dataset/test/X_test.txt", col_names = FALSE)
y_test <- read_csv("UCI HAR Dataset/test/y_test.txt", col_names = FALSE)
subject_test <- read_csv("UCI HAR Dataset/test/subject_test.txt", col_names = FALSE)

#Feature Names
features <- read_csv("UCI HAR Dataset/features.txt", 
                     col_names = FALSE)
#Activity lables
activity_labels <- read_table2("UCI HAR Dataset/activity_labels.txt", col_names = FALSE)
activity_labels <- as.data.frame(activity_labels)

#Split the string of the features so that it only has the name not the number
features2 <- as.data.frame(str_split_fixed(features$X1, " ", 2))
cols <- features2$V2

#Change the column Names
colnames(X_train) <- cols
colnames(X_test) <- cols

#Combine both Train and Test X datasets 
data <- rbind.data.frame(X_train, X_test)

#Keep only the columns that have mean or std in column names
df <- data[ , grepl("mean\\W|std()", names( data ) ) ]

#Switch out the Y train numbers with their corresponding Activity Label
trainact <- right_join(activity_labels, y_train)
colnames(trainact)[2] <- "Activity"

#Switch out the Y test numbers with their corresponding Activity Label
testact <- right_join(activity_labels, y_test)
colnames(testact)[2] <- "Activity"

#Combine both train and test y data
y_data <- rbind.data.frame(trainact, testact)
y_data <- as.data.frame(y_data$Activity)
colnames(y_data)[1] <- "Activity"

#Combine the Subject Train and Test data, change column name
subject <- rbind.data.frame(subject_train, subject_test)
colnames(subject)[1] <- "Subject"

#Combine the X, Y, and Subject data frames to make the final data frame = df
df <- cbind.data.frame(df, y_data)
df <- cbind.data.frame(df, subject)

#Clean up column names for punctuation and lowercase the names
colnames(df) <- gsub("-", "", colnames(df))
colnames(df) <- gsub("()", "", colnames(df), fixed = T)
colnames(df) <- tolower(colnames(df))

#From the data set in step 4, creates a second, independent tidy data set with the average of each 
#variable for each activity and each subject.
df2 <- as.data.frame(aggregate(. ~ activity + subject, data = df, FUN = mean))

#Output the last data frame as "TidyData
write.table(df2, file = "TidyData", row.name=FALSE)


