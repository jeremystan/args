init_args <- function(...) {

  args <- lazyeval::lazy_dots(...)

  # Evaluate all of the args
  evaluated <- args %>% map("expr") %>% map(eval) %>% transpose

  # Setup the parser and read from command line
  actuals <- setup_parser(
    names(args), evaluated$type, evaluated$default, evaluated$help)

  # Ensure types are correct
  actuals <- invoke_map(evaluated$conversion, actuals)

  structure(
    actuals,
    help = evaluated$help,
    class = "args"
  )

}

setup_parser <- function(names, types, defaults, helps) {

  parser <- ArgumentParser()

  for (i in seq_along(names)) {
    parser$add_argument(
      paste0("--", names[[i]]),
      type = types[[i]],
      default = defaults[[i]],
      help = helps[[i]]
    )
  }

  parser$parse_args()

}

