context("Test class")

test_that("Generated CSS", {
  expect_equal(Linne$new()$change(sel_id("id"), fontSize = 20)$get_css(), "#id{font-size:20px;}")
  expect_equal(Linne$new()$define(size = 20)$change(sel_id("id"), fontSize = size)$get_css(), "#id{font-size:20px;}")
  expect_equal(Linne$new()$import("https://john-coene.com")$get_css(), "@import url('https://john-coene.com');")
})