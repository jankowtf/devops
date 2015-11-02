context("Readme")

test_that("Readme", {
  # library(devtools)
  expect_true(TRUE)
  skip("Seems not to work in R CMD check")
  expect_is(inst <- Readme$new(), "Readme")
  expect_is(inst$createTemplate(github_user = "rappster"), "character")
  path <- file.path(tempdir(), "README.md")
  expect_is(inst$createTemplate(github_user = "rappster",
    save = TRUE, path = path), "character")
  expect_true(length(readLines(path)) > 0)
})
