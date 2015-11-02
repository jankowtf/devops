#' @title
#' Interface Class for README Information
#'
#' @description
#' Defines the interface for data format information.
#'
#' @template interface_section
#'
#' @section Getters/setters:
#'
#' \itemize{
#'  \item{\code{getPath}} {
#'
#'    Get file path
#'  }
#'  \item{\code{setPath}} {
#'
#'    Set file path
#'  }
#'  \item{\code{getCache}} {
#'
#'    Get cached content
#'  }
#'  \item{\code{setCache}} {
#'
#'    Set cached content
#'  }
#'  \item{\code{getContent}} {
#'
#'    Get stored content
#'  }
#'  \item{\code{setContent}} {
#'
#'    Set stored content
#'  }
#' }
#'
#' @section Public methods:
#'
#' \itemize{
#'  \item{read} {
#'    Read README information
#'  }
#'  \item{write} {
#'    Write README information
#'  }
#' }
#'
#' @section Known interface implementations:
#'
#' \itemize{
#'  \item{\code{\link[devops]{Readme}}}
#' }
#'
#' @template authors
#' @template references
#' @example inst/examples/example-IReadme.R
#' @import R6
#' @export
IReadme <- R6Class(
  classname = "IReadme",
  portable = TRUE,
  public = list(
    getPath = function() {
      stopOnInterfaceCall(self)
    },
    setPath = function(...) {
      stopOnInterfaceCall(self)
    },
    getCache = function() {
      stopOnInterfaceCall(self)
    },
    setCache = function(...) {
      stopOnInterfaceCall(self)
    },
    getContent = function() {
      stopOnInterfaceCall(self)
    },
    setContent = function(...) {
      stopOnInterfaceCall(self)
    },
    read = function(...) {
      stopOnInterfaceCall(self)
    },
    write = function(...) {
      stopOnInterfaceCall(self)
    }
  )
)
