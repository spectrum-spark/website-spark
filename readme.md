# SPARK Website Files

Contains scripts and files to render the SPARK consortium website (htttps://www.spark.edu.au)

# Contributing

The website is built using [https://quarto.org/](Quarto) and the R package [https://github.com/MikeLydeamore/condensr](`condensr`). Both will need to be installed before you are able to build the site.

This project uses [https://rstudio.github.io/renv/index.html](`renv`) to manage dependencies. Install renv using:

```
install.packages("renv")
renv::restore()
```

and dependencies should be set up for you. If you change a package version or add a package, please call `renv::shapshot()` to update for all users.

## Updating backend data

The backend data can be updated by calling

```
quarto run update_data.R
```
which will output new CSVs: `project_list.csv`, `staff_list.csv` and `publication_list.csv`. These are in turn read in by `load_data.R` as part of the build script.

If new consortia members are added, their photo will also need to be pulled down from the shared drive. Please call `quarto run copy_images.R` for this to happen. This script takes a few minutes, so is _not_ part of the build process.

## Creating a new staff member page

To make a new staff member page, inside an R session, call

```
generate_staff_page(staff_member)
```

where `staff_member` is an object from `staff_list`, loaded by `load_data.R`. This script will automatically check if the page exists, and if it doesn't, will make one for you. You will still need to add external links (like email, Twitter, LinkedIn etc), which is done inside the newly created qmd file.

# Building

The website can be built using

```
quarto render
```

and will output to the `_site` directory. The website is hosted using GitHub pages, so commits on the `release` branch will update the public-facing website.

Note that the information for people, publications and projects are held in restricted access Google Sheets, and you will need to set up authentication using both `googledrive` and `googlesheets4` before you will be able to update the behind the scenes data.