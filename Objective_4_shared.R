# Objective 4

# OBJECTIVE 4.1
# get risk score and death burden for each country

# NDL -- I could not think of how to combine deaths and recovered data when they have different number
# cont. -- of rows, so i aggregated by country, which might be a shortcut moving into objective 4.2
library(dplyr)

# NDL -- I know its tedious, but this section of code could probably be simplified, I'm not sure how to

deaths <- read.csv("time_series_covid19_deaths_global.csv")
deaths <- subset(deaths, select = -c(1,3,4))
deaths$Sum.total <- rowSums(deaths[-1])
deaths <- aggregate(x = deaths$Sum.total, by = list(deaths$Country.Region), FUN = sum)
colnames(deaths) = c("Country.Region", "Total.Deaths")

recovered <- read.csv("time_series_covid19_recovered_global.csv")
recovered <- subset(recovered, select = -c(1,3,4))
recovered$Sum.total <- rowSums(recovered[-1])
recovered <- aggregate(x = recovered$Sum.total, by = list(recovered$Country.Region), FUN = sum)
colnames(recovered) = c("Country.Region", "Total.Recovered")

confirmed <- read.csv("time_series_covid19_confirmed_global.csv", stringsAsFactors = FALSE)
confirmed <- subset(confirmed, select = -c(1,3,4))
confirmed$Sum.total <- rowSums(confirmed[-1])
confirmed <- aggregate(x = confirmed$Sum.total, by = list(confirmed$Country.Region), FUN = sum)
colnames(confirmed) = c("Country.Region", "Total.Confirmed")

# NDL -- making a new data frame from the above data frames, will have all variables for countries 

risk_score <- merge(deaths, recovered, by = "Country.Region")
risk_score <- merge(risk_score, confirmed, by = "Country.Region")
risk_score$Risk.Score <- risk_score$Total.Deaths / risk_score$Total.Recovered
risk_score$Death.Burden <- risk_score$Risk.Score * risk_score$Total.Confirmed

# NDL -- getting global value for comparisons, just using sum of total deaths and total recovered columns 

Global_Risk_Score <- sum(risk_score$Total.Deaths) / sum(risk_score$Total.Recovered)

# NDL -- end this objective by discussing comparisons, these two lines will look at top 10 and bottom 10
# cont. -- countries for risk score as well as help discuss any potential discrepancies in the data

head(risk_score[order(-risk_score$Risk.Score),], n = 10)
tail(risk_score[order(-risk_score$Risk.Score),], n = 10)




# OBJECTIVE 4.2
# make three tables with top 5 countries that have the most COVID-19 related confirmations, 
# recoveries, and deaths. 

# NDL -- this is the part where i know i did objective 4.1 wrong because i can now use
# cont. -- data frames from 4.1 to quickly generate the tables.

# NDL -- top 5 confirmations
kable(head(confirmed[order(-confirmed$Total.Confirmed),],))
      
# NDL -- top 5 recoveries
kable(head(recovered[order(-risk_score$Total.Recovered),],))
      
# NDL -- top 5 deaths
kable(head(deaths[order(-risk_score$Total.Deaths),],))






