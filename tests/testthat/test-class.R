context("Test class")

test_that("Generated CSS", {
  expect_output(Linne$new()$rule(sel_id("id"), fontSize = 20)$show_css())
  expect_s3_class(Linne$new()$rule(sel_id("id"), fontSize = 20)$include(), "shiny.tag") 
  expect_equal(Linne$new()$rule(sel_id("id"), fontSize = 20)$build()$get_css(), "#id{font-size:20px;}")
  expect_equal(Linne$new()$rule(sel_id("id"), fontSize = 20)$get_css(), "#id{font-size:20px;}")
  expect_equal(Linne$new()$define(size = 20)$rule(sel_id("id"), fontSize = size)$get_css(), "#id{font-size:20px;}")
  expect_equal(Linne$new()$import("https://john-coene.com")$get_css(), "@import url('https://john-coene.com');")
  l <- Linne$new()$rule(sel_id("id"), fontSize = 20)
  expect_visible(l)

  temp <- tempfile(fileext = ".css")
  Linne$new()$
    rule(
      sel_id("btn"),
      color = "blue"
    )$
    write(temp)

  contents <- readLines(temp)

  expect_equal(contents, "#btn{color:blue;}")
  
  unlink(temp, force = TRUE)
})

test_that("Errors", {
  expect_error(Linne$new()$rule())
  expect_error(Linne$new()$define(primary = "blue", secondary = "yellow")$define(primary = "red"))
  expect_error(Linne$new()$rule(color = primary))
})
