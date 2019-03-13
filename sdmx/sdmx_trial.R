## HEADER ------------------------------------------------------------

# R script to query EUROSTAT SDMX REST API - trial script
# Created by Lars Schoebitz
# MIT Licence
# 16.08.2017

## COMMENTS ----------------------------------------------------------

# 16.08.2017: followed this tutorial: https://stackoverflow.com/a/26476190/6816220

# clear R's brain ---------------------------------------------------------------------------------

rm(list = ls())

# load packages -----------------------------------------------------------------------------------

library(tidyverse)
library(purrr)
library(xml2)
library(rsdmx)

# source data ---------------------------------------------------------------------------------------


## EUROSTAT env_ww_genv -----------------

# Step 1: Get DSD codelist

# SDMX DataStructureDefinition (DSD)
#-----------------------------------

# ESTAT embedded providers
dsd <- readSDMX(providerId = "ESTAT", resource = "datastructure",
                resourceId = "DSD_env_ww_genv")

# get codelists from DSD
cls <- slot(dsd, "codelists")
codelists <- sapply(slot(cls, "codelists"), slot, "id") #get list of codelists

# get a codelist and save as list

codelist <- list()

for (i in seq_along(codelists)) {
    
    codelist[[i]] <- as.data.frame(cls, codelistId = codelists[i])
}

## extract codelist for ww_gtd join
ww_gtd_meta <- as_tibble(codelist[[6]])


# Step 2: Construct REST query -----------------

resource    <- "data"
dataflow    <- "env_ww_genv"
key         <- "...."
time_filter <- "?startperiod=2010"

# Construct the query

partial_url <- paste(paste(resource, dataflow, key, sep="/"), time_filter, sep="")
base_url    <- "http://ec.europa.eu/eurostat/SDMX/diss-web/rest/"
rest_query  <- paste(base_url, partial_url, sep="")

sdmx <- readSDMX(rest_query)
stats <- as.data.frame(sdmx)


### trying out other code -------------

## this doesnt work

myUrl <- "http://data.fao.org/sdmx/repository/data/CROP_PRODUCTION/.156.5312../FAO?startPeriod=2008&endPeriod=2008"
dataset <- readSDMX(myUrl)
stats <- as.data.frame(dataset)

## this doesn't work either

myUrl <- "http://ec.europa.eu/eurostat/SDMX/diss-web/rest/data/cdh_e_fos/..PC.FOS1.BE/?startperiod=2005&endPeriod=2011"
dataset <- readSDMX(myUrl)
stats <- as.data.frame(dataset)

# Step 2: Construct REST query -----------------

## http://ec.europa.eu/eurostat/SDMX/diss-web/rest/data/cdh_e_fos/..PC.FOS1.BE?startperiod=2005&endPeriod=2011

resource    <- "data"
dataflow    <- "cdh_e_fos"
key         <- "..PC.FOS1.BE"
time_filter <- "?startperiod=2005&endPeriod=2011"

# Construct the query

partial_url <- paste(paste(resource, dataflow, key, sep="/"), time_filter, sep="")
base_url    <- "http://ec.europa.eu/eurostat/SDMX/diss-web/rest/"
rest_query  <- paste(base_url, partial_url, sep="")

sdmx <- readSDMX(rest_query)
stats <- as.data.frame(sdmx)