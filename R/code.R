#' @export
knitReadme <- function() {
  knitr::knit(input = "vignettes/README.Rmd", output = "README.md")
}

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

#' @export
handleReadme <- function(...) {
  knitReadme()
  addTravisInfo(...)
}
