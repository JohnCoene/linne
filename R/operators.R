#' Infixes
#' 
#' Convenient pipes for more sophisticated selectors.
#' 
#' @param lhs,rhs Selectors as returned by `sel_*` family of functions.
#' 
#' @section Operators:
#' 
#' * [`%child%`] - Selects elements where right hand is child of left hand, e.g.: `sel_tag('div') %child% sel_class('aClass')` selects elements with `aClass` who are direct children of `div` tags.
#' * [`%or%`] - Select left hand or right hand, e.g.: `sel_id('myId') %or% sel_class('myClass')` will select both the element with the id and elements with the class. Ideal to select and apply rules multiple elements at once.
#' * [`%with%`] - Left hand selector with right hand selector, e.g.: `sel_tag('div') %with% sel_class('aClass')` selects a `div` with a class of `aClass`. Ideal to narrow down the selection.
#' 
#' @examples
#' # select all paragraph 'p' with "red" class
#' sel_tag("p") %with% sel_class("red")
#' 
#' # the other way around works equally well
#' sel_class("red") %with% sel_tag("p")
#' 
#' # select multiple elements
#' # where id = "x" or class = "center" 
#' sel_id("x") %or% sel_class("center")
#' 
#' # select element with id = "x" and parent's id = "y"
#' sel_id("y") %child% sel_id("y")
#' 
#' @name pipes
#' @export
`%child%` <- function(lhs, rhs){
  construct_selector("%s %s", lhs, rhs)
}

#' @name pipes
#' @export
`%or%` <- function(lhs, rhs){
  construct_selector("%s,%s", lhs, rhs)
}

#' @name pipes
#' @export
`%with%` <- function(lhs, rhs){
  construct_selector("%s%s", lhs, rhs)
}