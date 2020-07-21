#' Convenience Functions
#' 
#' Convenience functions for common operations.
#' 
#' @param value Value to use.
#' @param r,g,b,a Red, green, blue, and alpha values.
#' 
#' @section Functions:
#' 
#' * [important_()] - Makes it such that the rule cannot be overwritten by other rules (other selections).
#' * [rgb_()], [rgba_()] - Functions for red, green, blue and alpha for transparency.
#' * [url_()] - Wrap in a `url` CSS function call.
#' 
#' @examples 
#' Linne$
#'  new()$
#'  rule(
#'    sel_id("id"),
#'    color = rgba_(255, 255, 255, .6),
#'    fontSize = important_(20)
#'  )
#' 
#' @name convenience
#' @export 
important_ <- function(value){
  if(inherits(value, "numeric") || inherits(value, "integer"))
    value <- sprintf("%spx", value)
  sprintf("%s !important", value)
}

#' @rdname convenience
#' @export 
url_ <- function(value){
  sprintf("url(%s)", value)
}

#' @rdname convenience
#' @export 
rgb_ <- function(r, g, b){
  sprintf("rgb(%s,%s,%s)", r, g, b)
}

#' @rdname convenience
#' @export 
rgba_ <- function(r, g, b, a = .5){
  sprintf("rgba(%s,%s,%s,%s)", r, g, b, a)
}
