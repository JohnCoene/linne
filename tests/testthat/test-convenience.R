context("Convenience")

test_that("Basic", {
  expect_equal(important_("this"), "this !important")
  expect_equal(important_(20), "20px !important")
  expect_equal(url_("https://john-coene.com"), "url(https://john-coene.com)")
  expect_equal(rgb_(1,2,3), "rgb(1,2,3)")
  expect_equal(rgba_(1,2,3, .5), "rgba(1,2,3,0.5)")
})
