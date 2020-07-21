context("Testing selection")

as_c <- as.character

test_that("Selectors", {
  selector <- sel_id("id")
  expect_visible(selector)
  expect_equal(as_c(sel_id("id")), "#id")
  expect_equal(as_c(sel_tag("body")), "body")
  expect_equal(as_c(sel_input("id")), "#id")
  expect_equal(as_c(sel_class("class")), ".class")
  expect_equal(as_c(sel_all()), "*")
  expect_equal(as_c(sel_attr("data-for")), "[data-for]")
  expect_equal(as_c(sel_attr("data-for", "you")), "[data-for='you']")
  expect_equal(as_c(sel_attr("data-for", "you", "p")), "p[data-for='you']")  
})

test_that("Operators", {
  expect_equal(sel_id("id") %with% sel_class("container") %>% as_c(), "#id.container")
  expect_equal(sel_id("id") %child% sel_class("container") %>% as_c(), "#id .container")
  expect_equal(sel_id("id") %or% sel_class("container") %>% as_c(), "#id,.container")
})

test_that("Whens", {
  expect_equal(sel_tag("a")  %>% when_hover() %>% as_c(), "a:hover")
  expect_equal(sel_tag("a")  %>% when_active() %>% as_c(), "a:active")
  expect_equal(sel_tag("a")  %>% when_focus() %>% as_c(), "a:focus")
})

test_that("Errors", {
  expect_error(sel_id())
})
