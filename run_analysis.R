# The imports!
library(dplyr)
library(tidyr)

# Make some variables we are going to reuse
column_names_for_labels <- c("index", "label")
column_name_for_activity <- c("activity")
column_name_for_subject <- c("subject")

# 1 read the column names from the features.txt file. There should be 561 columns (aaargh)
column_labels <- read.table("UCI HAR Dataset/features.txt", col.names=column_names_for_labels)

# This we'll repeat for the train and test dataset.
trainset <- read.table("UCI HAR Dataset/train/X_train.txt", col.names=column_labels$label)
activity <- read.table("UCI HAR Dataset/train/y_train.txt", col.names=column_name_for_activity)
subject <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names=column_name_for_subject)

# Add columns for the activity and subject to the trainset
trainset <- trainset %>% mutate(activity=activity$activity, subject=subject$subject)

# Same for the test dataset
testset <- read.table("UCI HAR Dataset/test/X_test.txt", col.names=column_labels$label)
activity <- read.table("UCI HAR Dataset/test/y_test.txt", col.names=column_name_for_activity)
subject <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names=column_name_for_subject)
testset <- testset %>% mutate(activity=activity$activity, subject=subject$subject)

# bind the two dataset togther
dataset <- bind_rows(testset, trainset)

# Select only the measurements of the mean and standard deviation:
reduced_dataset <- dataset %>% select(
    contains("mean", ignore.case=FALSE), # I don't want the gravityMean etc
    contains("std", ignore.case=FALSE),
    activity,
    subject)

# Use descriptive names for the activity. Not super clear whether this is really required.
# Luckily those names exists already:
activity_label <- read.table("UCI HAR Dataset/activity_labels.txt", col.names=c("activity", "names"))

reduced_dataset <- left_join(reduced_dataset, activity_label, by=c("activity" = "activity")) %>%
        mutate(activity=names) %>%
        select(contains("mean"), contains("std"), activity, subject)


# Use the reduced dataset to get the average of each variable for each activity and for each subject
analysed_dataset <- reduced_dataset %>%
        group_by(activity, subject) %>%
        summarise_all(funs(mean(., na.rm=TRUE)))

              
# Save both datasets:
write.csv(reduced_dataset, file="tidy_dataset.csv")
write.csv(analysed_dataset, file="analysed_dataset.csv")