library(googledrive)

source("spark/load_data.R")

drive <- shared_drive_find("SPECTRUM-SPARK Website")

staff_pictures <- drive %>%
    drive_ls() %>%
    filter(name == "images") %>%
    pull(id) %>%
    drive_ls() %>%
    pull(id) %>%
    drive_ls()

spark_staff_ids <- staff_csv |> pull(id)

# Clean out directory
unlink(list.files(here::here("spark", "images", "staff"), full.names = T))
for (i in 1:nrow(staff_pictures)) {
    picture_id <- staff_pictures[i, "name"] |>
        pull() |>
        tools::file_path_sans_ext()

    if (picture_id %in% spark_staff_ids) {
        drive_download(
            staff_pictures[i, "id"] %>% pull(),
            path = here::here("spark", "images", "staff", staff_pictures[i, "name"] %>% pull()),
            overwrite = T
        )
    }
}
