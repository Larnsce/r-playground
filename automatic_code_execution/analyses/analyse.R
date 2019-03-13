# header ------------------------------------------------------------------

# R Script to analyse data
# Lars Schoebitz
# MIT Licence
# 16.10.2017


# comments ----------------------------------------------------------------

# clear R's brain ---------------------------------------------------------

rm(list = ls())

# load libraries ----------------------------------------------------------

library(tidyverse)
library(lubridate)

# load data ---------------------------------------------------------------

source(file = "automatic_code_execution/write/write.R")

# analyse data ------------------------------------------------------------

db_random %>% 
    mutate(
        month = as.factor(month)
    ) %>% 

ggplot(aes(x = month, y = value)) +
    geom_boxplot() +
    facet_wrap(~year)
    

db_random %>% 
    filter(year == 2016) %>%  
    group_by(month, day) %>% 
    summarise(
        min_minute = min(value),
        max_minute = max(value)
    ) %>%
    gather(key = variable, value = value, min_minute:max_minute) %>% 
    ggplot(aes(x = day, y = value, color = variable)) +
    geom_point() +
    geom_line() +
    facet_wrap(~month)
    
    