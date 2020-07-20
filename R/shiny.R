#' Dependency
#' 
#' Imports dependencies necessary for the `inject` method to work. 
#' Pace this function in your shiny UI.
#' 
#' @export
useLinne <- function(){
  shiny::singleton(
    shiny::tags$head(
      shiny::tags$style(id = "linne-injected-styles"),
      shiny::tags$script(src = "line-assets/linne.js")
    )
  )
}