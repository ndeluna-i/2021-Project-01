# Objective 4

# OBJECTIVE 4.1
# get risk score and death burden for each country

# NDL -- I could not think of how to combine deaths and recovered data when they have different number
# cont. -- of rows, so i aggregated by country, which might be a shortcut moving into objective 4.2
library(dplyr)
library(kableExtra)

View(deaths)
View(total_deaths)
View(total_recovered)
View(total_confirmed)
View(risk_score)
View(recovered)

deaths <- read.csv("time_series_covid19_deaths_global.csv")
column_num_deaths <- ncol(deaths)
total_deaths <- subset(deaths, select = c(1, 2, column_num_deaths))
total_deaths$StateRegion <- do.call(paste0, total_deaths[1:2])
colnames(total_deaths) = c("Province.State", "Country.Region", "Total.Deaths", "StateRegion")

recovered <- read.csv("time_series_covid19_recovered_global.csv")
column_num_recovered <- ncol(recovered)
total_recovered <- subset(recovered, select = c(1, 2,column_num_recovered))
total_recovered$StateRegion <- do.call(paste0, total_recovered[1:2])
colnames(total_recovered) = c("Province.State", "Country.Region", "Total.Recovered", "StateRegion")

confirmed <- read.csv("time_series_covid19_confirmed_global.csv", stringsAsFactors = FALSE)
column_num_confirmed <- ncol(confirmed)
total_confirmed <- subset(confirmed, select = c(1, 2,column_num_confirmed))
total_confirmed$StateRegion <- do.call(paste0, total_confirmed[1:2])
colnames(total_confirmed) = c("Province.State", "Country.Region", "Total.Confirmed", "StateRegion")

risk_score <- merge(total_deaths, total_recovered, by = "StateRegion")
risk_score <- subset(risk_score, select = c(1:4, 7))
risk_score <- merge(risk_score, total_confirmed, by = "StateRegion")
risk_score <- subset(risk_score, select = c(1:5, 8))
risk_score$Risk.Score <- risk_score$Total.Deaths / risk_score$Total.Recovered
risk_score$Death.Burden <- risk_score$Risk.Score * risk_score$Total.Confirmed

# NDL -- getting global value for comparisons, just using sum of total deaths and total recovered columns 

Global_Risk_Score <- sum(risk_score$Total.Deaths) / sum(risk_score$Total.Recovered)

Global_Risk_Score
# NDL -- end this objective by discussing comparisons, these two lines will look at top 10 and bottom 10
# cont. -- countries for risk score as well as help discuss any potential discrepancies in the data

head(risk_score[order(-risk_score$Risk.Score),], n = 12)
tail(risk_score[order(-risk_score$Risk.Score),], n = 23)




## Objective 4 (pretty much 4.2, from Naycari)

# NDL -- I know its tedious, but this section of code could probably be simplified, I'm not sure how to


deaths <- read.csv("time_series_covid19_deaths_global.csv")
column_num_deaths <- ncol(deaths)
total_deaths2 <- subset(deaths, select = c(2,column_num_deaths))
total_deaths2$Sum.total <- rowSums(total_deaths2[-1])
total_deaths2 <- aggregate(x = total_deaths2$Sum.total, by = list(total_deaths2$Country.Region), FUN = sum)
colnames(total_deaths2) = c("Country.Region", "Total.Deaths")

View(total_deaths2)

recovered <- read.csv("time_series_covid19_recovered_global.csv")
column_num_recovered <- ncol(recovered)
total_recovered2 <- subset(recovered, select = c(2,column_num_recovered))
total_recovered2$Sum.total <- rowSums(total_recovered2[-1])
total_recovered2 <- aggregate(x = total_recovered2$Sum.total, by = list(total_recovered2$Country.Region), FUN = sum)
colnames(total_recovered2) = c("Country.Region", "Total.Recovered")

View(total_recovered2)

confirmed <- read.csv("time_series_covid19_confirmed_global.csv", stringsAsFactors = FALSE)
column_num_confirmed <- ncol(confirmed)
total_confirmed2 <- subset(confirmed, select = c(2,column_num_confirmed))
total_confirmed2$Sum.total <- rowSums(total_confirmed2[-1])
total_confirmed2 <- aggregate(x = total_confirmed2$Sum.total, by = list(total_confirmed2$Country.Region), FUN = sum)
colnames(total_confirmed2) = c("Country.Region", "Total.Confirmed")

View(total_confirmed2)
# NDL -- making a new data frame from the above data frames, will have all variables for countries 

risk_score2 <- merge(total_deaths2, total_recovered2, by = "Country.Region")
risk_score2 <- merge(risk_score2, total_confirmed2, by = "Country.Region")
risk_score2$Risk.Score <- risk_score2$Total.Deaths / risk_score2$Total.Recovered
risk_score2$Death.Burden <- risk_score2$Risk.Score * risk_score2$Total.Confirmed

risk_score2
# NDL -- getting global value for comparisons, just using sum of total deaths and total recovered columns 

Global_Risk_Score <- sum(risk_score2$Total.Deaths) / sum(risk_score2$Total.Recovered)

# NDL -- end this objective by discussing comparisons, these two lines will look at top 10 and bottom 10
# cont. -- countries for risk score as well as help discuss any potential discrepancies in the data

head(risk_score2[order(-risk_score2$Risk.Score),], n = 9)
tail(risk_score2[order(-risk_score2$Risk.Score),], n = 10)




# OBJECTIVE 4.2
# make three tables with top 5 countries that have the most COVID-19 related confirmations, 
# recoveries, and deaths. 

# NDL -- this is the part where i know i did objective 4.1 wrong because i can now use
# cont. -- data frames from 4.1 to quickly generate the tables.

# NDL -- top 5 confirmations
kable(head(total_confirmed2[order(-total_confirmed2$Total.Confirmed),],), n = 5)
      
# NDL -- top 5 recoveries
kable(head(total_recovered2[order(-risk_score2$Total.Recovered),],), n = 9)
      
# NDL -- top 5 deaths
kable(head(total_deaths2[order(-risk_score2$Total.Deaths),],), n = 5)






