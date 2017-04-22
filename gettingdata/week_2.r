# install only once
# install.packages("RMySQL")

library(RMySQL)
db <- dbConnect(MySQL(), user="genome", host="genome-mysql.cse.ucsc.edu")

result <- dbGetQuery(db, "show databases;");

dbDisconnect(db)


db <- dbConnect(MySQL(), user="genome", db="hg19", host="genome-mysql.cse.ucsc.edu")
allTables = dbListTables(db)

dbListFields(db, "affyU133Plus2")
dbGetQuery(db, "select count(*) from affyU133Plus2")
data <- dbReadTable(db, "affyU133Plus2")
data

query <- dbSendQuery(db, "select count(*) affyU133Plus2")
result <- fetch(query)
resultLimit <- fetch(query, n=10); dbClearResult(query)

# HDF5
source("http://bioconductor.org/biocLite.R")
biocLite("rhdf5")

library(rhdf5)
created <- h5createFile("example.h5")
created

created = h5createGroup("example.h5","foo")
created = h5createGroup("example.h5","baa")
created = h5createGroup("example.h5","foo/foobaa")
h5ls("example.h5")

a = matrix(1:10, nr=5, nc=2)
h5write(a, "example.h5","foo/A")
b <- array(seq(0.1,2.0,by=0.1), dim=c(5,2,2))
attr(b, "scale") <- "liter"
h5write(b, "example.h5", "foo/foobaa/B")
h5ls("example.h5")

df = data.frame(1L:5L, 
                seq(0,1,length.out=5),
                c("ab", "cde", "fghi", "a", "s"),
                stringsAsFactors=FALSE)
h5write(df, "example.h5", "df")
h5ls("example.h5")

read_a = h5read("example.h5", "foo/A")
read_b = h5read("example.h5", "foo/foobaa/B")
read_df = h5read("example.h5", "df")
read_a

h5write(c(12,13,14), "example.h5", "foo/A", index=list(1:3, 1))
h5read("example.h5", "foo/A")
