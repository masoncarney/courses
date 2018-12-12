# import libraries
library(MASS)
library(ISLR)

### Simple linear regression
names(Boston) #load variable names from Boston dataframe preloaded by ISLR package
?Boston #help for more info on Boston dataframe
plot(medv~lstat,Boston) #take a look at median value of homes vs lower status of population within Boston datafram
                        #~ tells R that medv is the dependent variable (opposite of plot(medv,lstat)
fit1=lm(medv~lstat,data=Boston) #lm = linear model; ~ means "modeled as"; create linear model fit
fit1 #do fit
summary(fit1) #gives summary of fit
abline(fit1,col='red') #picks up fit line and plots it
names(fit1) #check variables produced by lm fit
confint(fit1) #finds confidence intervals of lm fit
predict(fit1,data.frame(lstat=c(5,10,15)),interval='confidence')
#gives lm fit predictions of medv values for lstat of 5, 10, 15 plus confidence intervals

### Multiple linear regression
fit2=lm(medv~lstat+age,data=Boston) #multi-variable lm fit with medv modeled as lstat and age
summary(fit2)
abline(fit2,col='blue') #does not work for multi-variable fit, only plots fit using first 2 of 3 regression coefficients
fit3=lm(medv~.,Boston) #multi-variable lm fit with medv modeled included all other variables in Boston dataframe
summary(fit3) #note that age was significant when using only lstat and age
              #now age no longer significant when including all variables
              #shows that age is highly correlated with other variables such that it becomes insignificant when all other variables included
par(mfrow=c(2,2)) # make plotting environment 2x2
plot(fit3) #various plots of residuals, looking for non-linearity and things not well-fit
fit4=update(fit3,~.-age-indus) #update lm fit3 using same response (medv) and same variables (all) minus age and minus indus
#after update, only significant variables/predictors are left

### Nonlinear terms and Interactions
fit5=lm(medv~lstat*age,Boston) #lm fit with interaction between lstat and age
summary(fit5) #note that var1:var2 denotes parameters of interaction
              #while age alone no longer significant on its own, the lstat:age interaction is significant
fit6=lm(medv~lstat +I(lstat^2),Boston); summary(fit6)
#earlier plot of medv vs. lstat showed non-linear trend
#above lm fit includes quadratic term for lstat
#I() means identity function; prevents lm() function from interpreting and just reads var^2 it as literal var raised to power of two
attach(Boston) #bring Boston dataframe variables into R workspace
par(mfrow=c(1,1)) #redefine subplot panels
plot(medv~lstat)
#can't use abline, only good for straight line
points(lstat,fitted(fit6),col='red',pch=20)
#plot as points with lstat as ind. variable and points fitted to fit6 lm fit values as dep. variable
#pch an identifier for plotting marker type
fit7=lm(medv~poly(lstat,4)) #lm fit with polynomial curve to the power of 4
points(lstat,fitted(fit7),col='blue',pch=20)
plot(1:20,1:20,pch=1:20,cex=2) # visualization of plotting marker types; cex is size control parameter

### Qualitative predictors
fix(Carseats) #brings up data editor window in RStudio for qualitative Carseats dataframe
names(Carseats) #names in qual. dataframe
summary(Carseats) #summary of qual. dataframe
fit1=lm(Sales~.+Income:Advertising+Age:Price,Carseats)
#lm fit to Carseat data with Sales as response including all variables plus interactions between Income/Advertising and Age/Price
summary(fit1)
contrasts(Carseats$ShelveLoc) # shows how qualitative variables are coded

### Writing R fuctions
regplot=function(x,y){ #define regplot as function of variables x and y
  fit=lm(y~x)
  plot(x,y)
  abline(fit,col='red')
}
attach(Carseats) #bring Carseat variables into R workspace
regplot(Price,Sales) #execute function with x=Price, y=Sales

regplot=function(x,y,...){ #including ... allows passing of extra variables/keywords to nested functions
  fit=lm(y~x)
  plot(x,y,...)
  abline(fit,col='red')
}
regplot(Price,Sales,xlab="Price",ylab="Sales",col='blue')




