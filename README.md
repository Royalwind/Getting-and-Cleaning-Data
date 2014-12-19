Getting-and-Cleaning-Data
=========================

此目錄專為存放本課程專案之相關檔案，說明如下：
"run_analysis.R" 為本專案之R語言程式碼
"tidy.txt" 為上述程式碼之產出結果

程式碼說明：
1.請將專案所提供之檔案，放在您的R語言工作目錄下之資料夾，並命名為"UCI HAR Dataset"
2.請先安裝Package "reshape"
3.逐行執行程式，程式中分為幾個區段，分別說明如下：
##0.Read Files
將專案所需之所有檔案讀入
並先將需要命名之欄位進行處理

##1.Merges the training and the test sets to create one data set.
將資料中的資料進行結合
利用rbind將training與test資料進行列的結合
再利用cbind將subject,x,y之資料進行欄的結合

## release some memory
釋放不需再用到的變數

##2.Extracts only the measurements on the mean and standard deviation for each measurement. 
利用grepl將含有mean及standard的資料過濾出來

##3.Uses descriptive activity names to name the activities in the data set
利用factor參照activity_labels將activity一欄由數字代碼轉為文字說明

##4.Appropriately labels the data set with descriptive variable names. 
利用gsub分別給予mean及standard進行命名

##5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
利用melt將每個subject中每個activity的variable獨立出來

##Create a Output File
利用write.csv將上述結果產出成一個檔案，但因為coursera的上傳區不能接受.csv的副檔名
故產出為CSV格式的.txt檔

