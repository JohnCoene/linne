#' Selectors
#' 
#' Create selectors to select particular elements.
#' 
#' @param value Value of selector.
#' @param attribute Name of attribute.
#' @param tag Name of tag.
#' 
#' @details The functions will print in the console the CSS selector they compose.
#' 
#' @section Functions:
#' 
#' * [sel_id()] - Select an object by its id, e.g.: `sel_id('btn')` selects `shiny::actionButton('btn', 'Button')`.
#' * [sel_all()] - Selects everything.
#' * [sel_input()] - Selects an input by its id, e.g.: `sel_id('txt')` selects `shiny::textInput('txt', 'Text')`.
#' * [sel_class()] - Select all elements bearing a specific class, e.g.: `sel_class('cls')`, selects `shiny::h1('hello', class = 'cls')`.
#' * [sel_tag()] - Select all tags, e.g.: `sel_tag('p')` selects `p('hello')`.
#' * [sel_attr()] - Select all tags with a specific attribute.
#' 
#' @examples 
#' # select element where id = x
#' sel_id("x")
#' 
#' # select all elements with class = "container"
#' sel_class("container")
#' 
#' @seealso [`%with%`], [`%or%`], and [`%child%`] as well as
#' [when_active()], [when_hover()], and [when_focus()]
#' for more sophisticated element selection.
#' 
#' @name selectors
#' @export
sel_id <- function(value){
  not_missing(value)
  construct_selector("#%s", value)
}

#' @rdname selectors
#' @export
sel_input <- function(value){
  not_missing(value)
  construct_selector("#%s", value)
}

#' @rdname selectors
#' @export
sel_all <- function(){
  construct_selector("%s", "*")
}

#' @rdname selectors
#' @export
sel_class <- function(value){
  not_missing(value)
  construct_selector(".%s", value)
}

#' @rdname selectors
#' @export
sel_tag <- function(value){
  not_missing(value)
  construct_selector("%s", value)
}

#' @rdname selectors
#' @export
sel_attr <- function(attribute, value = NULL, tag = NULL){
  # check
  not_missing(attribute)
  
  # replace NULL
  tag <- ifelse(is.null(tag), "", tag)
  
  # preprocess
  if(is.null(value))
    value <- ""
  else
    value <- sprintf("='%s'", value)
  
  attribute <- sprintf("%s", attribute)
  
  construct_selector("%s[%s%s]", tag, attribute, value)
}

# constructor for print methods
construct_selector <- function(pattern, ...){
  selector <- sprintf(pattern, ...)
  structure(selector, class = c("selector", class(selector)))
}

#' @export
print.selector <- function(x, ...){
  msg <- sprintf("CSS selector: %s", x)
  cli::cli_alert_info(msg)
}