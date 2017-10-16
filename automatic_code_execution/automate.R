# header ------------------------------------------------------------------

# R Script to collect code examples for automatic daily execution of code
# Lars Schoebitz
# MIT Licence
# 16.10.2017


# comments ----------------------------------------------------------------

# 16.10.17: Blog post: https://www.r-bloggers.com/scheduling-r-scripts-and-processes-on-windows-and-unixlinux/
# 16.10.17: R package: https://github.com/bnosac/cronR


# clear R's brain ---------------------------------------------------------

rm(list = ls())

# load libraries ----------------------------------------------------------

library(tidyverse)
library(lubridate)
library(cronR)

## get current point in time

time_point = Sys.time()

## get time point for saving as file name

paste_time_point <- time_point %>% 
    as.tibble() %>% 
    separate(value, into = c("date", "time"), sep = " ") %>% 
    unite(value, c("date", "time"), sep = "_") %>% 
    .$value

## paste file name

file_name <- paste("random_data_frame_", paste_time_point, ".rds", sep = "")

## create list of random numbers

test_list = list()

for (i in seq(1:730)) {
    
    test_list[[i]] = tibble(
        id = i,
        current_date_time = time_point,
        date = as.Date(current_date_time),
        year = year(current_date_time),
        month = month(current_date_time),
        day =  day(current_date_time),
        hour = hour(current_date_time),
        minute = minute(current_date_time),
        second = second(current_date_time),
        value = rnorm(n = 1, mean = 35, sd = 14)
    )
    
    time_point = time_point - 24 * 60 * 60
    
}

## combine list of random numbers

df <- do.call("rbind", test_list) 

## write rds file to folder

write_rds(x = df, path = paste("/home/larnsce/Dropbox/R/R-playground/automatic_code_execution/data", file_name, sep = "/"))


