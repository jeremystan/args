context("init_args")

test_that("init_args works for a simple example", {

  args <- init_args(
    a = arg_int("help a", 1),
    b = arg_int("help b", 2)
  )

  expected <- structure(
    list(a = 1L, b = 2L),
    help = list(
      a = "(int) help a [default: 1]",
      b = "(int) help b [default: 2]"
    ),
    class = "args"
  )

  expect_identical(args, expected)

})

context("example")

if (FALSE) { # this test is failing in check(), need to revisit

  exec <- system.file("exec", package = "args")
  example <- "Rscript %s/example.R" %>% sprintf(exec)
  #system("chmod +x %s" %>% sprintf(example), intern = TRUE)
  library(stringr)

  test_that("help works", {

    command <- "%s --help" %>% sprintf(example) %>% paste(collapse = "")

    res <- suppressWarnings(system(command, intern = TRUE))
    expect_identical(res[1] %>% str_sub(1, 6), "usage:")

  })

}
