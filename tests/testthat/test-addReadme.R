context("addReadme")

test_that("addReadme", {
  # library(devtools)
  expect_true(TRUE)
  skip("Seems not to work in R CMD check")
  options("devops" = list())
  expect_error(addReadme())
  options("devops" = list(github_user = "rappster"))
  expect_false(addReadme())
  expect_true(addReadme(overwrite = TRUE))
  options("devops" = NULL)
})

