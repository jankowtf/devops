context("addToTravisCi")

test_that("addToTravisCi", {
  skip("TODO: prepare test data")
  what <- structure(list(values = list(cran = "http://cran.rstudio.com/")),
    class = "TravisCi")
  expect_true(addToTravisCi(what))
})
