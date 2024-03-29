<!-- badges: start -->
[![R build status](https://github.com/JohnCoene/linne/workflows/R-CMD-check/badge.svg)](https://github.com/JohnCoene/linne/actions)
[![Travis build status](https://travis-ci.com/JohnCoene/linne.svg?branch=master)](https://travis-ci.com/JohnCoene/linne)
[![AppVeyor build status](https://ci.appveyor.com/api/projects/status/github/JohnCoene/linne?branch=master&svg=true)](https://ci.appveyor.com/project/JohnCoene/linne)
[![Coveralls test coverage](https://coveralls.io/repos/github/JohnCoene/linne/badge.svg)](https://coveralls.io/r/JohnCoene/linne?branch=master)
[![Github Sponsor](https://img.shields.io/badge/Sponsor--pink?style=flat-square&logo=github)](https://github.com/sponsors/JohnCoene)
<!-- badges: end -->

# linne

<img src="logo.png" style="max-height:250px;float:right;" align="right"/>

linne makes basic CSS easier for R users. It is intended as a stepping stone to actually writing CSS and Sass.

> Linne is old Gaelic for cascade

<a href="articles/get-started.html" class="btn btn-primary">Get Started</a>

## Installation

Install the stable version from CRAN.

``` r
install.packages("linne")
```

Or install the development version from Github.

``` r
# install.packages("remotes")
remotes::install_github("JohnCoene/linne")
```

## Example

Using linne to place a floating logo in the top right of a shiny app.

```r
library(shiny)
library(linne)

linne <- Linne$
  new()$
  rule(
    sel_id("logo"), # select id = logo
    position = "absolute",
    top = 20,
    right = 20,
    maxHeight = 75,
    zIndex = 9999
  )

ui <- fluidPage(
  linne$include(),
  h2("Basic usage of {linne}"),
  img(src = "https://www.r-project.org/logo/Rlogo.png", id = "logo"),
  plotOutput("plot")
)

server <- function(input, output){
  output$plot <- renderPlot(plot(cars))
}

shinyApp(ui, server)
```

![Example of linne](man/figures/example.png)
