set.seed(13435)
x <- data.frame("var1"=sample(1:5), "var2"=sample(6:10), "var3"=sample(11:15))
x <- x[sample(1:5), ];
x$var2[c(1,3)] = NA;
x

x[,1]
x[,"var1"]
x[1:2,"var1"]
x[(x$var1 <= 3 & x$var3 > 11),]
x[(x$var1 <= 3 | x$var3 > 15),]
x[which(x$var1 <= 3 | x$var3 > 15),]
# Note that which will remove NAs only for columns 
# that are inside condition
# here, we will get NAs inside var2
x[(which(x$var1 <= 1) | which(x$var3 > 10)),]

# here, we will have rows, where NAs are not present
# inside var2
x[which(x$var2 > 2),]

# this will extract only this column
sort(x$var1)

# we can deal with NAs
sort(x$var2, decreasing = TRUE, na.last = TRUE)

# ordering data frame
x[order(x$var1),]
x[order(x$var1, x$var3),]

# plyr package
install.packages("plyr")
library(plyr)
arrange(x, var1)
arrange(x, desc(var1))

# adding data to data frame
# column
x$var4 <- rnorm(5)
x

# adding column using cbind
x <- cbind(x, rnorm(5))
x

# adding rows using rbind
# be careful here!
# rbind may change data type of columns! (coercion)
x <- rbind(x, rnorm(5))
x

setwd("~")
getwd()
if(!file.exists("./data")) { dir.create("./data") }
fileUrl <- "http://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl, "./data/restaurants.csv", method="curl")
restData <- read.csv("./data/restaurants.csv")
restData

head(restData, 3)
tail(restData, 3)

summary(restData)
str(restData)

quantile(restData$councilDistrict, probs=c(0.5, 0.75, 0.9))

table(restData$zipCode, useNA = "ifany")
table(restData$councilDistrict, restData$zipCode)

sum(is.na(restData$councilDistrict))
any(is.na(restData$councilDistrict))
all(restData$zipCode > 0)
any(restData$zipCode > 0)

colSums(is.na(restData))
all(colSums(is.na(restData)) == 0)

table(restData$zipCode %in% c("21212"))
table(restData$zipCode %in% c("21212","21213"))

restData[restData$zipCode %in% c("21212"),]

data(UCBAdmissions)
DF = as.data.frame(UCBAdmissions)
summary(DF)

xt <- xtabs(Freq ~ Gender + Admit, data = DF)
xt

warpbreaks$replicate <- rep(1:9, len=54)
xt = xtabs(breaks ~., data=warpbreaks)
xt

ftable(xt)

fakeData = rnorm(1e5)
object.size(fakeData)

print(object.size(fakeData), units = "Mb")

# sequences

s1 <- seq(1,10, by=2); s1
s2 <- seq(1,10,length=3); s2
x <- c(1,3,8,25,100); seq(along = x)

# filtering data by adding new column
restData$nearMe = restData$neighborhood %in% c("Roland Park", "Homeland")
table(restData$nearMe)

# finding data by filtering
restData$zipWrong <- ifelse(restData$zipCode < 0, TRUE, FALSE)
table(restData$zipWrong, restData$zipCode < 0)

# breaking data using quantiles
restData$zipGroups = cut(restData$zipCode, breaks=quantile(restData$zipCode))
table(restData$zipGroups)

# show as table
table(restData$zipGroups, restData$zipCode)

# using Hmisc
# this one will show zip codes as integers - much better
install.packages("Hmisc")
library(Hmisc)

restData$zipGroups = cut2(restData$zipCode, g=4)
table(restData$zipGroups)

# casting to factor variables
restData$zsf <- factor(restData$zipCode)
restData$zsf[1:10]

# factor variables - continued
yesno <- sample(c("yes","no"), size=10, replace=TRUE)
yesnofact = factor(yesno, levels=c("yes","no"))
relevel(yesnofact, ref="yes")

# first level gets value 1
# second level gets value 2
# etc.
as.numeric(yesnofact)

# adding columns with plyr package
restData2 = mutate(restData, zipGroups=cut2(zipCode, g=4))