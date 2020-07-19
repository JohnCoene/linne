make_selector <- function(id, class, tag){

  # default to none for tag
  operator <- "#"
  name <- rlang::as_label(id)

  # override for id or class
  if(!rlang::quo_is_missing(class)){
    operator <- "."
    name <- rlang::as_label(class)
  }

  if(!rlang::quo_is_missing(tag)){
    operator <- "."
    name <- rlang::as_label(tag)
  }

  # return selector
  sprintf("%s%s", operator, name)
}

process_definitions <- function(def){
  purrr::map(def, val2css)
}

val2css <- function(x){
  x <- gsub("'", "", x)
  if(inherits(x, "numeric") || inherits(x, "integer")){
    x <- sprintf("%dpx", x)
  } else{
    x <- sprintf("'%s'", x)
  }
  return(x)
}

chg2css <- function(x, def){
  selector <- purrr::pluck(x, "selector")

  # apply definitions
  x$change <- purrr::map(x$change, function(value, defs){
    if(rlang::is_quosure(value)){
      value <- rlang::as_label(value)

      if(value %in% names(defs))
        value <- purrr::pluck(defs, value)
      else 
        stop(sprintf("Cannot find `%s`, did you `define` it?", value), call. = FALSE)
    }

    return(value)
  }, defs = def)

  # change integers to pixels
  # add $ to definitions
  x$change <- purrr::map(x$change, val2css)

  # change camelcase to -
  names <- gsub('([[:upper:]])', '-\\1', names(x$change))
  names <- tolower(names)

  # string of css
  css <- paste0("\t", names, ":", x$change, ";", collapse = "\n")

  # css reconstruct
  sprintf("%s{\n%s\n}", selector, css)
}

parse_changes <- function(chg, def){
  chg <- purrr::map(chg, chg2css, def)
  paste0(unlist(chg), collapse = "\n")
}

minify <- function(x){
  gsub("\\n|\\t", "", x)
}