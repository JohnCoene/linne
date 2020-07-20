#' State
#' 
#' Narrows selection to a specific state, e.g.: when it is hovered.
#' 
#' @param selector as returned by [selectors].
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

whens <- function(selector, prefix) UseMethod("whens")

whens.selector <- function(selector, suffix){
  construct_selector("%s:%s", selector, suffix)
}