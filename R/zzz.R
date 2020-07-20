.onLoad <- function(libname, pkgname){
  path <- system.file("assets", package = "linne")
  shiny::addResourcePath("line-assets", path)
}