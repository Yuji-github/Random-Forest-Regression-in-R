# random forest is a part of decision tree regression ideas
# so random forest can handle non-continues models

# Random Forest 
i# nstall.packages('randomForest')
library(ggplot2)
library(caTools)
library(randomForest) # for decision tree

# import data 
data = read.csv('Position_Salaries.csv')

# Position and Level are the same 
data = data[2:3]

# plotting import data 
ggplot() +
  geom_point(aes(x = data$Level, y = data$Salary), 
             color = 'red')+
  ggtitle('Salary vs Level') + 
  xlab('Level') + 
  ylab('Salary')
# the plot shows that linear can NOT follow the areas

# skip splitting data 
# set.seed(123)
# split = sample.split(data$Salary, SplitRatio = 2/3) #split(y, splitratio)
# train = subset(data, split == TRUE)
# test = subset(data, split == FALSE)

# training data
set.seed(1234)
rfr_regrssor = randomForest(x=data[1], y=data$Salary, ntree=1000)
# x needs data frame: [] is data frame
# y needs a vector: $ is vector
summary(rfr_regrssor)

# skip feature scaling because of Decision Tree
# feature scaling 
# train = scale(train)
# test = scale(test)

# prediction 
# y_pred = predict(tree_regrssor, newdata = data)
y_pred_six = predict(rfr_regrssor, data.frame(Level = 6.5))

#  visualization with smoothness (high resolution)
x_grid = seq(min(data$Level), max(data$Level), 0.01) # to modify the steps can show more better results 
ggplot() +
  geom_point(aes(x = data$Level, y = data$Salary), 
             color = 'red')+
  geom_line(aes(x = x_grid, 
                y = predict(rfr_regrssor, newdata = data.frame(Level = x_grid))), 
            color = 'blue')+
  ggtitle('Salary vs Level (Decision Tree with smoothness)') + 
  xlab('Level') + 
  ylab('Salary')
