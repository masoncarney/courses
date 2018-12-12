
### Vectors, data, matrices, subsetting

# vector creation/operation
x=c(2,7,5) #create vector/array as collection of numbers
x
y=seq(from=4,length=3,by=3) #create sequence of start,length,step
?seq #?command shows help/man
y
x+y
x/y
x^y

# accessing vector elements
x[2]
x[2:3] #return [start:stop] elements in vector
x[-2] #remove element [#] and return remaining vector
x[-c(1,2)] #remove collection c(#,#) from vector and return remaining vector

# creating matrices
z=matrix(seq(1,12),4,3) #matrix of (args,dim1,dim2)

# accessing matrix elements
z[3:4,2:3] #return [start:stop,start:stop] with comma separating matrix dimensions
z[,2:3] #return first dimension and [start:stop] of second dimension
z[,1] #return only column 1 of second dimension, converts matrix column to vector
z[,1,drop=FALSE] #return only column 1 of second dimension, retains matrix type

# useful commands
dim(z) #return matrix dimensions
ls() #list defined variables in environment
rm(var) #remove defined variable from environment

# generating and plotting data
x=runif(50) #create random, uniform data over 0-1 range
y=rnorm(50) #create random, normal (Gaussian) data over 0-1
plot(x,y)
plot(x,y,xlab="Random Uniform", ylab="Random Normal (Gaussian)", pch="*", col='red')
par(mfrow=c(2,1)) #par command: panel plot with 2 rows, 1 column
hist(y) #histogram plot
par(mfrow=c(1,1)) #must reset par command to initiate changes

# importing and querying data
mydata=read.csv("/path/to/my/data/mydata.csv") #can import csv file, R will read/store headings, rows, cols, etc
names(mydata) #query to read names (headings/named variables) defined in csv file
dim(mydata) #query data dimensions
class(mydata) #query data type: e.g., "data.frame"
summary(mydata) #for data.frame, returns summary of information stored in dataframe
plot(mydata$variable1,mydata$variable2) #can call elements of a list in named variable within dataframe for plotting
attach(mydata) #import named variables to R workspace dataframe
search() #returns existing dataframes in R workspace environment (mydata should be there after above command)
plot(variable1,variable1) #can now plot variables by calling them directly
