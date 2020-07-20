# linne

<img src="logo.png" style="max-height:250px;float:right;" align="right"/>

linne makes basic CSS easier for R users. It is intended as a stepping stone to actually writing CSS and Sass.

> Linne is old Gaelic for cascade

<a href="articles/get-started.html" class="btn btn-primary">Get Started</a>

## Installation

It is not yet on CRAN but is available on Github:

```r
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
  change(
    sel_id("logo"),
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
