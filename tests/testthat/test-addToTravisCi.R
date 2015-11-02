library(testhelper)
context("addToTravisCi")

test_that("addToTravisCi", {
  path <- withCorrectWorkingDir(
    file.path(getwd(), "data/persistent/.travis.yml_1")
  )
  expect_true(file.exists(path))

  what <- structure(list(values = list(cran = "http://cran.rstudio.com/")),
    class = "TravisCi")
  expect_is(res <- addTravisCi(what, path = path, save = FALSE), "character")
  expect_true("cran" %in% names(yaml::yaml.load(res)))
})
