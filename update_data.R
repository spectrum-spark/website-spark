library(dplyr)
library(googlesheets4)
library(tidyr)
library(readr)

consortia <- "spark"

staff_csv <- read_sheet("https://docs.google.com/spreadsheets/d/1sVQZRazo_zGcQkgP_WhMsIEhnye1Cr4l5b8Tqi8pVq8/edit#gid=303417326") |>
    filter(!is.na(id)) |>
    separate_longer_delim(c(staff_type, consortia), delim = ",")

purrr::map(
    .x = consortia,
    .f = function(consort) {
        write_csv(
            x = staff_csv |>
                filter(consortia == consort),
            file = here::here("staff_list.csv")
        )
    }
)

project_csv <- read_sheet("https://docs.google.com/spreadsheets/d/1gWI11et_xMwPXsoLdMXbp6NlOFQVqRztpSTIzL4GtR0/edit#gid=0") |>
    separate_longer_delim(c(consortia), delim = ",")

purrr::map(
    .x = consortia,
    .f = function(consort) {
        write_csv(
            x = project_csv |>
                filter(consortia == consort),
            file = here::here("project_list.csv")
        )
    }
)



publication_csv <- read_sheet("https://docs.google.com/spreadsheets/d/1VIFfbKhJBtZJQX91CAceiBEJSeMs9CbpUe_qclfS4GM/edit#gid=0")

purrr::map(
    .x = consortia,
    .f = function(consort) {
        write_csv(
            x = publication_csv,
            file = here::here("publication_list.csv")
        )
    }
)
