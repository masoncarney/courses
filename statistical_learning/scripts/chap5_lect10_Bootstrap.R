require(ISLR)
require(boot)

### Bootstrap
# minimum risk investment (Section 5.2 of textbook)

# minimization of alpha parameter estimates optimal combination of variables 
# e.g., minimal risk for investment return
# alph = ( var(y) - covar(x,y) ) / ( var(x) + var(y) - 2*covar(x,y) )
# bootstrap used to estimate standard error on alpha from single data sample

alpha=function(x,y){
  vx=var(x) # variance of x
  vy=var(y) # variance of y
  cxy=cov(x,y) #co-variance of x and y
  (vy-cxy)/(vx+vy-2*cxy) # alpha parameter
}

alpha(Portfolio$X,Portfolio$Y)
# gives alpha for investment variables X, Y in Portfolio dataframe

# but what is sampling variability of alpha?
# cannot know a priori due to having only one sample of data

# write function that takes a dataframe, indexes rows of dataframe
# computes alpha parameter statistic
alpha.fn=function(data,index){
  with(data[index,],alpha(X,Y))
}
# index is numbers 1:n, which defines which observations are represented in bootstrap
# with() takes first argument as dataframe, then within that dataframe, execute followin command
# in this case, with executes the alpha function on X,Y using subset of data defined by index
# main value of with() is that you can use *named* values of variables within dataframe
# in this case, X and Y are named variables within Portfolio

alpha.fn(Portfolio,1:100)
# double check that alpha.fn is working: returns same value as before for alpha function over all dimensions of Portfolio

set.seed(1) # set random number seed to 1 for demonstration (reproduceable results)
alpha.fn(Portfolio,sample(1:100,100,replace=TRUE))
# take a random sample from 1:n rather than giving function values 1:n explicitly
# this is a one-off case of what bootstrap will do (random sampling of data subsets with replacement)

boot.out=boot(Portfolio,alpha.fn,R=1000)
# perform bootstrap on Portfolio dataframe using function alpha.fn with 1000 iterations
boot.out
# gives original value for alpha, shows negligible bias
# gives standard error on alpha!
plot(boot.out)



