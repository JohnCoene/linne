#' Convenience Functions
#' 
#' Convenience functions for common operations.
#' 
#' @param value Value to use.
#' @param r,g,b,a Red, green, blue, and alpha values.
#' 
#' @examples 
#' Linne$
#'  new()$
#'  change(
#'    sel_id("id"),
#'    color = rgba(255, 255, 255, .6)
#'  )
#' 
#' @name convenience
#' @export 
important_ <- function(value){
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
  sprintf("url(%s,%s,%s)", r, g, b)
}

#' @rdname convenience
#' @export 
rgba_ <- function(r, g, b, a = .5){
  sprintf("url(%s,%s,%s, %s)", r, g, b, a)
}
