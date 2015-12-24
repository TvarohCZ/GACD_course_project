
library(dplyr)

# 1 - Reading and combining the data

train <- read.table("UCI HAR Dataset/train/X_train.txt")
test <- read.table("UCI HAR Dataset/test/X_test.txt")

all <- rbind(train, test)

# 2 - Extracting only columns related to mean or standard deviation

features <- read.table("UCI HAR Dataset/features.txt")
colnames(all) <- features[, 2]

all <- all[, !duplicated(colnames(all))]
filtered <- all %>% select(matches("mean\\(\\)|std\\(\\)"))

# 3 - Adding activity labels to the dataset (and also subjects)

activityTrain <- read.table("UCI HAR Dataset/train/y_train.txt")
activityTest <- read.table("UCI HAR Dataset/test/y_test.txt")
subjectTrain <- read.table("UCI HAR Dataset/train/subject_train.txt")
subjectTest <- read.table("UCI HAR Dataset/test/subject_test.txt")

filtered$activityID <- c(activityTrain[, 1], activityTest[, 1])
filtered$subjectID <- c(subjectTrain[, 1], subjectTest[, 1])

filtered$subjectID

activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
colnames(activityLabels) <- c("activityID", "activityDescription")

filtered <- merge(filtered, activityLabels, by = "activityID")

# 4 - Naming variable names - already done in step 2 and 3

# 5 - Creating a tidy dataset summary

finalDataset <- filtered %>%
                  group_by(activityDescription, subjectID) %>%
                  summarize_each(funs(mean))

write.table(finalDataset, file = "final_dataset.txt", row.names = FALSE)
