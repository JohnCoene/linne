#' Infixes
#' 
#' Convenient pipes for more sophisticated selectors.
#' 
#' @param lhs,rhs Selectors as returned by `sel_*` family of functions.
#' 
#' @section Operators:
#' 
#' * [`%child%`] - Adds left hand as child of right hand.
#' * [`%or%`] - Select left hand or right hand, ideal to select multiple elements at once.
#' * [`%and%`] - Select left hand and right hand, ideal to narrow down the selection.
#' 
#' @examples
#' # select all paragraph 'p' where class = "red"
#' sel_tag("p") %and% sel_class("red")
#' 
#' # the other way around works equally well
#' sel_class("red") %and% sel_tag("p")
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
  construct_selector("%s>%s", lhs, rhs)
}

#' @name pipes
#' @export
`%or%` <- function(lhs, rhs){
  construct_selector("%s,%s", lhs, rhs)
}

#' @name pipes
#' @export
`%and%` <- function(lhs, rhs){
  construct_selector("%s%s", lhs, rhs)
}