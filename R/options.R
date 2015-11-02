# # install.packages("settings")
# # library(settings)
#
# opts <- options_manager(a = 1, b = 2)
#
# class(opts)
# opts("a")
#
# opts(a = 10)
#
# opts("a")
# reset(opts)
#
# opts()
#
# OPTS <- options_manager(a = 1, b = 2)
#
# #' @importFrom settings stop_if_reserved
# packageOption <- function(...) {
#   stop_if_reserved(...)
#   OPTS(...)
# }
# x <- packageOption(a = 3)
# pkg_reset() "a"
