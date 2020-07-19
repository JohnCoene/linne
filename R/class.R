#' Gaius
#' 
#' @export 
Gaius <- R6::R6Class(
  "Gaius",
  public = list(
    initialize = function(charset = "UTF-8"){
      cat("Initialising\n")
      private$.charset <- chartset
      invisible(self)
    },
    define = function(...){

      private$.define <- append(private$.define, )
      invisible(self)
    }
  ),
  private = list(
    .charset = "utf-8"
  )
)