library(condensr)
library(dplyr)
library(googlesheets4)
library(tidyr)
library(readr)

staff_csv <- read_csv(here::here("staff_list.csv"),
    col_types = cols(
        id = col_character(),
        name = col_character(),
        description = col_character(),
        external_link = col_character(),
        internal_link = col_logical(),
        staff_type = col_character(),
        role_in_ss = col_character(),
        role_in_org = col_character(),
        location = col_character(),
        organisation = col_character(),
        email = col_character(),
        bio = col_character(),
        external_link2 = col_character(),
        consortia = col_character()
    )
)

staff_list <- lapply(1:nrow(staff_csv), function(i) {
    member <- staff_member(
        id = staff_csv[i, "id"] %>% pull(),
        name = staff_csv[i, "name"] %>% pull(),
        description = if_else(
            is.na(staff_csv[i, "role_in_ss"] %>% pull()),
            stringr::str_to_sentence(staff_csv[i, "staff_type"] %>% pull()),
            staff_csv[i, "role_in_ss"] %>% pull()
        ),
        external_link = staff_csv[i, "external_link"] %>% pull(),
        internal_link = staff_csv[i, "internal_link"] %>% pull()
    )
    member[["staff_type"]] <- staff_csv[i, "staff_type"]
    member[["bio"]] <- paste(
        paste("###", staff_csv[i, c("role_in_org", "organisation")], collapse = "\n\n"),
        "\n\n",
        staff_csv[i, "bio"],
        collapse = "\n\n"
    )
    member[["email"]] <- staff_csv[i, "email"]
    member[["consortia"]] <- staff_csv[i, "consortia"]

    return(member)
})
names(staff_list) <- staff_csv[, "id"] %>% pull()

project_csv <- read_csv(here::here("project_list.csv"),
    col_types = cols(
        project_name = col_character(),
        related_staff = col_character(),
        start_date = col_datetime(format = ""),
        end_date = col_datetime(format = ""),
        description = col_character(),
        consortia = col_character()
    )
)

project_list <- lapply(1:nrow(project_csv), function(i) {
    proj <- project(
        id = project_csv[i, "project_name"] %>% pull(),
        name = project_csv[i, "project_name"] %>% pull(),
        related_staff = stringr::str_trim(stringr::str_split(project_csv[i, "related_staff"], ",")[[1]]),
        link = "../projects.html"
    )

    proj[["start_date"]] <- project_csv[i, "start_date"]
    proj[["end_date"]] <- project_csv[i, "end_date"]
    proj[["description"]] <- project_csv[i, "description"]

    return(proj)
})



publication_csv <- read_csv(here::here("publication_list.csv"),
    col_types = cols(
        title = col_character(),
        related_staff = col_character(),
        link = col_character(),
        consortia = col_character(),
        date = col_datetime(format = ""),
        citation = col_character()
    )
)

publication_list <- lapply(1:nrow(publication_csv), function(i) {
    publication(
        title = publication_csv[i, "title"] %>% pull(),
        related_staff = stringr::str_trim(stringr::str_split(publication_csv[i, "related_staff"], ",")[[1]]),
        link = publication_csv[i, "link"] %>% pull(),
        citation = publication_csv[i, "citation"] %>% pull(),
        date = as.Date(publication_csv[i, "date"] %>% pull())
    )
})

publication_list <- publication_list[
    order(sapply(publication_list, "[[", "date"), decreasing = TRUE)
]
