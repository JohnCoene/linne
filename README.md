<div style='text-align:center;'>

<!-- badges: start -->
[![R build status](https://github.com/JohnCoene/linne/workflows/R-CMD-check/badge.svg)](https://github.com/JohnCoene/linne/actions)
<!-- badges: end -->

# linne

</div>

Linne aims to make CSS familiar to R users of  the R markdown and shiny packages.

## Installation

Install the Github version.

``` r
# install.packages("remotes")
remotes::install_github("JohnCoene/linne")
```

## Example

{linne} contains a single reference class which comes with just a few core methods. Always start with the `new` method to instantiate a new class.

```r
library(linne)

css <- Linne$new()
```

There are two core methods to {linne}:

- `define` - Define a global variable
- `change` - Change the CSS

Let's say you want to change the look and feel of this button in a shiny application.

```r
actionButton(inputId = "myButton", label = "Click me")
```

Using {linne} we can change some properties of the CSS with `change` method.

```r
library(linne)

css <- Linne$
  new()$
  change(
    sel_id("myButton"), # inputId = "myButton"
    backgroundColor = 'red', 
    fontSize = 20,
    color = "white"
  )
```

{linne} will automatically convert integers and numerics to pixels, therefore the above changes the font size to 20 pixels.

```r
library(linne)
library(shiny)

ui <- fluidPage(
  css$include(), # include the CSS
  actionButton(inputId = "myButton", label = "Click me")
)

server <- function(input, output){}

shinyApp(ui, server)
```

