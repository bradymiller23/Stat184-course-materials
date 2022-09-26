###########################
### R Programming Basics
##########################

## To run a line either click "Run" at the top of the script 
## or press "Ctrl + enter" on a Windows machine 
## or press "Cmnd + return" on a Mac

##########################
### The Basics
###########################

## R works just like a calculator 
5 + 2
10 * (2 - 9)
3^2 / 9

## Use : to sequential list 
# list all numbers from 1 to 10 
1:10

#list all numbers from 10 to 1
10:1

## Use " " or ' ' for strings
"Hello World"
'This is also a string'
"1, 2, 3" #this is a string, NOT a vector 

## To write a vector of items we use c()
c(1, 2, 3)

# we can also put strings in vectors 
c("A", "B", "C")

## R has some basic functions already loaded in 
mean(c(1, 2, 3, 4, 5)) #mean of 1, 2, 3, 4, 5
factorial(4) # calculate 4!
rnorm(10, mean = 5, sd = 2) #generate 10 normal random variables with mean 5 and standard deviation 2

## Whenever we want more information about a function we type ?function_name
## this will prompt the help files to pop up in the bottom right pane of RStudio
## Help files provide information about what the function does, the arguments is takes in, and examples
?mean
?rnorm
?c

#############################
### Assignment
#############################

## in R we use <- (assign) to assign variable and function values
## we ues = (equals) inside functions to give arguments values 

my.number <- 1
dice <- 1:6
random.numbers <- rnorm(10, mean = 5, sd = 2)


###########################
### Indexing
###########################
## WARNING: R starts indexing a 1 (most other coding languages start indexing at 0)

## In R we use [ ] to reference items at an index in a vector 
my.vector <- 10:15
my.vector[1] # get the 1st element in my.vector
my.vector[2:4] # get the 2nd, 3rd, 4th elements in my.vector

# Be careful that you do not try to index something that does not exist
my.vector[7] # this will say NA because there is nothing in the 7th element of my.vector

## We can use the "-" sign to indicate we want all elements "except" the ones listed
# output all elements except the first one 
my.vector[ -1 ]

#output all elements except the the first and third ones 
my.vector[ -c(1, 3) ]


## When indexing matrices, the format is [row_number, column_number]
my.matrix <- matrix(1:10, nrow = 2, ncol=5)
my.matrix
my.matrix[1, 2]

# If we leave the row_number blank, it will output every element in that column
my.matrix[ , 5] #outputs all number in column 5

# Similar for columns
my.matrix[1, ] #outputs all number in row 1



########################
### Vectorization
########################
## Unlike most other coding languages, R is vectorized
## What does this mean??? 
## The default for R is to do component wise operations and not traditional matrix multiplication 

## In R, I can multiply a constant by a vector 
## This works just like traditional mathematics would
x <- c(1, 2, 3)
2 * x # = c(2, 4, 6)

## However, that is where the similarities between R and traditional mathematics end
## In traditional mathematics if I multiply [ 2  4  6] * [5, 10, 15]  i would get 
## [ 2  4  6] * [5, 10, 15] = (2 * 5) + (4 * 10) + (6 * 15) = 140
## This is not what happen in R 
v1 <- c(2, 4, 6)
v2 <- c(5, 10, 15) 

v1 * v2 #outputs c(10, 40, 90). This is not 140. What happened? 

## R did element wise computations 
## R saw that you have 2 vectors, each of length 3 
## It multiplied the first element in v1 and the first element in tv2,
## then multiplied the second element in v1 and the second element in v2,
## then multiplied the third element in v1 and the third element in v2,
## and outputs one vector of length 3.

## Similar things happen for +, -, /, and ^
v1 + v2
v1 - v2
v1 / v2
v2^v1

## If we want to do traditional matrix multiplication, we use %*%
## The output will be a matrix, not a vector 
v1 %*% v2 # = 140

## Note, if we ever want to calculate the inverse of a matrix, we use solve()
mat <- matrix(c(1,2,3,4), nrow = 2, ncol = 2)

?solve
solve(mat) #inverse of mat

mat %*% solve(mat) # identity matrix

#########################
### Data Frames
########################

## R stores data in objects called data frames 
## Lets create a data frame with 2 columns, Age (in years) and Height (in cm)

my.data <- data.frame( "Age" = c(23, 12, 90, 41, 87),
                       "Height" = c(162.3, 121.0, 174.8, 185.2, 168.9))

# This will display your data frame in the console
my.data

# This is will display your data in a new window 
View(my.data)
# Equivalently, you can also click on the "my.data" row in the Environment pane

## We can reference the information in "Age" column in a few different ways
## All of the following are equivalent 
my.data[ , 1]
my.data[ , "Age"]
my.data$Age


#############################
### Packages + Tidyverse
#############################
## You only need to install a package once (on every machine you're on)
install.packages("tidyverse")

## every time you want to use a function inside a package, you need to load the library
library(tidyverse) #now we can use the tidyverse functions! 

## Before we get into functions in the tidyverse, we will introduce one more special operator in R
## The tidyverse package contains the %>%  (pipe) operator 
## Pipe takes what ever is before the %>% and inputs as the first element into whatever is after the %>%

## An example using the quantile function
?quantile 
random.numbers <- rnorm(10, mean = 5, sd = 2)

#The following are equivalent 

#Method 1 
quantile(random.numbers)

#Method 2
random.numbers %>%
  quantile()

## Pipe is usually used when we have a series of operations we want to compute
## Lets use the iris data set as an example 

iris

# Say I want to arrange the rows in this data set by the Sepal.Length. 
# The following are equivalent

# Method 1
arrange(iris, Sepal.Length)

# Method 2
iris %>%
  arrange(Sepal.Length)

## But now say we only want to keep rows with Sepal.Width > 3 AND arrange the table by Sepal.Length
## The following are equivalent 

# Method 1
temp1 <- arrange(iris, Sepal.Length)
result <- filter(temp1, Sepal.Width > 3)
result 

# Method 2
iris %>%
  arrange(Sepal.Length) %>%
  filter(Sepal.Width > 3)

## Both methods technically work, but method 2 is must easier to read
## and took a lot less typing! 

## (advanced) Method 2 takes up significantly less memory on your machine than Method 1
## This is one of the primary reasons we use %>%