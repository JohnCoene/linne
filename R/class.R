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
#' @param id,class,tag Bare name of the id, class, or tag to change,
#' used to define the selector. Specify only of `id`, `class`, or `tag`.
#' @param ... Declarations: properties and their values. This accepts
#' camelcase, e.g.: `font-style` or `fontStyle`.
#' 
#' @section Selectors:
#' Using the `change` method on an `id` will only apply the style to
#' that one specific element bearing the `id`. Using it on a `class`,
#' or `tag` changes all elements bearing said class or of said tag.
#' 
#' * Change `textInput(id = "hello")` with `id = hello`
#' * Change `h1(class = "shiny")` with `class = shiny`
#' * Change `p("Hello")` with `tag = p`
#' 
#' @return Self: the `Gaius` object.
#' 
#' @examples
#' Gaius$new()$change(id = myButton, color = "blue", fontSize = 50)
    change = function(..., id, class, tag){

      # enquo
      q_id <- rlang::enquo(id)
      q_class <- rlang::enquo(class)
      q_tag <- rlang::enquo(tag)

      # checks
      selection <- sum(c(rlang::quo_is_missing(q_id), rlang::quo_is_missing(q_class), rlang::quo_is_missing(q_tag)))
      if(selection == 3) stop("Must pass one of `id`, `class`, or `tag`", call. = FALSE)
      if(selection < 2) stop("Must specify only one of `id`, `class`, or `tag`", call. = FALSE)

      # selector
      selector <- make_selector(q_id, q_class, q_tag)

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
#'    id = myButton, 
#'    color = "blue", 
#'    fontSize = 50
#'  )$
#'  change(
#'    class = "container",
#'    backgroundColor = "$primary_color"
#'  )$
#'  build()
    build = function(){
      private$.css <- parse_changes(chg = private$.changes, def = private$.definitions)
      return(self)
    },
#' @details Prints Generated CSS
#' 
#' @examples
#' Gaius$new()$change(id = myButton, color = "blue")$print_css()
    print_css = function(){
      if(is.null(private$.css))
        self$build()

      cat(private$.css)
      
      invisible(self)
    },
    include = function(){
      if(is.null(private$.css))
        self$build()
      
      min <- minify(private$.css)

      htmltools::singleton(
        htmltools::tags$style(min)
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


