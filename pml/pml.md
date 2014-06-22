## Prediction Assignment Writeup

After loading the datasets, a random forest model is used for the prediction.


```r
raw_training <- read.csv('pml-training.csv')
raw_testing <- read.csv('pml-testing.csv')

library(caret)
set.seed(1234)
trainingIndex <- createDataPartition(raw_training$classe, list=FALSE, p=.9)
training = raw_training[trainingIndex,]
testing = raw_training[-trainingIndex,]

library(caret)
nzv <- nearZeroVar(training)

training <- training[-nzv]
testing <- testing[-nzv]
raw_testing <- raw_testing[-nzv]
```




```r
library(randomForest)
rf_model  <- randomForest(classe ~ ., ptraining, ntree=500, mtry=32)
```


```r
training_pred <- predict(rf_model, ptraining) 
print(confusionMatrix(training_pred, ptraining$classe))
```

```
## Confusion Matrix and Statistics
## 
##           Reference
## Prediction    A    B    C    D    E
##          A 5022    0    0    0    0
##          B    0 3418    0    0    0
##          C    0    0 3080    0    0
##          D    0    0    0 2895    0
##          E    0    0    0    0 3247
## 
## Overall Statistics
##                                 
##                Accuracy : 1     
##                  95% CI : (1, 1)
##     No Information Rate : 0.284 
##     P-Value [Acc > NIR] : <2e-16
##                                 
##                   Kappa : 1     
##  Mcnemar's Test P-Value : NA    
## 
## Statistics by Class:
## 
##                      Class: A Class: B Class: C Class: D Class: E
## Sensitivity             1.000    1.000    1.000    1.000    1.000
## Specificity             1.000    1.000    1.000    1.000    1.000
## Pos Pred Value          1.000    1.000    1.000    1.000    1.000
## Neg Pred Value          1.000    1.000    1.000    1.000    1.000
## Prevalence              0.284    0.194    0.174    0.164    0.184
## Detection Rate          0.284    0.194    0.174    0.164    0.184
## Detection Prevalence    0.284    0.194    0.174    0.164    0.184
## Balanced Accuracy       1.000    1.000    1.000    1.000    1.000
```

### Out-of-sample accuracy

```r
testing_pred <- predict(rf_model, ptesting) 
```

Confusion Matrix: 

```
## Confusion Matrix and Statistics
## 
##           Reference
## Prediction   A   B   C   D   E
##          A 556   2   0   0   0
##          B   0 373   0   0   2
##          C   1   3 339   1   0
##          D   0   0   3 319   0
##          E   1   1   0   1 358
## 
## Overall Statistics
##                                         
##                Accuracy : 0.992         
##                  95% CI : (0.987, 0.996)
##     No Information Rate : 0.285         
##     P-Value [Acc > NIR] : <2e-16        
##                                         
##                   Kappa : 0.99          
##  Mcnemar's Test P-Value : NA            
## 
## Statistics by Class:
## 
##                      Class: A Class: B Class: C Class: D Class: E
## Sensitivity             0.996    0.984    0.991    0.994    0.994
## Specificity             0.999    0.999    0.997    0.998    0.998
## Pos Pred Value          0.996    0.995    0.985    0.991    0.992
## Neg Pred Value          0.999    0.996    0.998    0.999    0.999
## Prevalence              0.285    0.193    0.174    0.164    0.184
## Detection Rate          0.284    0.190    0.173    0.163    0.183
## Detection Prevalence    0.285    0.191    0.176    0.164    0.184
## Balanced Accuracy       0.997    0.991    0.994    0.996    0.996
```

The cross validation accuracy is greater than 99%.
