#' Gaius
#' 
#' @export 
Gaius <- R6::R6Class(
  "Gaius",
  public = list(
#' @details Define variables.
#' 
#' @param ... Named variables to define.
#' 
#' @return Self: the `Gaius` object.
#' 
#' @examples
#' Gaius$new()$define(baseColor = "blue")
    define = function(...){

      def <- define(...)
      definition <- process_definitions(def)

      private$.definitions <- append(private$.definitions, definition)
      invisible(self)
    },
#' @details Change
#' 
#' @param selector An object of class `selector` as returned by the `sel_*` family of functions.
#' @param ... Declarations: properties and their values. This accepts
#' camelcase, e.g.: `font-style` or `fontStyle`.
#' 
#' @return Self: the `Gaius` object.
#' 
#' @examples
#' Gaius$new()$change(sel_id("myButton"), color = "blue", fontSize = 50)
    change = function(selector, ...){

      # enquo
      if(missing(selector))
        stop("Missing `selector`, see `sel_*` family of functions", call. = FALSE)

      change <- list(
        selector = selector,
        change = define(...)
      )

      private$.changes <- append(private$.changes, list(change))

      invisible(self)

    },
#' @details Builds CSS
#' 
#' Builds the CSS from definitions and changes.
#' 
#' @details 
#' Gaius$
#'  new()$
#'  define(primary_color = 'red')$
#'  change(
#'    sel_id("myButton"), 
#'    color = primary_color, 
#'    fontSize = 50
#'  )$
#'  change(
#'    sel_class("container"),
#'    backgroundColor = primary_color
#'  )$
#'  build()
    build = function(){
      private$.css <- parse_changes(chg = private$.changes, def = private$.definitions)
      return(self)
    },
#' @details Prints Generated CSS
#' 
#' @examples
#' Gaius$new()$change(sel_id("myButton"), color = "blue")$print_css()
    print_css = function(){
      if(is.null(private$.css))
        self$build()

      cat(private$.css)
      
      invisible(self)
    },
#' @details Include in Shiny
#' 
#' Includes the CSS in shiny, place the call to this method anywhere in the shiny UI.
#' 
#' @examples 
#' # generate CSS
#' css <- Gaius$
#'   new()$
#'   define(grey = '#c4c4c4')$
#'   change(
#'     sel_id("myButton"), 
#'     backgroundColor = 'red', 
#'     fontSize = 20,
#'     color = grey
#'   )$
#'   change(
#'     sel_class("aClass"),
#'     color = grey
#'   )
#' 
#' # include in an app
#' library(shiny)
#' 
#' ui <- fluidPage(
#'   css$include(),
#'   h1("Some text", class = "aClass"),
#'   actionButton("myButton", "Am I red?", class = "aClass")
#' )
#' 
#' server <- function(input, output){
#'   output$myPlot <- renderPlot(plot(cars))
#' }
#' 
#' if(interactive())
#'  shinyApp(ui, server)
#' 
#' @return [htmltools::tags]
    include = function(){
      if(is.null(private$.css))
        self$build()
      
      min <- minify(private$.css)

      htmltools::singleton(
        htmltools::tags$head(
          htmltools::tags$style(min)
        )
      )
    },
#' @details Print
#' 
#' Prints information on the Gaius object. 
    print = function(){
      defs <- length(private$.definitions)
      changes <- length(private$.changes)
      has_css <- !is.null(private$.css)

      # intro
      cli::cli_h2("Gaius")
      cat("\n")
      cli::cat_bullet("Definition(s): ", defs)
      cli::cat_bullet("Change(s): ", changes)
      cli::cat_bullet("Built: ", has_css)
      
      cat("\n")

      cli::cli_alert_info("Use `print_css` method to see the CSS")

      invisible(self)
    }
  ),
  private = list(
    .css = NULL,
    .changes = list(),
    .definitions = list()
  )
)


