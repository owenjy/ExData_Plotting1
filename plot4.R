####  0
####  set up working directory  and load packages

      getwd()
      ifelse(!file.exists("data"),dir.create("data"),"dir exists")
      #if(!file.exists("data")) {dir.create("data")} else {"No need to re-create"}

####  download to working directory      
      file<-"http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
      ifelse(!file.exists("./data/household_power_consumption.zip"),
             download.file(file,"./data/household_power_consumption.zip",mode='wb'),
             "Skip! File downloaded")
      
      unzip<-unzip("./data/household_power_consumption.zip")
      raw.header<-read.table(unzip,header=T,sep=";",na.strings="?",as.is=T,nrow=1)
      ##Getting column header to apply to raw data below
      raw<-read.table(unzip,header=F,sep=";",na.strings="?",as.is=T,
                      skip=66637, #skip these frist lines
                      nrow=2880   #totally read 2880 lines
                      )
      names(raw)<-names(raw.header)
      raw$DateTime<-strptime(paste(raw$Date,raw$Time),"%d/%m/%Y %H:%M:%S")
      
######  To save you some time, I have pre-loaded all 2Million data 
#       Then, filter them down to data from the dates 2007-02-01 and 2007-02-02
#       system.time(read.table(unzip,header=T,sep=";",na.strings="?",as.is=T))
#       user  system elapsed 
#       14.54    0.33   14.87 

#      raw<-(read.table(unzip,header=T,sep=";",na.strings="?",as.is=T)) 
#      raw0<-raw[which(strptime(paste(raw$Date,raw$Time),"%d/%m/%Y %H:%M:%S")< as.POSIXlt("2007-02-03")
#             & strptime(paste(raw$Date,raw$Time),"%d/%m/%Y %H:%M:%S")>= as.POSIXlt("2007-02-01"))
#             ,]
      
#       nrow(raw0) ##2880 or 60*24*2
#       min(rownames(raw)) ##66637
#       head(raw)
#       tail(raw)
####  4
####  Plot 4
      png(filename = "./data/plot4.png",width = 480, height = 480, units = "px",bg=NA,res=72 )

      par(mfrow=c(2,2),mar= c(4, 4, 3, 2) ,cex=1,cex.lab=1)

      plot(raw$DateTime,raw$Global_active_power,type="l", ylab="Global Acitve Power", xlab=NA)

      plot(raw$DateTime,raw$Voltage,type="l", ylab="Voltage", xlab="datetime")

      plot(raw$DateTime,raw$Sub_metering_1,type="n",
           ylab="Energy sub metering",
           xlab=NA)
      lines(raw$DateTime,raw$Sub_metering_1)
      lines(raw$DateTime,raw$Sub_metering_2,col='red')
      lines(raw$DateTime,raw$Sub_metering_3,col='blue')
      legend("topright",lty = 1,lwd=1,bty="n",cex=.8,col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

      plot(raw$DateTime,raw$Global_reactive_power,type="l", 
           xlab="datetime",ylab="Global_reactive_power")
      dev.off()


      
      
      
      
      
      
      
      
      
# 
# ####  1
# ####  Plot 1
#       png(filename = "./data/plot1.png",width = 480, height = 480, units = "px",bg="white" )
#       hist(raw$Global_active_power,main=NA,col="red",
#            xlab="Global Acitve Power (kilowatts)",
#            #xlim=range(2:6)
#            )
#       title("Global Active Power")
#       dev.off()
# 
# ####  2
# ####  Plot 2
#       png(filename = "./data/plot2.png",width = 480, height = 480, units = "px",bg="white" )
#       plot(raw$DateTime,raw$Global_active_power,type="n",
#            ylab="Global Acitve Power (kilowatts)",
#            xlab=NA)
#       lines(raw$DateTime,raw$Global_active_power)
#       dev.off()
# 
# ####  3
# ####  Plot 3
#       png(filename = "./data/plot3.png",width = 480, height = 480, units = "px",bg="white" )
#       plot(raw$DateTime,raw$Sub_metering_1,type="n",
#            ylab="Energy sub metering",
#            xlab=NA)
#       lines(raw$DateTime,raw$Sub_metering_1)
#       lines(raw$DateTime,raw$Sub_metering_2,col='red')
#       lines(raw$DateTime,raw$Sub_metering_3,col='blue')
#       legend("topright",lty = 1,lwd=1.7,col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
#       dev.off()
# ####  4
# ####  Plot 4
#       png(filename = "./data/plot4.png",width = 480, height = 480, units = "px",bg="white",res=72 )
# 
#       par(mfrow=c(2,2),mar= c(3, 4, 3, 2) ,cex=1,cex.lab=1)
# 
#       plot(raw$DateTime,raw$Global_active_power,type="l", ylab="Global Acitve Power", xlab=NA)
# 
#       plot(raw$DateTime,raw$Voltage,type="l", ylab="Voltage", xlab="datetime")
# 
#       plot(raw$DateTime,raw$Sub_metering_1,type="n",
#            ylab="Energy sub metering",
#            xlab=NA)
#       lines(raw$DateTime,raw$Sub_metering_1)
#       lines(raw$DateTime,raw$Sub_metering_2,col='red')
#       lines(raw$DateTime,raw$Sub_metering_3,col='blue')
#       legend("topright",lty = 1,lwd=1,bty="n",cex=.8,col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
# 
#       plot(raw$DateTime,raw$Global_reactive_power,type="l", xlab="datetime")
#       dev.off()