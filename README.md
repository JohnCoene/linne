<div align="center">

<img src="man/figures/logo.png" height="250px" />

<!-- badges: start -->
[![R build status](https://github.com/JohnCoene/linne/workflows/R-CMD-check/badge.svg)](https://github.com/JohnCoene/linne/actions)
[![Travis build status](https://travis-ci.com/JohnCoene/linne.svg?branch=master)](https://travis-ci.com/JohnCoene/linne)
[![AppVeyor build status](https://ci.appveyor.com/api/projects/status/github/JohnCoene/linne?branch=master&svg=true)](https://ci.appveyor.com/project/JohnCoene/linne)
[![Coveralls test coverage](https://coveralls.io/repos/github/JohnCoene/linne/badge.svg)](https://coveralls.io/github/JohnCoene/linne)
<!-- badges: end -->

CSS in R

[Website](https://linne.john-coene.com/) | [Get Started](https://linne.john-coene.com/articles/get-started.html)

</div>

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

linne <- Linne$new()
```

There are two core methods to {linne}:

- `define` - Define a global variable
- `rule` - Add a CSS rule

Let's say you want to change the look and feel of this button in a shiny application.

```r
actionButton(inputId = "myButton", label = "Click me")
```

Using {linne} we define a CSS rule with the `rule` method to change how it looks.

```r
library(linne)

linne <- Linne$
  new()$
  rule(
    sel_input("myButton"), # inputId = "myButton"
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
  linne$include(), # include the CSS
  actionButton(inputId = "myButton", label = "Click me")
)

server <- function(input, output){}

shinyApp(ui, server)
```

## Code of Conduct

Please note that the linne project is released with a [Contributor Code of Conduct](https://linne.john-coene.com/CODE_OF_CONDUCT.html). By contributing to this project, you agree to abide by its terms.
