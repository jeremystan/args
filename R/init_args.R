#' Initialize argument parsing
#'
#' @param ... list of arguments
#' @export
init_args <- function(...) {

  args <- lazyeval::lazy_dots(...)

  # Evaluate all of the args
  evaluated <- args %>% map("expr") %>% map(eval) %>% transpose

  # Setup the parser and read from command line
  actuals <- setup_parser(
    names(args), evaluated$type, evaluated$default, evaluated$help,
    evaluated$invert, evaluated$plural)

  # Ensure types are correct
  actuals <- invoke_map(evaluated$conversion, actuals)

  structure(
    actuals,
    help = evaluated$help,
    class = "args"
  )

}

setup_parser <- function(names, types, defaults, helps, inverts, plurals) {

  # invoke_map doesn't work with dates
  for(i in seq_along(defaults))
    defaults[[i]] <- inverts[[i]](defaults[[i]])

  params <- list(
    paste0("--", names),
    type = types,
    default = defaults,
    help = helps,
    nargs = ifelse(plurals, list('+'), list(1))
  )

  parser <- ArgumentParser()
  params %>% transpose %>% map(lift(parser$add_argument))
  parser$parse_args()

}

