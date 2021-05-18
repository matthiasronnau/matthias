#context("Ensure 'not_in' returns correct logicals")

test_that("correct boolean returned", {
  expect_true(5 %nin% 1:4)
  expect_false(7 %nin% 6:12)
})

test_that("multiple items correctly checked", {
  expect_equal(sum(1:4 %nin% 3:6), 2)
  expect_equal(sum(c(1, 3, 5, 7) %nin% 2:8), 1)
})
