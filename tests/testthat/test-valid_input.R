#context("Ensure helper function works properly")

test_that("helper function works", {
  a <- list(c(1, 2, 3, 4))
  b <- list(seq(1, 100, 2))
  c <- list(5:15)
  d <- c(a, b, c)

  expect_true(valid_input(a))
  expect_true(valid_input(d))
  expect_true(valid_input(1:5))
  expect_true(valid_input(1868))

  expect_error(valid_input())
})
