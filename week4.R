testfun <- function(){}
testfun()
## NULL

class(testfun)
## [1] "function"

testfun <- function(){print("this function does nothing")}

testfun()
## [1] "this function does nothing"

testfun <- function(sometext){print(sometext)}

testfun(sometext = "this function does slightly more, but still not much")
## [1] "this function does slightly more, but still not much"

my_age <- function(birthday, units){
  difftime(Sys.time(),birthday, units = units)
}

my_age(birthday = "1995-02-10", units = "days")
## Time difference of 9603.564 days
my_age <- function(birthday, units = "days"){
  difftime(Sys.time(),birthday, units = units)
}

# if not stated otherwise, our function uses the unit "days"
my_age("1995-02-10")
## Time difference of 9603.565 days

# We can still overwrite units
my_age("1995-02-10", "hours")
## Time difference of 230485.6 hours

# Task 1: Write your own function
euclidian_distance <- function(x1, y1, x2, y2){ sqrt((x1-x2)^2+(y1-y2)^2)}


# Task 2: Prepare Analysis
library(readr)        
library(dplyr)        
library(ggplot2)      
library(lubridate)

# Task 3: Create Join Key
wildschwein <- read_delim("wildschwein_BE_2056.csv",",")
wildschwein <- wildschwein %>% 
mutate(roundtime_15 = round_date(DatetimeUTC,"15mins"))
head(wildschwein)

# Task 4: Measuring distance at concurrent locations
split_by_individual <- split(wildschwein, wildschwein$TierID)
Sabi <- split_by_individual[["002A"]]
Rosa <- split_by_individual[["016A"]]
Ruth <- split_by_individual[["018A"]]
joined_indivduals <- inner_join(Sabi, Rosa, "roundtime_15", suffix = c(".Sabi", ".Rosa"))
joined_indivduals <- joined_indivduals %>%
mutate(
individ_dist = euclidian_distance(E.Sabi, N.Sabi, E.Rosa, N.Rosa),
meets = ifelse(individ_dist <= 100, TRUE, FALSE),
E = (E.Sabi + E.Rosa)/2, #Point in the middle when meeting
N = (N.Sabi + N.Rosa)/2)
meeting_points <- subset(joined_indivduals, meets == TRUE, select = c(E.Sabi, N.Sabi, E.Rosa, N.Rosa, individ_dist, roundtime_15, meets, E, N))

# Task 5: Visualize data
wildschwein_subset <- subset(wildschwein, TierName == "Sabi" | TierName == "Rosa" )
ggplot()+
geom_point(data = wildschwein_subset, aes(x = E, y = N, color = TierName), alpha = 0.2, inherit.aes = F)+
geom_point(data = meeting_points, aes(x = E, y = N, colour = meet), shape = 1, fill = NA, color = "black")+
xlim(2569250, 2571000)+
ylim(1204000, 1206500)+
coord_fixed()

# Task 6: Visualize data as timecube with plotly

