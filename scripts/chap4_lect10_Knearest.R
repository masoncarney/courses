### K-Nearest Neighbor Classification
library(class)
?knn
# does not take formula, takes training vars, test vars, class label for training, and number K nearest neighbors
attach(Smarket)
Xlag=cbind(Lag1,Lag2)
# makes two-column matrix of two variables
# test data set will be predictors Lag1 and Lag2 (subset of stock market performance variables)
train=Year<2005
# training data; subset of data for year < 2005
knn.pred=knn(Xlag[train,],Xlag[!train,],Direction[train],k=1)
# use KNN algorithm to predict Direction (Up/Down) in Xlag for year > 2005 using Xlag for year < 2005 as training set
table(knn.pred,Direction[!train])
# table (confusion matrix) of KNN predicted values and true values for Direction in data for year > 2005
mean(knn.pred==Direction[!train])
# successful classification rate is exactly 50%, i.e. equivalent to null result

# try with higher values of k
knn.pred=knn(Xlag[train,],Xlag[!train,],Direction[train],k=5)
knn.pred=knn(Xlag[train,],Xlag[!train,],Direction[train],k=10)
knn.pred=knn(Xlag[train,],Xlag[!train,],Direction[train],k=50)
knn.pred=knn(Xlag[train,],Xlag[!train,],Direction[train],k=100)
