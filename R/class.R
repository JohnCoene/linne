#' Linne
#' 
#' @export 
Linne <- R6::R6Class(
  "Linne",
  public = list(
#' @details Define variables.
#' 
#' @param ... Named variables to define.
#' 
#' @return Self: the `Linne` object.
#' 
#' @examples
#' Linne$new()$define(baseColor = "blue")
    define = function(...){

      # capture
      def <- define(...)

      # check
      private$.check_definitions(new_def = def)

      # process
      definition <- process_definitions(def)

      # store
      private$.definitions <- append(private$.definitions, definition)
      invisible(self)
    },
#' @details Change
#' 
#' @param selector An object of class `selector` as returned by the `sel_*` family of functions.
#' @param ... Declarations: properties and their values. This accepts
#' camelcase, e.g.: `font-style` or `fontStyle`. 
#' 
#' @section Attributes:
#' There are hundreds of attributes to pass to the three-dotconstruct (`...`), 
#' a comprehensive list of them can be found on 
#' [w3schools](https://www.w3schools.com/cssref/).
#' 
#' Linne accepts camelcase for convenience, e.g.: `font-size` or `fontSize`.
#' 
#' @return Self: the `Linne` object.
#' 
#' @examples
#' Linne$new()$change(sel_id("myButton"), color = "blue", fontSize = 50)
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
#' Linne$
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
      private$.build()
      invisible(self)
    },
#' @details Prints Generated CSS
#' 
#' @param build Whether to build the CSS with the `build` method.
#' 
#' @examples
#' Linne$new()$change(sel_id("myButton"), color = "blue")$show_css()
    show_css = function(build = TRUE){
      if(build) self$build()

      cat(private$.css)
      
      invisible(self)
    },
#' @details Import
#' 
#' Import from a url or path, generally a font.
#' 
#' @param url URL to import.
#' 
#' @examples 
#' Linne$new()$import('https://fonts.googleapis.com/css2?family=Roboto')
    import = function(url){
      not_missing(url)
      private$.imports <- c(private$.imports, url)
      invisible(self)
    },
#' @details Include in Shiny
#' 
#' Includes the CSS in shiny, place the call to this method anywhere in the shiny UI.
#' 
#' @param build Whether to build the CSS with the `build` method.
#' 
#' @examples 
#' # generate CSS
#' css <- Linne$
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
    include = function(build = TRUE){
      if(build) self$build()
      
      min <- private$.minified()

      htmltools::singleton(
        htmltools::tags$head(
          htmltools::tags$style(min)
        )
      )
    },
#' @details Save
#' 
#' Write the CSS to file.
#' 
#' @param build Whether to build the CSS with the `build` method.
#' @param path Path to file.
#' @param pretty Whether to keep tabs and newlines.
#' 
#' @examples
#' \dontrun{Linne$new()$change(sel_id("id"), fontStyle = "italic")$write("styles.css")}
    write = function(path = "style.css", pretty = FALSE, build = TRUE){
      if(build) self$build()

      if(!pretty)
        css <- private$.minified()
      else 
        css <- private$.css
      
      path <- file_name(path)

      writeLines(css, con = path)

    },
#' @details Print
#' 
#' Prints information on the Linne object. 
    print = function(){
      defs <- length(private$.definitions)
      changes <- length(private$.changes)
      has_css <- !is.null(private$.css)

      # intro
      cli::cli_h2("Linne")
      cat("\n")
      cli::cat_bullet("Definition(s): ", defs)
      cli::cat_bullet("Change(s): ", changes)
      cli::cat_bullet("Built: ", has_css)
      
      cat("\n")

      cli::cli_alert_info("Use `show_css` method to see the CSS")

      invisible(self)
    },
#' @details Inject CSS
#' 
#' Dynamically inject CSS from the server of a shiny application.
#' 
#' @param build Whether to build the CSS with the `build` method.
#' @param session A valid shiny session.
#' 
#' @examples 
#' library(shiny)
#' 
#' ui <- fluidPage(
#'   useLinne(),
#'   actionButton("change", "Change me!")
#' )
#' 
#' server <- function(input, output){
#' 
#'   linne <- Linne$
#'     new()$
#'     change(
#'       sel_id("change"),
#'       color = "white",
#'       backgroundColor = "black"
#'     )
#' 
#'   observeEvent(input$change, {
#'     linne$inject()
#'   })
#' 
#' }
#' 
#' if(interactive())
#'  shinyApp(ui, server)
#' 
    inject = function(build = TRUE, session = shiny::getDefaultReactiveDomain()){
      
      if(interactive())
        cli::cli_alert_warning("Remember to place `useLynn` in your shiny UI.")

      if(build ) self$build()

      session$sendCustomMessage("line-inject", private$.css)

      invisible(self)
    }
  ),
  private = list(
    .css = NULL,
    .imports = c(),
    .changes = list(),
    .definitions = list(),
    .minified = function(){
      gsub("\\n|\\t", "", private$.css)
    },
    # checks that definitions do not already exist
    .check_definitions = function(new_def){
      duplicates <- names(new_def) %in% names(private$.definitions)

      if(!any(duplicates))
        return()

      msg_stop <- paste0("'", names(new_def)[duplicates], "' already defined", collapse = "', '")  
      stop(msg_stop, call. = FALSE)
    },
    # build internal
    .build = function(){
      # process changes
      chg <- purrr::map(private$.changes, chg2css, private$.definitions)
      
      css <- ""
      if(length(private$.imports))
        css <- sprintf("@import url('%s');\n", private$.imports)

      changes <- paste0(unlist(chg), collapse = "\n")

      private$.css <- paste0(css, changes, collapse = "\n")
      invisible()
    }
  )
)


