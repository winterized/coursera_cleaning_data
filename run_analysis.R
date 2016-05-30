#download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "assignSet.zip", method ="curl");
#unzip("assignSet.zip");
train_data <- read.table("./UCI HAR Dataset/train/X_train.txt");
test_data <- read.table("./UCI HAR Dataset/test/X_test.txt");
all_data <- rbind(test_data, train_data)
rm("train_data");
rm("test_data");
features_list <- read.table("./UCI HAR Dataset/features.txt");
features_list <- as.character(features_list[,2]);
keepers <- c(grep("mean()", features_list),grep("std()", features_list));
keepers_names <- c(grep("mean()", features_list, value = TRUE),grep("std()", features_list, value = TRUE));
all_data <- all_data[,keepers];
names(all_data) <- keepers_names;
rm("features_list");
rm("keepers_names");
rm("keepers");
all_data$subjects <- c(as.factor(unlist(read.table("./UCI HAR Dataset/test/subject_test.txt"))),as.factor(unlist(read.table("./UCI HAR Dataset/train/subject_train.txt"))));
all_data$activities <- c(as.factor(unlist(read.table("./UCI HAR Dataset/test/y_test.txt"))),as.factor(unlist(read.table("./UCI HAR Dataset/train/y_train.txt"))));
activities_list <- read.table("./UCI HAR Dataset/activity_labels.txt");
activities_list <- as.character(activities_list[,2]);
all_data$activities <- factor(all_data$activities, labels = activities_list);
rm("activities_list");
second_set <- aggregate(all_data[,1:79], by = all_data[c("subjects","activities")], FUN = mean, na.rm = TRUE);
write.table(second_set, "step5_set.txt")