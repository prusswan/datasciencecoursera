run <- function() {
  # Merges the training and the test sets to create one data set.
  # Extracts only the measurements on the mean and standard deviation for each measurement.   
  features <- read.table("features.txt", col.names=c("ID","Name"), header=F)
  data_cols <- grep(".*mean\\(\\)|.*std\\(\\)", features$Name)
  
  for (i in c("test", "train")){  
    ypath <- file.path(i, paste0("y_", i, ".txt"))
    y <- paste0(i,"y")
    assign(y, read.table(ypath, header=F, col.names=c("ID")))
    
    xpath <- file.path(i, paste0("X_", i, ".txt"))
    x <- paste0(i,"x")
    assign(x, read.table(xpath, header=F, col.names=features$Name)[,data_cols])
    
    subject <- paste0(i,"subject")
    assign(subject, read.table(file.path(i, paste0("subject_", i, ".txt")), header=F, col.names=c("ID")))
  }
  
  testx$SubjectID <- testsubject$ID
  trainx$SubjectID <- trainsubject$ID
  
  testx$ActivityID <- testy$ID
  trainx$ActivityID <- trainy$ID
  
  data <- rbind(testx, trainx)

  # Uses descriptive activity names to name the activities in the data set
  # Appropriately labels the data set with descriptive activity names. 
  
  activity <- read.table("activity_labels.txt", header=F, col.names=c("ActivityID", "ActivityName"))  
  data <- merge(data, activity)
  
  # Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
  library(reshape2)
  
  ids <- c("ActivityID", "ActivityName", "SubjectID")
  measures <- setdiff(colnames(data), ids)
  melted_data <- melt(data, id=ids, measure.vars=measures)
  tidy_data <- dcast(melted_data, ActivityName + SubjectID ~ variable, mean)    
  
  write.table(tidy_data, "tidy.txt")
  
  return(data)
}
