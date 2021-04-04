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


