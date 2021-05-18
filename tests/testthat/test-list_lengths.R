#context("Ensure 'list_lengths' returns correct lengths of elements")
test_that("elements are correct length", {
  a <- list(c(1, 2, 3, 4))
  b <- list(seq(1, 100, 2))
  c <- list(5:15)
  d <- c(a, b, c)
  expect_equal(list_lengths(d), c(4, 50, 11))
})

test_that("vector inputs are acceptable", {
  vec <- 1:10
  expect_equal(list_lengths(vec), rep(1, 10))
})

test_that("mixed inputs are acceptable", {
  a <- list(c(1, 2, 3, 4))
  b <- list(seq(1, 100, 2))
  c <- list(5:15)
  d <- c(a, 1, b, 2, c, 3)
  expect_equal(list_lengths(d), c(4, 1, 50, 1, 11, 1))
})


