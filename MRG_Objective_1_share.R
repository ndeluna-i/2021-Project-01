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

# Identifies Province.Region and number of confirmed cases on the first date
confirmed_region <- confirmed[confirmed$X1.22.20 == max(confirmed$X1.22.20), c("Province.State", "Country.Region", "X1.22.20")]
confirmed_region


# Aggregates Province.Region data by Country.Region and identifies
# Country.Region with highest confirmed cases on the first day.
confirmed_agg <- aggregate(cbind(X1.22.20) ~ Country.Region, data=confirmed, FUN=sum)
confirmed_agg

confirmed_country <- confirmed_agg[confirmed_agg$X1.22.20 == max(confirmed_agg$X1.22.20), c("Country.Region", "X1.22.20")]
confirmed_country

##  Still missing syntax to include deaths and recovered and
##  Use if statements to see if they all match.

# NDL -- Creates variable with province/state and country/region based on max confirmed on 01/22/20
confirmed_origin <- confirmed[which.max(confirmed$X1.22.20), c("Province.State", "Country.Region")]
confirmed_country <- as.character(confirmed_origin[[c("Country.Region")]])
confirmed_state <- as.character(confirmed_origin[[c("Province.State")]])

# NDL -- Creates variable with province/state and country/region based on max deaths on 01/22/20
deaths_origin <- deaths[which.max(deaths$X1.22.20), c("Province.State", "Country.Region")]
deaths_country <- as.character(deaths_origin[[c("Country.Region")]])
deaths_state <- as.character(deaths_origin[[c("Province.State")]])

# NDL -- Creates variable with province/state and country/region based on max recovered on 01/22/20
recovered_origin <- recovered[which.max(recovered$X1.22.20), c("Province.State", "Country.Region")]
recovered_country <- as.character(recovered_origin[[c("Country.Region")]])
recovered_state <- as.character(recovered_origin[[c("Province.State")]])

# NDL -- Conditional statement to see if country is same between 3 variables
if(identical(deaths_country, recovered_country) == identical(recovered_country, confirmed_country))
  {
  print("same country")
  }else
    {
      print("not same country")
    }

# NDL -- Conditional statement to see if sate is same between 3 variables
if(identical(deaths_state, recovered_state) == identical(recovered_state, confirmed_state))
{
  print("same state")
}else
{
  print("not same state")
}