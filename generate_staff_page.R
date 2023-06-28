generate_staff_page <- function(staff_member, overwrite = FALSE) {
    # Check if file exists
    consortia <- staff_member[["consortia"]] |> pull()
    output_path <- file.path("staff", paste0(staff_member[["id"]], ".qmd"))
    if (file.exists(output_path) & !overwrite) {
        warning(glue::glue("File {output_path} already exists. Set `overwrite=TRUE` or check carefully"))
        return(NULL)
    }



    template <- paste(readLines("_helpers/staff-template.qmd"), collapse = "\n")

    template <- stringr::str_replace_all(template, "INPUT_STAFF_ID", staff_member[["id"]]) |>
        stringr::str_replace_all("INPUT_EMAIL", staff_member[["email"]] |> pull()) |>
        stringr::str_replace_all("INPUT_EXTERNAL_LINK", staff_member[["external_link"]]) |>
        stringr::str_replace_all("INPUT_STAFF_NAME", staff_member[["name"]])

    output <- whisker::whisker.render(template)

    writeLines(output, output_path)
}

source("load_data.R")

for (staff_member in staff_list) {
    if (staff_member$internal_link)
        generate_staff_page(staff_member)
}
