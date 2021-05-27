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