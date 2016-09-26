#' Initialize argument parsing
#'
#' @param ... list of arguments
#' @export
init_args <- function(...) {

  args <- lazyeval::lazy_dots(...)

  # Evaluate all of the args
  evaluated <- args %>% map("expr") %>% map(eval)

  # Argparse parameteres
  params <- map2(names(args), evaluated, arg_params)

  # Setup argparse
  parser <- ArgumentParser()

  # Add all arguments
  walk(params, lift(parser$add_argument))

  # Parse arguments
  actuals <- parser$parse_args()

  # Identify any nulls
  nulls <- map_lgl(actuals, is.null)

  # Throw an error
  map_if(names(actuals), nulls, function(x) {
    stop("command line arg `--%s` must be specified" %>% sprintf(x),
         call. = FALSE)
    })

  # Ensure types are correct
  # invoke_map doesn't work with dates
  #actuals <- invoke_map(evaluated$conversion, actuals)
  for(i in seq_along(actuals))
    actuals[[i]] <- evaluated[[i]]$conversion(actuals[[i]])

  # Execute side effects
  for(i in seq_along(actuals))
    if(!is.null(evaluated[[i]]$side.effect))
      evaluated[[i]]$side.effect(actuals[[i]])

  structure(
    actuals,
    help = map(evaluated, "help"),
    class = "args"
  )

}

#' Convert the results of an arg_factory into params for argparse
#'
#' @param arg results of arg_factory call
arg_params <- function(name, arg) {

  params <- list(
    paste0("--", name),
    type = arg$type,
    help = arg$help
  )

  if (!is.null(arg$default)) params$default <- arg$invert(arg$default)
  if (arg$plural) params$nargs <- "+"

  params

}
