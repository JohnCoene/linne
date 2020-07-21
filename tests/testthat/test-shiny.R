context("Shiny")

test_that("Dependencies", {
  expect_s3_class(useLinne(), "shiny.tag") 
})