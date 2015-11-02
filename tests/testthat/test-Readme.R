context("Readme")

test_that("Readme", {
  # library(devtools)
  skip("Seems not to work in R CMD check")
  path <- file.path(tempdir(), "README.md")
  getOption("devops")$github_user <- "test_user"
  expect_is(inst$createTemplate(github_user = "rappster",
    save = TRUE, path = path), "character")
  expect_true(length(readLines(path)) > 0)
})
