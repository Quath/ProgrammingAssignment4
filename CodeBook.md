---
title: "CodeBook"
author: "Anna-Lea"
date: "October 17, 2018"
output: html_document
---

## Variables description:

The tidy dataset contains 81 columns:

 * the first 79 columns are the mean and standard deviation along each (X, Y, Z) vector of the initial dataset. The exact description can still be found in the dataset's features_info.txt file.
 * the last 2 variables are
 
   * activity: this is a Factor which denotes as a string the activity the subject was doing while the measurements were recorded. The choices are: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING.
   * subject: a number between 1 and 30 denoting the different test subjects.
   

## Data reduction

Since the test data and train data are originally from the same dataset, there was no need to add any column to distinguish the origin of the two datasets. As a result, the operations done on the test dataset are repeated for the training dataset.

### Read in the variables names and measurements

1. The measurements (X_train.txt) are read into memory. I've used directly the features names as column label. The resulting data.frame should have 561 columns which corresponds to the 561 features.
2. The activity and subject are also read into memory (Y_train.txt, subject_train.txt, ...). 
3. The activity and subject measurements are added to the measurement sets as an additional column. As a result, the data.frame should have 563 columns, where the last 2 should be "activity" and "subject". The activity column is still filled with numbers between 1 and 6.
4. The operation is repeated for the test dataset and kept into memory

5. The two data.frames are binded together via "bind_rows" as they have the same columns. The resulting dataframe has 563 columns are roughly 10300 rows.

6. A new dataframe is made by selecting all the columns which are the "mean" or "standard deviation" of a measurement. **Caution** Here I've only selected columns with "mean" in lower case. This means that it excludes the "gravityMean" columns.

7. I've replaced the numbers in the activity column by their string counter-parts.



