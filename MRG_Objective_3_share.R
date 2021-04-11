## Team Project 1
## Naycari de Luna
## Marc Grabiel

## Objective 1
## Confirmed cases

## Sets up absolute path directory
getwd()
setwd("/Users/mrgrabiel/Desktop/Courses/R_Programming_32880/Project_1")
getwd()

confirmed <- read.csv("2021-Project-01/time_series_covid19_confirmed_global.csv", stringsAsFactors = FALSE)

View(confirmed)



## Objective 3

library(geosphere)

locations <- confirmed[c(72, 183), c(4:1)]
locations

Hubei <- c(locations[1,1], locations[1,2])
Hubei

Micronesia <- c(locations[2,1], locations[2,2])
Micronesia

dist_between <- round(distm(Hubei, Micronesia)*0.000621371, digits = 2)
dist_between

paste(locations[2,3], " is ", dist_between, " miles away from ", locations[1,4], ", ", locations[1,3], ".", sep = "")

## "Micronesia is 2955.32 miles away from Hubei, China."












##  Marc is exploring here - related to Objective 1

# Write a function that takes a date as a value and 
# returns the most popular Country.Region in that year

max(confirmed[["X1.24.20"]])

most_confirmed <- function(date_input){
  date_stored <- date_input
  max_vec <- max(confirmed[[date_stored]])
  country_max <- confirmed[confirmed[[date_stored]] == max_vec, c("Country.Region", "Province.State", date_input)]
  return(country_max)
}

most_confirmed("X1.24.20")


###  Marc is exploring here - related to Objective 1

ncol(confirmed) # number of columns in data frame, 436

vector_colnames_pre <- colnames(confirmed)
vec_colnames <- vector_colnames_pre[5:ncol(confirmed)]

place_origin <- sapply(vec_colnames, most_confirmed)
place_origin
place_origin[[1]]
class(place_origin)

dim(place_origin)

place_origin[2, 1]

count_Hubei <- function(x){
  i = 1
  place <- place_origin[2, i]
  if (place == x){
    i = i + 1
    
  }
  
}

##     Marc - is this a relevant process for Objective 1?  Maybe not.
##  Marc, you need to make a for loop up there, not if
# Make the area (x) == the place the array detects.  If that is the
## case, advance one.  See how many times it happens.



# NDL -- trying this out

library(geosphere)
confirmed <- read.csv("time_series_covid19_confirmed_global.csv", stringsAsFactors = FALSE)

nrow_origin <- as.numeric(which(grepl("Hubei", confirmed$Province.State)))
nrow_recent <- which(grepl("Micronesia", confirmed$Country.Region))


miles_between <- as.numeric(round(distm(as.numeric(confirmed[nrow_origin, 4:3]), as.numeric(confirmed[nrow_recent, 4:3]))*(0.000621371)))

# NDL -- making a summary data frame for the phrase, a little too tedious though 
data <- data.frame(Case=c("Origin", "Recent"), 
                   Country.Region = c(confirmed[nrow_origin, 1], confirmed[nrow_recent, 1]),
                   State.Province = c(confirmed[nrow_origin, 2], confirmed[nrow_recent, 2]),
                   Lat = c(confirmed[nrow_origin, 4], confirmed[nrow_recent, 4]),
                   Long = c(confirmed[nrow_origin, 3], confirmed[nrow_recent, 3]))

# NDL -- based off Marc's structure for this part 
paste(data[2,3], " is ", miles_between, " miles away from ", data[1,2], ", ", data[1,3], ".", sep = "")


# NDL -- below is extra syntax incase i need to trouble shoot something above
#Hubei <- as.numeric(confirmed[nrow_origin, 4:3])
#Micronesia <- as.numeric(confirmed[nrow_recent, 4:3])

#Hubei <- as.numeric(confirmed[which(confirmed$Province.State == "Hubei"), 4:3])
#Micronesia <- as.numeric(confirmed[which(confirmed$Country.Region == "Micronesia"), 4:3])




