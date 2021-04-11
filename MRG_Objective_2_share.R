## Team Project 1
## Naycari de Luna
## Marc Grabiel

## Objective 2
## Most recent confirmed case

## Sets up absolute path directory
getwd()
setwd("/Users/mrgrabiel/Desktop/Courses/R_Programming_32880/Project_1")
getwd()

confirmed <- read.csv("2021-Project-01/time_series_covid19_confirmed_global.csv", stringsAsFactors = FALSE)

View(confirmed)


## Objective 2 - Most recent case

i <- 0
column_num <- ncol(confirmed)
column_num_values <- confirmed[column_num - i]
column_num_b4 <-confirmed[column_num - i - 1]
column_values_sum <- sum(column_num_values == 0)
column_b4_sum <- sum(column_num_b4 == 0)

column_values_sum == column_b4_sum

for (i in 1:column_num)
{
  if(column_values_sum != column_b4_sum)
  {
    break
  }
  i <- i + 1
  column_num_values <- confirmed[column_num - i]
  column_num_b4 <-confirmed[column_num - i - 1]
  column_values_sum <- sum(column_num_values == 0)
  column_b4_sum <- sum(column_num_b4 == 0)
  column_values_sum == column_b4_sum
}
print(i)

column_num_values
column_num_b4

zero_values <- confirmed[confirmed$X1.20.21 == 0, ]
recent_case <- zero_values[zero_values$X1.21.21 != 0, c("Province.State", "Country.Region")]
recent_case

## Most recent case was on January 21st, 2021, in Micronesia



# NDL -- Going to give this a try without a loop

library(dplyr)
confirmed <- read.csv("time_series_covid19_confirmed_global.csv", stringsAsFactors = FALSE)
        
# NDL -- arranged all days in ascending order, last location with a first confirmed case should be
# cont. -- the first one on the confirmed_ordered data frame.

ncol <- ncol(confirmed)
confirmed_ordered <- arrange(confirmed, confirmed[5:ncol])
head(confirmed_ordered$Country.Region, n = 1)

# NDL -- Micronesia has most recent confirmed case

# NDL -- Following will find day whith first confirmed case for Micronesia

# NDL -- subsetting to have "recent" data frame only contain data under each date column
recent <- confirmed_ordered[1,-c(1:4)]
ncol_recent <- ncol(recent)

# NDL -- removes all non zero columns
recent <- recent[,recent[,1:ncol_recent]!=0]
# NDL -- first column will be the day of first confirmed case
colnames(recent[1])

head(confirmed_ordered$X1.20.21)
head(confirmed_ordered$X1.21.21)
# NDL the above line shows us only Micronesia had a first confirmed case on X1.21.21

# NDL -- its a little  wild, but i'm surprised this is getting me the same asnwer you got, so it must work?

        



