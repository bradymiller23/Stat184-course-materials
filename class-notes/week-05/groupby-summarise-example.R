################################
### Group By and Summarise Example
##################################
library(tidyverse)
dat.football <- read_tsv(file = "https://raw.githubusercontent.com/ada-lovecraft/ProcessingSketches/master/Bits%20and%20Pieces/Football_Stuff/data/nfl-salaries.tsv")


#######################
### Explore the data
#######################
head(dat.football)

head(dat.football, 10)

dat.football %>%
  slice(1:10)

str(dat.football)

colnames(dat.football)



####################
### Investigating some Questions 
#####################

### Display data for just the Denver Broncos 
#Filter 
dat.football %>%
  filter(Team == "Denver Broncos") %>%
  View()


### Group Data by team
dat.football %>%
  group_by(Team) #doesn't look like it did anything??? 


### Get the mean and sd of salary, and the number of players in the data set 
dat.football %>%
  summarise(MeanSalary = mean(Salary),
            SdSalary = sd(Salary),
            NumPlayers = n() )


### Get the mean of salary by team, and the number of players on each team
dat.football %>%
  group_by(Team) %>%
  summarise(MeanSalary = mean(Salary),
            NumPlayers = n(),
            .groups = "keep" )

### What is the team with the highest paid roster? 
dat.football %>%
  group_by(Team)%>% 
  summarize(PaidRoster = sum(Salary)) %>% 
  arrange(desc(PaidRoster))


### For the Denver Broncos, which position was the least expensive? 
dat.football %>%
  filter(Team == "Denver Broncos")%>%
  group_by(Position) %>%
  summarize(PaidPosition = sum(Salary), 
            NumPlayers = n()) %>%
  arrange(PaidPosition)

### For the Denver Broncos, which position was the most expensive per player? 
dat.football %>%
  filter(Team == "Denver Broncos")%>%
  group_by(Position) %>%
  summarize(PaidPosition = sum(Salary), 
            NumPlayers = n()) %>%
  mutate(CostPerPlayer = PaidPosition/NumPlayers) %>%
  arrange(desc(CostPerPlayer))

