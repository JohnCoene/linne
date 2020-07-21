# loop over val2css
process_definitions <- function(def){
  purrr::map(def, val2css)
}

# parse define to valid CSS value
val2css <- function(x){
  if(inherits(x, "numeric") || inherits(x, "integer")){
    x <- sprintf("%dpx", x)
  } else{
    x <- sprintf("%s", x)
  }
  return(x)
}

# parse define as CSS
chg2css <- function(x, def){
  selector <- purrr::pluck(x, "selector")

  # apply definitions
  x$rule <- purrr::map(x$rule, function(value, defs){

    if(rlang::is_symbolic(value)){
      value <- rlang::as_label(value)

      if(value %in% names(defs))
        value <- purrr::pluck(defs, value)
      else 
        stop(sprintf("Cannot find `%s`, did you `define` it?", value), call. = FALSE)
    }

    return(value)
  }, defs = def)

  # rule integers to pixels
  # add $ to definitions
  x$rule <- purrr::map(x$rule, val2css)

  # rule camelcase to -
  names <- gsub('([[:upper:]])', '-\\1', names(x$rule))
  names <- tolower(names)

  # string of css
  css <- paste0("\t", names, ":", x$rule, ";", collapse = "\n")

  # css reconstruct
  sprintf("%s{\n%s\n}", selector, css)
}

# assertthat of the poor
# check that argument is not missing
not_missing <- function(x){
  if(missing(x)){
    stop("Missing arguments", call. = FALSE)
  } 
  invisible()
}

# ensure file extension is correct
file_name <- function(path){
  ext <- tools::file_ext(path)
  ext_patt <- sprintf("\\.%s$", ext)

  gsub(ext_patt, ".css", path)
}