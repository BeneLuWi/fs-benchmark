benchmarkDataIn <- read.csv("D:/Studium/Betriebsysteme/fs-benchmark/r_analysis/allResults.csv", header=TRUE)
benchmarkData <- benchmarkDataIn
benchmarkData$iops <- NULL
benchmarkData <- benchmarkData[-c(393,469,661),]

unique(benchmarkData$workload)

workloadCopyfilesHdd <- subset(benchmarkData,benchmarkData$workload == "copyfiles" & benchmarkData$media == "hdd")
workloadCreatefilesHdd <- subset(benchmarkData,benchmarkData$workload == "createfiles" & benchmarkData$media == "hdd")
workloadFileserverHdd <- subset(benchmarkData,benchmarkData$workload == "fileserver" & benchmarkData$media == "hdd")
workloadOpenfilesHdd <- subset(benchmarkData,benchmarkData$workload == "openfiles" & benchmarkData$media == "hdd")
workloadRandomrwHdd <- subset(benchmarkData,benchmarkData$workload == "randomrw" & benchmarkData$media == "hdd")
workloadWebserverHdd <- subset(benchmarkData,benchmarkData$workload == "webserver" & benchmarkData$media == "hdd")

workloadCopyfilesSsd <- subset(benchmarkData,benchmarkData$workload == "copyfiles" & benchmarkData$media == "ssd")
workloadCreatefilesSsd <- subset(benchmarkData,benchmarkData$workload == "createfiles" & benchmarkData$media == "ssd")
workloadFileserverSsd <- subset(benchmarkData,benchmarkData$workload == "fileserver" & benchmarkData$media == "ssd")
workloadOpenfilesSsd <- subset(benchmarkData,benchmarkData$workload == "openfiles" & benchmarkData$media == "ssd")
workloadRandomrwSsd <- subset(benchmarkData,benchmarkData$workload == "randomrw" & benchmarkData$media == "ssd")
workloadWebserverSsd <- subset(benchmarkData,benchmarkData$workload == "webserver" & benchmarkData$media == "ssd")


test <- subset(workloadRandomrwSsd,workloadRandomrwSsd$filesystem=="ext4" & workloadRandomrwSsd$config == "1")


copySsdBtrfs10000 <- subset(workloadCopyfilesSsd,workloadCopyfilesSsd$filesystem=="btrfs" & workloadCopyfilesSsd$config=="10000")
copySsdExt410000 <- subset(workloadCopyfilesSsd,workloadCopyfilesSsd$filesystem=="ext4" & workloadCopyfilesSsd$config=="10000")
copySsdExt410000

plot(copySsdBtrfs10000$mbs)
points(copySsdExt410000$mbs)


boxplot(test$mbs)
test

numberOfExperiments <- 2 * 2 * 6 * 3

warnings(dataMeanValues <- aggregate(benchmarkData, by=list(benchmarkData$media, benchmarkData$filesystem, benchmarkData$workload, benchmarkData$config), FUN=mean, na.rm=TRUE))

write.csv(dataMeanValues, file = "meanValues.csv", row.names=FALSE)

dataMeanValues$media <- NULL
dataMeanValues$filesystem <- NULL
dataMeanValues$workload <- NULL
dataMeanValues$config <- NULL
colnames(dataMeanValues)[1] <- "media"
colnames(dataMeanValues)[2] <- "filesystem"
colnames(dataMeanValues)[3] <- "workload"
colnames(dataMeanValues)[4] <- "config"

dataMeanValues

weirdData <- subset(benchmarkData,benchmarkData$workload == "randomrw"& benchmarkData$config == "5")
View(weirdData)



benchmark_means <- data.frame(matrix(NA, nrow = numberOfExperiments, ncol = ncol(benchmarkData)))
rowNum <- 1
for(aMedia in unique(benchmarkData$media)){
  #print ("####################")
  #print(aMedia)
  mediaSubset <- subset(benchmarkData,benchmarkData$media==aMedia)
  
  for(aFilesystem in unique(mediaSubset$filesystem)){
    #print ("-----------------")
    #print(aWorkload)
    fileSystemSubset <- subset(mediaSubset,mediaSubset$filesystem==aFilesystem)
  
    for(aWorkload in unique(fileSystemSubset$workload)){
      #print ("-----------------")
      #print(aWorkload)
      workloadSubset <- subset(fileSystemSubset,fileSystemSubset$workload==aWorkload)
      
      for(aConfig in unique(workloadSubset$config)){
        #print('_')
        #print(aConfig)
        configSubset <- subset(workloadSubset,workloadSubset$config==aConfig)
        #print("vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv")
        #
        #print("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^")
        #TODO add data to benchmark data
        meanOfIops <- mean(configSubset$iopss)
        #
        configSubset
        for(i in seq(1,length(configSubset))){
          #print(paste("looking for entry",i))
          aEntry <- configSubset[i,]
          #print(aEntry)
          difference <- abs(meanOfIops - aEntry$iopss)
          if(difference > (meanOfIops / 2)){
            print("found outlier:")
            print(aEntry)
            print("in set:")
            print(configSubset)
            print(paste("Mean = ",meanOfIops," VarK = ",sd(configSubset$iopss)/meanOfIops))
            print ("")
          }
        }
        
        rowNum <- rowNum + 1
      }
    }
  }
}
