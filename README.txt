1.) The script will first load in all the data
2.) The features will be split to get rid of the number before the name
3.) This new feature name list wil be used to change the column names of the X data to feature names
4.) It will then combine both the X train and test data
5.) It will then only keep the columns that are about mean and standard deviation
6.) It will create a table to switch the y data to the more descriptive activity labels
7.) Will combine the train and test descriptive y data 
7.) Will then bring in and combine the subject train and test data
8.) Will cobine the full X data, full descriptive y data, and subject data into one data frame
9.) Will remove messy punctuation from the column names and lowercase all the columns
10.) Using the this data frame will get the mean of each column for each subject and each activity
11.) Finally write out the this last data frame as "TidyData"
