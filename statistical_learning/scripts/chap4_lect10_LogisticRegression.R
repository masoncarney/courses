require(ISLR)
names(Smarket) #import Smarket (stock market) dataframe
summary(Smarket)
?Smarket
# plot scatterplot matrix of dataframe variables
pairs(Smarket,col=Smarket$Direction)
# not much correlation

### Logistic regression
# use glm (generalized linear model) function to fit LR model
glm.fit = glm(Direction~Lag1+Lag2+Lag3+Lag4+Volume,data=Smarket,family=binomial)
# predict Direction as binary response using Lag/Volume as model predictors
# binomial tells glm to use LR model as opposed to other models glm is capable of using
summary(glm.fit)
# no predictors are significant (no surprise, it's stock market data...)
glm.probs=predict(glm.fit,type="response")
# make predictions on training data (from dataframe) used to fit model
glm.probs[1:5]
# vector of fitted probabilites to predict if Direction goes up or down based on LR model (all close to 50%)
glm.pred=ifelse(glm.probs>0.5,"Up","Down")
# turn glm probabilities into classifications by using .pred and setting threshold value, e.g., 50%
attach(Smarket) # bring variables into R workspace
table(glm.pred,Direction)
# produce table of LR model Up/Down predictions and true Direction
# lots of elements on diagonals, signifying lots of prediction mistakes
mean(glm.pred==Direction)
# take mean of how frequently LR model correctly predicts true Direction
# only perform slightly better than chance (50/50)

# Make training and test sets
train = Year<2005
# create training set from subset of data for year < 2005
# now can execute a LR model fit to subset
glm.fit=glm(Direction~Lag1+Lag2+Lag3+Lag4+Volume,data=Smarket,family=binomial,subset=train)
# LR fit to data in Smarket only INCLUDING subset train
glm.probs=predict(glm.fit,newdata=Smarket[!train,],type="response")
# probabilities predicted by LR fit indexed over all data EXCLUDING train (i.e., data for year > 2005)
glm.pred=ifelse(glm.probs>0.5,"Up","Down")
# want to see if we can predict probabilities of Direction after year 2005 based on training set for year before 2005
Direction.2005=Smarket$Direction[!train]
# create new variable for Smarket Direction indexed over all data EXCLUDING train
table(glm.pred,Direction.2005)
mean(glm.pred==Direction.2005)
# correct classification rate is now ~48%, so for training subset the outcome is worse than before and worse than null result (50/50 chance)
# possibly overfitting data using train subset

# Fit a smaller model
glm.fit=glm(Direction~Lag1+Lag2,data=Smarket,family=binomial,subset=train)
# use only Lag1 and Lag2 as predictors for training data rather than the entire Lag# and Volume variable set
glm.probs=predict(glm.fit,newdata=Smarket[!train,],type="response")
glm.pred=ifelse(glm.probs>0.5,"Up","Down")
Direction.2005=Smarket$Direction[!train]
table(glm.pred,Direction.2005)
mean(glm.pred==Direction.2005)
# correct classification rate is ~55%, slightly better than before
summary(glm.fit)
# still no significant predictors, but classification performance has improved


