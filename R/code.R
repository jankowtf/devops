#' @title Knit README
#' @description TODO
#' @export
knitReadme <- function() {
  knitr::knit(input = "vignettes/README.Rmd", output = "README.md")
}

#' @title Add travisCI info to README
#' @description TODO
#' @param github_user \code{\link[base]{character}}.
#'  GitHub user.
#' @export
addTravisInfo <- function(
  github_user = "rappster"
) {
  pkg <- as.list(read.dcf("DESCRIPTION")[1, ])$Package
  repo <- file.path(github_user, pkg)
  main <- list(
    status = paste0("[![Travis-CI Build Status](https://travis-ci.org/", repo,
      ".svg?branch=master)](https://travis-ci.org/", repo, ")"),
    coverage = paste0("[![Coverage Status](https://img.shields.io/codecov/c/github/", repo,
      "/master.svg)](https://codecov.io/github/", repo, "?branch=master)")
  )

  path <- "README.md"
  src <- readLines(path)

  ## Status //
  field <- "status"
  value <- main[[field]]
  idx <- grep(value, src, fixed = TRUE)
  if (!length(idx)) {
    idx <- grep("---", src, fixed = TRUE)[2] + 1
    value <- c("", value, "")
    src <- append(src, value, idx)
  } else {
    src[idx] <- value
  }

  ## Coverage //
  field <- "coverage"
  value <- main[[field]]
  idx <- grep(value, src, fixed = TRUE)
  if (!length(idx)) {
    idx <- grep(main[["status"]], src, fixed = TRUE)
    if (!length(idx)) {
      idx <- grep("---", src, fixed = TRUE)[2] + 1
    } else {
      idx <- idx + 1
    }
    value <- c(value, "")
    src <- append(src, value, idx)
  } else {
    src[idx] <- value
  }
  writeLines(src, path)
}

#' @title Add CRAN badge info to README
#' @description TODO
#' @param pkg \code{\link[base]{character}}.
#'  Package name.
#' @example inst/examples/example-addCranInfo.R
#' @export
addCranInfo <- function(
  pkg = as.list(read.dcf("DESCRIPTION")[1, ])$Package
) {
  main <- list(
    cran = paste0("[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/",
      pkg, ")](http://cran.r-project.org/package=", pkg, ")"),
    coverage = paste0("[![Coverage Status](https://img.shields.io/codecov/c/github/", repo,
      "/master.svg)](https://codecov.io/github/", repo, "?branch=master)")
  )

  path <- "README.md"
  src <- readLines(path)

  ## Coverage //
  field <- "cran"
  value <- main[[field]]
  idx <- grep(value, src, fixed = TRUE)
  if (!length(idx)) {
    idx <- grep(main[["coverage"]], src, fixed = TRUE)
    if (!length(idx)) {
      idx <- grep("---", src, fixed = TRUE)[2] + 1
    } else {
      idx <- idx + 1
    }
    value <- c(value, "")
    src <- append(src, value, idx)
  } else {
    src[idx] <- value
  }
  writeLines(src, path)
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
  main <- list(
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
  value <- main[[field]]
  idx <- grep(value[1], src, fixed = TRUE)
  if (!length(idx)) {
    idx <- length(src)
    src <- append(src, value, idx)
  }

  field <- "after_success"
  value <- main[[field]]
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

#' @title
#' Add repository to .Rprofile file
#'
#' @description
#' Add repository to .Rprofile file. Important for dependency checks.
#'
#' @details
#' TODO
#'
#' @param repo \code{\link[base]{character}}.
#'  Repository to add as named character vector.
#' @return \code{TRUE}.
#' @example inst/examples/example-addRepositoryToRprofile.R
#' @importFrom stringr str_trim
#' @export
addRepositoryToRprofile <- function(
  repo = c(CRAN = "http://cran.r-project.org")
) {
  expr <- substitute({
    repos <- getOption("repos")
    options(repos = c(repos, REPO))},
    list(REPO = repo)
  )
  expr_dep <- stringr::str_trim(deparse(expr))
  # gsub("^\\{$|^\\}$", "", expr_dep)
  idx <- grep("^\\{$|^\\}$", expr_dep)
  if (length(idx)) {
    expr_dep <- expr_dep[-idx]
  }

  path <- ".Rprofile"
  if (!file.exists(path)) {
    writeLines(expr_dep, path)
  } else {
    src <- readLines(path)
    src <- unique(append(src, expr_dep, length(src)))
    writeLines(src, path)
  }
  TRUE
}

# addToTravis -------------------------------------------------------------

#' @title
#' Add travisCI information
#'
#' @description
#' Adds information to file \code{.travis.yml}.
#'
#' @details
#' TODO
#'
#' @param inst A class instance.
#' @return See respective methods.
#' @example inst/examples/example-addToTravisCi.R
#' @seealso \url{http://docs.travis-ci.com/user/languages/r/}
#' @export
addToTravisCi <- function(what, ...) {
  UseMethod("addToTravisCi", what)
}

#' @title
#' Add travisCI information
#'
#' @description
#' See generic: \code{\link[devops]{addToTravis}}
#' Method for: \code{TravisCi}
#'
#' @details
#' TODO
#'
#' @param what \code{TravisCi}.
#' @return \code{TRUE}.
#' @example inst/examples/example-addToTravisCi.R
#' @importFrom yaml yaml.load_file
#' @importFrom yaml as.yaml
#' @export
addToTravisCi.TravisCi <- function(what) {
  path <- ".travis.yml"
  yaml <- yaml::yaml.load_file(path)
  update <- FALSE
  for (value in names(what$values)) {
    if (is.null(yaml[[value]])) {
      yaml[[value]] <- what$values[[value]]
      update <- TRUE
    }
  }
  if (update) {
    # path <- gsub("travis", "travis_test", path)
    writeLines(yaml::as.yaml(yaml, omap = FALSE), path)
  }
  TRUE
}

#' @title
#' Add travisCI information
#'
#' @description
#' See generic: \code{\link[devops]{addToTravis}}
#' Method for: \code{list}
#'
#' @details
#' TODO
#'
#' @param what \code{list}.
#' @return \code{TRUE}.
#' @example inst/examples/example-addToTravisCi.R
#' @export
addToTravisCi.list <- function(what) {
  what <- structure(list(values = what), class = "TravisCi")
  addToTravisCi(what = what)
}

#' @title
#' Add travisCI information
#'
#' @description
#' See generic: \code{\link[devops]{addToTravis}}
#' Method for: \code{TravisCi.Default}
#'
#' @details
#' TODO
#'
#' @param what \code{TravisCi.Default}.
#' @return \code{TRUE}.
#' @example inst/examples/example-addToTravisCi.R
#' @export
addToTravisCi.TravisCi.Default <- function(what) {
  what <- list(
    cran = "http://cran.rstudio.com",
    r_packages = list("covr"),
    after_success = list("Rscript -e 'covr::codecov()'")
  )
  addToTravisCi(what = what)
}
