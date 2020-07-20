# capture ...
capture <- function(...){
  qs <- rlang::enquos(...)
  
  quosures <- lapply(qs, function(x, env){
    rlang::new_quosure(x, env = env)
  }, env = parent.frame())

  lapply(quosures, function(x){
    try <- tryCatch(rlang::eval_tidy(x), error = function(e) e)

    if(!inherits(try, "error"))
      return(try)
    
    x
  })
}
