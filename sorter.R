data = readLines("dataf.txt")
data
writeLines(rev(data), "datas.txt")

dataTable = read.table("dataf.txt")

dataTable$V2 <- gsub("-", "", substr(dataTable$V2, 6, 11))
dataTable$V3 <- gsub(":", "", substr(dataTable$V3, 0, 5))

dataTable$V4 <- paste(dataTable$V2,dataTable$V3, sep = ".")

ss = subset(dataTable, select=c("V1", "V4"))

write.table(subset(ss[nrow(ss):1,], select=c("V1")),"datas1.txt",sep=" ",row.names=FALSE, col.names=FALSE, quote = FALSE)
write.table(subset(ss[nrow(ss):1,], select=c("V4")),"datas2.txt",sep=" ",row.names=FALSE, col.names=FALSE, quote = FALSE)

writeLines(rev(ss), "datas.txt")
write.table(ss,"datas.txt",sep=" ",row.names=FALSE, col.names=FALSE, quote = FALSE)