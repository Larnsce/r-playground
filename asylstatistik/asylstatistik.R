
# description -------------------------------------------------------------



# libraries ---------------------------------------------------------------

library(magrittr)
library(purrr)

get_asyslstatistik_data <- function(year_id = 2020, month_id = 5, file_id = "6-22-Best-VA-Erwerb-d-") {
    
    month_id <- paste0("0", as.character(month_id))
    
    url <- paste0(
        "https://www.sem.admin.ch/dam/sem/de/data/publiservice/statistik/asylstatistik/",
        year_id, "/",
        month_id, "/",
        file_id,
        year_id, "-",
        month_id, 
        ".xlsx.download.xlsx/",
        file_id,
        year_id, "-",
        month_id, 
        ".xlsx"
    )
    
    download.file(url = url, destfile = paste0("asylstatistik/data/raw/", file_id, year_id, "-", month_id, ".xlsx"))
    
    readxl::read_excel(path = paste0("asylstatistik/data/raw/", file_id, year_id, "-", month_id, ".xlsx"), skip = 4) %>% 
        dplyr::select(1:2)
}

get_asyslstatistik_data(month_id = 4)



