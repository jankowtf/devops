#' @title Knit README
#' @description TODO
#' @export
knitReadme <- function() {
  knitr::knit(input = "vignettes/README.Rmd", output = "README.md")
}

#' @title Add travisCI info to README
#' @description TODO
#' @param repo \code{\link[base]{character}}.
#'  GitHub repository.
#' @export
addTravisInfo <- function(
  repo = "rappster/devops"
) {
  travis <- list(
    status = paste0("[![Travis-CI Build Status](https://travis-ci.org/", repo,
      ".svg?branch=master)](https://travis-ci.org/rappster/devops)"),
    coverage = paste0("[![Coverage Status](https://img.shields.io/codecov/c/github/", repo,
      "/master.svg)](https://codecov.io/github/rappster/devops?branch=master)")
  )
  readme <- readLines("README.md")

  ## Status //
  field <- "status"
  value <- travis[[field]]
  idx <- grep(value, readme, fixed = TRUE)
  if (!length(idx)) {
    idx <- grep("---", readme, fixed = TRUE)[2] + 1
    value <- c("", value, "")
  } else {
    idx <- idx + 1
  }
  readme <- append(readme, value, idx)

  ## Coverage //
  field <- "coverage"
  value <- travis[[field]]
  idx <- grep(value, readme, fixed = TRUE)
  if (!length(idx)) {
    idx <- grep(travis[["status"]], readme, fixed = TRUE)
    if (!length(idx)) {
      idx <- grep("---", readme, fixed = TRUE)[2] + 1
    } else {
      idx <- idx + 1
    }
    value <- c(value, "")
  } else {
    idx <- idx + 1
  }
  readme <- append(readme, value, idx)
  writeLines(readme, "README.md")
}

#' @title Handle README tasks
#' @description TODO
#' @export
handleReadme <- function(...) {
  knitReadme()
  addTravisInfo(...)
}

#' @title
#' Add components provided by devtools
#'
#' @description
#' Calls certain functions of \code{\link{devtools}}.
#'
#' @details
#' \itemize{
#'  \item{\code{\link[devtools]{use_testthat}}}
#'  \item{\code{\link[devtools]{use_data}}}
#'  \item{\code{\link[devtools]{use_build_ignore}}}
#'  \item{\code{\link[devtools]{use_travis}}}
#'  \item{\code{\link[devtools]{use_coverage}}}
#'  \item{\code{\link[devtools]{use_revdep}}}
#'  \item{\code{\link[devtools]{use_package_doc}}}
#'  \item{\code{\link[devtools]{use_vignette}}}
#'  \item{\code{\link[devtools]{use_cran_badge}}}
#' }
#'
#' @return \code{TRUE}.
#' @example inst/examples/example-addDevtoolsComponents.R
#' @export
addDevtoolsComponents <- function() {
  try(devtools::use_testthat(), silent = TRUE)
  try(devtools::use_data(), silent = TRUE)
  # try(devtools::use_github(), silent = TRUE)
  try(devtools::use_build_ignore(), silent = TRUE)
  # try(devtools::use_code_of_conduct(), silent = TRUE)
  try(devtools::use_travis(), silent = TRUE)
  try(devtools::use_coverage(), silent = TRUE)
  try(devtools::use_revdep(), silent = TRUE)
  try(devtools::use_package_doc(), silent = TRUE)
  try(devtools::use_vignette(), silent = TRUE)
  try(devtools::use_cran_badge(), silent = TRUE)
  TRUE
}
