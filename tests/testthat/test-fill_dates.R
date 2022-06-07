#context("Ensure 'fill_dates' fills missing data correctly")
test_that("dates and values are filled correctly", {
  dat <- data.frame(date = c("2022/01/01", "2022/01/02", "2022/01/03", "2022/01/04", "2022/01/07", "2022/01/08", "2022/01/09", "2022/01/10"),
                    customer = c("123", "123", "456", "123", "789", "789", "789", "123"),
                    sales = c(157, 70, 86, 112, 52, 70, 32, 97),
                    items = c(10, 5, 4, 7, 2, 4, 1, 8))
  filled <- fill_dates(dataframe = dat, identifier = customer, date_col = date, min_date = "2022/01/01",
                       max_date = "2022/01/10", time_sequence = "day", fill_data = list(sales = 0))
  expect_equal(nrow(filled), length(unique(dat$customer)) * 10)
})

test_that("identifier check works", {
  dat <- data.frame(date = c("2022/01/01", "2022/01/02", "2022/01/03", "2022/01/04", "2022/01/07", "2022/01/08", "2022/01/09", "2022/01/10"),
                    customer = c("123", "123", "456", "123", "789", "789", "789", "123"),
                    sales = c(157, 70, 86, 112, 52, 70, 32, 97),
                    items = c(10, 5, 4, 7, 2, 4, 1, 8))
  expect_error(fill_dates(dataframe = dat, identifier = empty, date_col = date, min_date = "2022/01/01",
                          max_date = "2022/01/10", time_sequence = "day"))
})

test_that("column names the same", {
  dat <- data.frame(dates = c("2022/01/01", "2022/01/02", "2022/01/03", "2022/01/04", "2022/01/07", "2022/01/08", "2022/01/09", "2022/01/10"),
                    customer = c("123", "123", "456", "123", "789", "789", "789", "123"),
                    sales = c(157, 70, 86, 112, 52, 70, 32, 97),
                    items = c(10, 5, 4, 7, 2, 4, 1, 8))
  filled <- fill_dates(dataframe = dat, identifier = customer, date_col = dates, min_date = "2022/01/01",
                       max_date = "2022/01/10", time_sequence = "day", fill_data = list(sales = 0))
  expect_equal(colnames(dat), colnames(filled))
})
