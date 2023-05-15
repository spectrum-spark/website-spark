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

# Building

The website can be built using

```
quarto render
```

and will output to the `_site` directory. The website is hosted using GitHub pages, so commits on the `release` branch will update the public-facing website.

Note that the information for people, publications and projects are held in restricted access Google Sheets, and you will need to set up authentication using both `googledrive` and `googlesheets4` before you will be able to update the behind the scenes data.