# header ------------------------------------------------------------------

# R Script to write combined dataset
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

files <- list.files(path = "automatic_code_execution/data/")

read_data <- list()

for (i in seq_along(files)) {
    
    data <- paste("automatic_code_execution/data/", files[i], sep = "")
    read_data[[i]] <- read_rds(path = data)
}

db_random <-  do.call("rbind", read_data)

