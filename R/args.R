#' Create an integer argument
#'
#' @param help help message
#' @param default default value
#' @export
arg_int <- function(help, default) {

  list(
    help = "(int) %s [default: %s]" %>% sprintf(help, default),
    default = as.integer(default),
    type = "integer",
    conversion = as.integer
  )

}
