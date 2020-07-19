<div>

<!-- badges: start -->
<!-- badges: end -->

# gaius

</div>

Gaius aims to make CSS familiar to R users of  the R markdown and shiny packages.

## Installation

Install the Github version.

``` r
# install.packages("remotes")
remotes::install_github("JohnCoene/gaius")
```

## Example

{gaius} contains a single reference class which comes with just a few core methods. Always start with the `new` method to instantiate a new class.

```r
library(gaius)

css <- Gaius$new()
```

There are two core methods to {gaius}:

- `define` - Define a global variable
- `change` - Change the CSS

Let's say you want to change the look and feel of this button in a shiny application.

```r
actionButton(inputId = "myButton", label = "Click me")
```

Using {gaius} we can change some properties of the CSS with `change` method.

```r
library(gaius)

css <- Gaius$
  new()$
  change(
    id = myButton, # inputId = "myButton"
    backgroundColor = 'red', 
    fontSize = 20,
    color = "white"
  )
```

{gaius} will automatically convert integers and numerics to pixels, therefore the above changes the font size to 20 pixels.

```r
library(gaius)
library(shiny)

ui <- fluidPage(
  css$include(), # include the CSS
  actionButton(inputId = "myButton", label = "Click me")
)

server <- function(input, output){}

shinyApp(ui, server)
```

