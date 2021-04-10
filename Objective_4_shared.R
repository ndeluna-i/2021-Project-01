# Objective 4

# OBJECTIVE 4.1
# get risk score and death burden for each country
# NDL -- I could not think of how to combine deaths and recovered data when they have different number
# cont. -- of rows, so i combined values by country. Which might be a shortcut moving into objective 4.2
library(dplyr)

deaths <- read.csv("time_series_covid19_deaths_global.csv")
deaths <- subset(deaths, select = -c(1,3,4))
deaths$Sum.total <- rowSums(deaths[-1])
deaths <- aggregate(x = deaths$Sum.total, by = list(deaths$Country.Region), FUN = sum)


recovered <- read.csv("time_series_covid19_recovered_global.csv")
recovered <- subset(recovered, select = -c(1,3,4))
recovered$Sum.total <- rowSums(recovered[-1])
recovered <- aggregate(x = recovered$Sum.total, by = list(recovered$Country.Region), FUN = sum)

confirmed <- read.csv("time_series_covid19_confirmed_global.csv", stringsAsFactors = FALSE)
confirmed <- subset(confirmed, select = -c(1,3,4))
confirmed$Sum.total <- rowSums(confirmed[-1])
confirmed <- aggregate(x = confirmed$Sum.total, by = list(confirmed$Country.Region), FUN = sum)

risk_score <- merge(deaths, recovered, by = "Group.1")
risk_score <- merge(risk_score, confirmed, by = "Group.1")
colnames(risk_score) = c("Country.Region", "Total.Deaths", "Total.Recovered", "Total.Confirmed")
risk_score$Risk.Score <- risk_score$Total.Deaths / risk_score$Total.Recovered
risk_score$Death.Burden <- risk_score$Risk.Score * risk_score$Total.Confirmed

# NDL -- global values

Global_Risk_Score <- sum(risk_score$Total.Deaths) / sum(risk_score$Total.Recovered)
Global_Death_Burden <- sum(risk_score$Total.Confirmed) * Global_Risk_Score

# NDL -- end this objective by discussing comparisons 

# NDL -- look at highest 5 risk score countrues


# OBJECTIVE 4.2








