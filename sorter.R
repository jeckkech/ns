data = readLines("www_IN_year.txt")

writeLines(rev(data), "datas.txt")

dataTable = read.table("www_IN_year.txt")

dataTable$V2 <- gsub("-", "", substr(dataTable$V2, 6, 11))
dataTable$V3 <- gsub(":", "", substr(dataTable$V3, 0, 5))

dataTable$V4 <- paste(dataTable$V2,dataTable$V3, sep = ".")

ss = subset(dataTable, select=c("V1", "V4"))

write.table(subset(ss[nrow(ss):1,], select=c("V1")),"datas1.txt",sep=" ",row.names=FALSE, col.names=FALSE, quote = FALSE)
write.table(subset(ss[nrow(ss):1,], select=c("V4")),"datas2.txt",sep=" ",row.names=FALSE, col.names=FALSE, quote = FALSE)

writeLines(rev(ss), "datas.txt")
write.table(ss,"datas.txt",sep=" ",row.names=FALSE, col.names=FALSE, quote = FALSE)


fileName = c("www_IN_year.txt","www_IN_week.txt")

vvv = read.table("www_last_7day.txt")
fileName = strsplit(as.character(vvv$V1), ",")
fileName = data.frame(matrix(unlist(fileName), nrow = nrow(vvv), byrow=T))

unlist(fileName)

for(file in fileName){
  dataTable = read.table(file)
  dataTable_s = strsplit(as.character(dataTable$V1), ",")
  dataTable_s = data.frame(matrix(unlist(dataTable_s), nrow = nrow(dataTable), byrow=TRUE))
  
  dataTable_s$X1 = as.POSIXct(as.numeric(as.character(dataTable_s$X1)), origin="1970-01-01 00:00:00 GMT") - 3600*3
  dataTable_s$V1 = substr(dataTable_s$X1, 12, 50)
  dataTable_s$V2 = substr(dataTable_s$X1, 0, 10)
  
  dataTable_s = dataTable_s[nrow(dataTable_s):1,]
  
  dataTable_s$V2 <- gsub("-", "", substr(dataTable_s$V2, 3, 11))
  dataTable_s$V1 <- gsub(":", "", substr(dataTable_s$V1, 0, 5))
  dataTable_s$V3 <- paste(substr(dataTable_s$V2, 0, 4),paste(substr(dataTable_s$V2, 5, 6), dataTable_s$V1, sep = ""), sep = ",")
  
  write.table(subset(dataTable_s[nrow(dataTable_s):1,], select=c("V3")),paste(file,"_t.txt", sep=""),sep=" ",row.names=FALSE, col.names=FALSE, quote = FALSE)
  "___________________________________________________________________________________________________"
  
  dataTable = read.table("www_last_1y.txt")
  
  
  dataTable$V2 = substr(dataTable$V1, 0, 10)
  dataTable$V1 = substr(dataTable$V1, 12, 50)
  dataTable$V2 = as.POSIXct(as.numeric(dataTable$V2), origin="1970-01-01")
  dataTable$V3 = substr(dataTable$V2, 12, 50)
  dataTable$V2 = substr(dataTable$V2, 0, 10)
  
  dataTable = dataTable[nrow(dataTable):1,]
  
  
  dataTable$V3 <- paste(substr(dataTable$V2, 9, 11), gsub(":", "", substr(dataTable$V3, 0, 5)), sep="")
  dataTable$V2 <- gsub("-", "", substr(dataTable$V2, 3, 8))
  
  dataTable$V4 <- paste(dataTable$V2,substr(dataTable$V3, 0, 4), sep = ",")
  write.table(subset(dataTable[nrow(dataTable):1,], select=c("V4")),paste("_dates_","year", sep=""),sep=" ",row.names=FALSE, col.names=FALSE, quote = FALSE)
  
  write.table(subset(dataTable[nrow(dataTable):1,], select=c("V1")),paste("data_",file, sep=""),sep=" ",row.names=FALSE, col.names=FALSE, quote = FALSE)
  write.table(subset(dataTable[nrow(dataTable):1,], select=c("V4")),paste("dates_",file, sep=""),sep=" ",row.names=FALSE, col.names=FALSE, quote = FALSE)
}




fileNames = c("www_IN_year.txt","www_OUT_year.txt", "www_IN_week.txt", "www_OUT_week.txt")

for(fileName in fileNames){
  
  #fileName ="www_OUT_year.txt"
  dataTable = read.table(fileName)
  dataTable$timestamp = substr(dataTable$V1, 0, 10)
  dataTable$traffic = substr(dataTable$V1, 12, 50)
  dataTable$V1 <- NULL
  dataTable$datetime = as.POSIXct(as.numeric(as.character(dataTable$timestamp)), origin="1970-01-01 00:00:00 GMT") - 3600*3
  
  dataTable$time = substr(dataTable$datetime, 12, 50)
  dataTable$date = substr(dataTable$datetime, 0, 10)
  
  #dataTable_s = dataTable_s[nrow(dataTable_s):1,]
  
  if(grepl('week', fileName, fixed=TRUE)){
    dataTable$date <- gsub("-", "", substr(dataTable$date, 3, 11))
    dataTable$time <- gsub(":", "", substr(dataTable$time, 0, 5))
    dataTable$datetime <- paste(dataTable$date,dataTable$time, sep = ",")
    dataTable = dataTable[nrow(dataTable):1,]
  } else if (grepl('year', fileName, fixed=TRUE)){
    dataTable$date <- gsub("-", "", substr(dataTable$date, 3, 11))
    dataTable$time <- gsub(":", "", substr(dataTable$time, 0, 2))
    dataTable$datetime <- paste(substr(dataTable$date, 0, 4),paste(substr(dataTable$date, 5, 6), dataTable$time, sep = ""), sep = ",")  
  }
  
  write.table(subset(dataTable, select=c("datetime")),paste("datetime_", fileName, sep=""),sep=" ",row.names=FALSE, col.names=FALSE, quote = FALSE)
  write.table(subset(dataTable, select=c("traffic")),paste("traffic_", fileName, sep=""),sep=" ",row.names=FALSE, col.names=FALSE, quote = FALSE)
}
