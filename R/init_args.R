init_args <- function(...) {

  args <- lazyeval::lazy_dots(...)

  evaluated <- args %>% map("expr") %>% map(eval) %>% transpose

  defaults <- evaluated$default

  structure(
    defaults,
    help = evaluated$help,
    class = "args"
  )

}
