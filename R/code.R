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

#' @title
#' Add travisCI information to YAML file
#'
#' @description
#' Add travisCI information to YAML file.
#'
#' @details
#' TODO
#'
#' @return \code{TRUE}.
#' @example inst/examples/example-addTravisInfoToYaml.R
#' @export
addTravisInfoToYaml <- function() {
  travis <- list(
    r_packages = c(
      "r_packages:",
      "  - covr"
    ),
    after_success = c(
      "after_success:",
      "  - Rscript -e 'covr::codecov()'"
    )
  )
  path <- ".travis.yml"
  src <- readLines(path)
  checksum <- digest::digest(src)

  field <- "r_packages"
  value <- travis[[field]]
  idx <- grep(value[1], src, fixed = TRUE)
  if (!length(idx)) {
    idx <- length(src)
    src <- append(src, value, idx)
  }

  field <- "after_success"
  value <- travis[[field]]
  idx <- grep(value[1], src, fixed = TRUE)
  if (!length(idx)) {
    idx <- length(src)
    src <- append(src, value, idx)
  }
  checksum_2 <- digest::digest(src)
  if (checksum_2 != checksum) {
    writeLines(src, path)
  }
  TRUE
}

#' @title Handle README tasks
#' @description TODO
#' @template threedots
#' @export
handleReadme <- function(...) {
  knitReadme()
  addTravisInfo(...)
}

#' @title
#' Add components provided by devtools
#'
#' @description
#' Calls certain functions of \code{devtools}.
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
#' @importFrom devtools use_testthat
#' @importFrom devtools use_data
#' @importFrom devtools use_build_ignore
#' @importFrom devtools use_travis
#' @importFrom devtools use_coverage
#' @importFrom devtools use_revdep
#' @importFrom devtools use_package_doc
#' @importFrom devtools use_vignette
#' @importFrom devtools use_cran_badge
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

#' @title
#' Add examples infrastructure
#'
#' @description
#' Add examples infrastructure.
#'
#' @details
#' TODO
#'
#' @return \code{\link[base]{character}}. Path to example directory.
#' @example inst/examples/example-addExamples.R
#' @export
addExamples <- function(
) {
  path <- "inst/examples"
  dir.create(path, recursive = TRUE, showWarnings = FALSE)
  path
}

#' @title
#' Add example
#'
#' @description
#' Add example.
#'
#' @details
#' TODO
#'
#' @param name \code{\link[base]{character}}.
#'  Name for example file.
#' @return \code{\link[base]{character}}. Path to example file.
#' @example inst/examples/example-addExample.R
#' @export
addExample <- function(
  name = character()
) {
  if (!length(name)) {
    stop("addExample: please provide a name")
  }
  path <- file.path(addExamples(), sprintf("example-%s.R", name))
  writeLines("## TODO", path)
  path
}
