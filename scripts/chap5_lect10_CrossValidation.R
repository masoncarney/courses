require(ISLR)
require(boot)
?cv.glm # cross-validation package for generalized linear models
plot(mpg~horsepower,data=Auto) # plot mpg vs horsepower in Auto dataframe

### Leave One Out Cross Validation (LOOCV)
glm.fit=glm(mpg~horsepower,data=Auto) # generate lm fit to mpg vs horsepower data
summary(glm.fit)
cv.glm(Auto,glm.fit)$delta
# first result in LOOCV score, second is bias-corrected K-fold validation
# cross-validation is slow, doesn't use Formula 5.2 on P. 180 of textbook)

# formula 5.2: leave one out sum of squared errors
# = 1/n * SUM( y_i - y^_(-i) )^2
# want misclassification error for each observation y_i
# for each ith observation, exclude ith observation and compute fit using all other data
# use computed fit to the make prediction at ith point
# upper formula can be rewritten (for LOOCV case) as:
# = 1/n SUM( (y_i - y^_i )^2 / (1 - H_ii)^2 )
# H_ii is diagonal element of hat matrix (operator matrix that produces least-squares fit)
# H_ii (0-1) also know as self-influence: measure of how much ith observation contributes to its own fit
# when H_ii ~ 1 (ith observation heavily influences own fit) then 1-H_ii is small and residuals are inflated (good, as expected)

# write function to use formula 5.2
loocv=function(fit){
 h=lm.influence(fit)$h # lm.influence is post-processor for lm fit, $h will extract element h from fit: H_ii diagonal hat matrix
 mean((residuals(fit)/(1-h))^2) # residuals of fit give numerator term in 5.2
}

# try out new function
loocv(glm.fit) # produces results from first fit, but very quickly!

# now implement function in fitting Auto data
# try fitting data with polynomials with degrees 1-5
cv.error=rep(0,5) # creates zeros vector with 5 elements
degree=1:5 # degree variable in range 1-5
for(d in degree){
  glm.fit=glm(mpg~poly(horsepower,d),data=Auto)
  cv.error[d]=loocv(glm.fit)
}
plot(degree,cv.error,type='b')
# clearly, polynomial fit of 2 is sufficient to minimize LOOCV error

### 10-fold Cross Validation
# here only fitting data with model 10 times (split into 10 training sets)
# as opposed to LOOCV where essentially fitting data with model for each data point
# we made it fast by using the H_ii linear regression model trick
# normally LOOCV operates more generally, e.g., on logistic regression and classification


cv.error10=rep(0,5)
degree=1:5
for(d in degree){
  glm.fit=glm(mpg~poly(horsepower,d),data=Auto)
  cv.error10[d]=cv.glm(Auto,glm.fit,K=10)$delta[1]
}
lines(degree,cv.error10,type='b',col='red')
# output is very similar to LOOCV, but faster and with better sampling of data subsets for CV
# in general, 10-fold CV is more stable measure and cheaper for computing time

