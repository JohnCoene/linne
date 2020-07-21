context("Test class")

test_that("Generated CSS", {
  expect_invisible(Linne$new()$change(sel_id("id"), fontSize = 20)$show_css())
  expect_s3_class(Linne$new()$change(sel_id("id"), fontSize = 20)$include(), "shiny.tag") 
  expect_equal(Linne$new()$change(sel_id("id"), fontSize = 20)$build()$get_css(), "#id{font-size:20px;}")
  expect_equal(Linne$new()$change(sel_id("id"), fontSize = 20)$get_css(), "#id{font-size:20px;}")
  expect_equal(Linne$new()$define(size = 20)$change(sel_id("id"), fontSize = size)$get_css(), "#id{font-size:20px;}")
  expect_equal(Linne$new()$import("https://john-coene.com")$get_css(), "@import url('https://john-coene.com');")
  l <- Linne$new()$change(sel_id("id"), fontSize = 20)
  expect_visible(l)
})

test_that("Errors", {
  expect_error(Linne$new()$change())
  expect_error(Linne$new()$define(primary = "blue", secondary = "yellow")$define(primary = "red"))
})