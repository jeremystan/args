#' Define an argument of a specific type
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
arg_factory <- function(f.conversion, type, short) {

  function(help, default) {

    list(
      help = "(%s) %s [default: %s]" %>% sprintf(short, help, default),
      default = f.conversion(default),
      type = type,
      conversion = f.conversion
    )

  }

}

#' @rdname args
#' @export
arg_int <- arg_factory(as.integer, "integer", "int")

#' @rdname args
#' @export
arg_dbl <- arg_factory(as.double, "double", "dbl")

#' @rdname args
#' @export
arg_lgl <- arg_factory(as.logical, "logical", "lgl")

#' @rdname args
#' @export
arg_chr <- arg_factory(as.character, "character", "chr")
