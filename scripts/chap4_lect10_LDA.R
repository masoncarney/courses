require(ISLR)
require(MASS)

### Linear Discriminant Analysis
# will try to use LDA on previous two days (Lag1/Lag2) to predict market Direction
lda.fit=lda(Direction~Lag1+Lag2,data=Smarket,subset=Year<2005)
# use subset year < 2005, later will make predictions for year > 2005
lda.fit # print fit summary
plot(lda.fit)
# plots LDA variable separately for Up and Down groups in Directions
Smarket.2005=subset(Smarket,Year==2005)
# make subset of dataframe Smarket for year 2005
lda.pred=predict(lda.fit,Smarket.2005)
# use LDA fit to make predictions for year 2005 subset data
lda.pred[1:5,] # dimensions error, not in matrix format
class(lda.pred) # lad.pred is actually list of variables
# can reformat list to dataframe if list of variables have same number of observations
data.frame(lda.pred)[1:5,]
# stores variables as posteriors (e.g., Up/Down) and their LDA score
table(lda.pred$class,Smarket.2005$Direction)
# compare LDA predicted class and true Direction value from dataframe
mean(lda.pred$class==Smarket.2005$Direction)
# correct classification rate is ~55%, not great but better than chance