arg_int <- function(help, default) {

  list(
    help = "(int) %s [default: %s]" %>% sprintf(help, default),
    default = as.integer(default)
  )

}
