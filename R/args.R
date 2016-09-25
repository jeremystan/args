#' Define an argument of a specific type
#'
#' The \code{argn_} family allows for multiple arguments to be passed when
#' delimited by spaces.
#'
#' @seealso \code{\link{init_args}} for initializing arguments in a script
#' @name args
#' @param help help message
#' @param default default value
NULL

#' Factory for creating argument types
#'
#' @param f.conversion function used to do conversion
#' @param type type used in argparse
#' @param short short name used in help
#' @param f.invert function to invert type for argparse of odd types
#' @param plural should this arg take multiple values
arg_factory <- function(f.conversion, type, short, f.invert = identity,
                        plural = FALSE) {

  function(help, default) {

    print_default <- default
    if (length(default) > 1)
      print_default <- paste(default, collapse = " ")

    if (plural)
      short <- "%s n" %>% sprintf(short)

    list(
      help = "(%s) %s [default: %s]" %>% sprintf(short, help, print_default),
      default = f.conversion(default),
      type = type,
      conversion = f.conversion,
      invert = f.invert,
      plural = plural
    )

  }

}

#' @rdname args
#' @export
arg_int <- arg_factory(as.integer, "integer", "int")

#' @rdname args
#' @export
argn_int <- arg_factory(lift_vd(as.integer), "integer", "int",
                        plural = TRUE)

#' @rdname args
#' @export
arg_dbl <- arg_factory(as.double, "double", "dbl")

#' @rdname args
#' @export
argn_dbl <- arg_factory(lift_vd(as.double), "double", "dbl",
                        plural = TRUE)

#' @rdname args
#' @export
arg_lgl <- arg_factory(as.logical, "logical", "lgl")

#' @rdname args
#' @export
argn_lgl <- arg_factory(lift_vd(as.logical), "logical", "lgl",
                        plural = TRUE)

#' @rdname args
#' @export
arg_chr <- arg_factory(as.character, "character", "chr")

#' @rdname args
#' @export
argn_chr <- arg_factory(lift_vd(as.character), "character", "chr",
                        plural = TRUE)

#' @rdname args
#' @export
arg_date <- arg_factory(as.Date, "character", "date", as.character)

#' @rdname args
#' @export
argn_date <- arg_factory(as.Date, "character", "date", as.character,
                         plural = TRUE)
