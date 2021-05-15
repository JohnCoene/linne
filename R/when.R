#' State
#' 
#' Narrows selection to a specific state, e.g.: when it is hovered.
#' 
#' @param selector As returned by [selectors].
#' 
#' @name when
#' @export
when_active <- function(selector){
  whens(selector, "active")
}

#' @rdname when
#' @export
when_hover <- function(selector){
  whens(selector, "hover")
}

#' @rdname when
#' @export
when_focus <- function(selector){
  whens(selector, "focus")
}

#' Whens
#' 
#' Conditionals
#' 
#' @param selctor As returned by [selectors].
#' @param suffix Suffix to use.
#' 
#' @keywords internal
#' @noRd 
whens <- function(selector, suffix){
  construct_selector("%s:%s", selector, suffix)
}