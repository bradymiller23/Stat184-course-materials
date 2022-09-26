#####################
### Intro to the Tidyverse 
#####################
#Load the Library
library(tidyverse)


## Before we get started, a small aside
# Notice the difference between these three lines
y <- 10
y <- -10
y < - 10

#####################
### First, a few basic logic operators
### Tidyverse takes advantage of logic operators, so we will introduce them here
#####################

#------------------- Comparisons with >, <, ==, <=, >= ---------------------
# >, < is greater than and less than 
5 > 3        # True 
7 * 2 > 100  # False 
9 < 9    #False

# >=, <= greater than or equal to, and less than or equal to
5 >= 3       # True
(7 * 2) >= 100 # False 
9 <= 9       # True 

# == is "is equal to?"
10 == 2 * 5 # True
7 == 14 / 3 # False  
TRUE == TRUE # True
FALSE == FALSE # True
TRUE == FALSE # False

# Be careful of precision errors 
sqrt(2) == 1.414214 # False
pi == 3.14159265358979 # False

# >, <, <=, >=, == are also vectorized functions
c(5, 6) <= c(9, 12)
c(TRUE, 5 * 8) <= c(FALSE, 40)
5 == c(5, 6)

## Comparing NA values
5 == NA # = NA, not FALSE #notice the caution arrow on next to the line number
NA == NA # = NA, not TRUE
# We use is.na() to test for NA values 
is.na(5) # False
is.na(NA) # True 
is.na(NA * 5) # True

#------------------- And" and "Or" ------------------- 
## & is the "and" operator 
TRUE & FALSE #False 
TRUE & TRUE #True
FALSE & FALSE #False 
x <- 2
y <- -10
(x < 3) & (y > -50) #True
(x <= 2) & (y < -25 ) #False


## | is the "or" operator (in math, "or" mean one, the other, or both)
TRUE | FALSE #True 
TRUE | TRUE #True
FALSE | FALSE #False 
x <- 2
y <- -10
(x < 3) | (y > -50) #True
(x <= 2) | (y < -25 ) #True

# | and & are vectorized functions 
c(TRUE, TRUE, FALSE) | c(FALSE, TRUE, FALSE)
c(TRUE, TRUE, FALSE) & c(FALSE, TRUE, FALSE)


#####################
### Loading in a data set in Tidyverse 
#####################

## In Tidyverse use read_filetype("path/to/file.filetype")
# To read in a tsv we use 
?read_tsv
dat.football <- read_tsv(file = "https://raw.githubusercontent.com/ada-lovecraft/ProcessingSketches/master/Bits%20and%20Pieces/Football_Stuff/data/nfl-salaries.tsv")

## View the top portion of the data to get an idea of what it looks like 
head(dat.football) #default is first 6 rows and all the columns
head(dat.football, n =10)
dat.football %>%
  slice(1:10)

## Get the dimensions of the data
dim(dat.football)

## Get the column names of the data 
colnames(dat.football)

## Get the row names of the data 
rownames(dat.football) #meaningless! (most times they will be)

## Get a summary of the data 
summary(dat.football) # gives summary info by column



### Basic Functions in Tidyverse 
# Tidyverse uses "verbs" as function names to describe what it is doing to the data
# Let's look at a few of these "verbs"

#Filter 
dat.football %>%
  filter(Team == "Denver Broncos")
  
#Arrange 
dat.football %>%
  arrange(Salary) #lowest to highest

dat.football %>%
  arrange(desc(Salary)) #highest to lowest

#Select
dat.football %>%
  select(PlayerName, Position)

#Rename 
dat.football %>%
  rename(TeamName = Team)

#Mutate
dat.football %>%
  mutate(PercentOfCap = Salary / SalaryCap * 100)

#Group 
dat.football %>%
  group_by(Team) #doesn't look like it did anything??? 

#Summarise 
dat.football %>%
  summarise(MeanSalary = mean(Salary))

dat.football %>%
  summarize(SdSalary = sd(Salary))

?summarise
dat.football %>%
  group_by(Team) %>%
  summarise(MeanSalary = mean(Salary), .groups = "keep" )


## Exploratory Analysis - Combining it all together 
# What is the highest salary? 
max(dat.football$Salary)

#Which player has this salary? 

# Method 1
max.salary <- max(dat.football$Salary) #get the max salary
row.max.salary <- dat.football$Salary == max.salary
answer.1 <- dat.football$PlayerName[row.max.salary]

#c(1, 2, 3, 4)[c(FALSE, FALSE, TRUE, FALSE)]

# Method 2
answer.2 <- dat.football %>%
  filter(Salary == max(Salary) ) %>%
  select(PlayerName)

# Method 3
answer.3 <- dat.football %>%
  arrange(desc(Salary)) %>%
  slice(1) %>%
  select(PlayerName)

## Whats the benefit of using tidyverse functions? 
library(utils)
object.size(c(max.salary, row.max.salary, answer.1))
object.size(answer.2)
object.size(answer.3)

944/12304 # used only 7% of the storage space by using tidyverse 

## What is the team with the highest paid roster, and what was their total pay? 
## What is the team with the lowest paid roster, and what was their total pay?
Paid <- dat.football %>%
  group_by(Team)%>% 
  summarize(PaidRoster = sum(Salary)) %>% 
  arrange(desc(PaidRoster))
Paid[1, ] #highest paid 
# how many teams are in our data set> 
dim(Paid)
length(unique(dat.football$Team))
Paid[31, ] 

#Bonus Question, if I said this data was from 2016 what team is missing from our data?
sort(unique(dat.football$Team)) 


#------ Pivot Wider and Pivot Longer ----------------------

## Pivot Wider 
?pivot_wider

# names_from = new column names 
# value_from = values to fill in in the table
us_rent_income
us_rent_income %>%
  pivot_wider(
    names_from = variable,
    values_from = c(estimate, moe)
  )
# is the above table tidy? What is each case?

## Pivot Longer 
?pivot_longer
#name_to = new column name that will contain the old column names
#values_to = new column name that will contain the data from the original table
relig_income
relig_income %>%
  pivot_longer(!religion,  # every column but religion 
               names_to = "income", 
               values_to = "count")
# Is the above table Tidy? What is a case?

world_bank_pop
world_bank_pop %>%
  pivot_longer(!c(country, indicator),
               names_to = "year",
               values_to = "count")
# is the above table tidy? What is a case?
