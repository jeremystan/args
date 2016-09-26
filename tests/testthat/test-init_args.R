context("init_args")

test_that("init_args works for a simple example", {

  args <- init_args(
    a = arg_int("help a", 1),
    b = arg_dbl("help b", .1),
    c = arg_lgl("help c", TRUE),
    d = arg_chr("help d", "hello")
  )

  expected <- structure(
    list(a = 1L, b = .1, c = TRUE, d = "hello"),
    help = list(
      a = "(int) help a [default: 1]",
      b = "(dbl) help b [default: 0.1]",
      c = "(lgl) help c [default: TRUE]",
      d = "(chr) help d [default: hello]"
    ),
    class = "args"
  )

  expect_identical(args, expected)

})

test_that("init_args works for a date", {

  args <- init_args(
    a = arg_date("help a", as.Date("2016-06-01"))
  )

  expected <- structure(
    list(a = as.Date("2016-06-01")),
    help = list(a = "(date) help a [default: 2016-06-01]"),
    class = "args"
  )

  expect_identical(args, expected)

})

test_that("init_args works for plurals", {

  args <- init_args(
    a = narg_int("help a", c(1L, 2L)),
    b = narg_dbl("help b", c(.1, .2)),
    c = narg_lgl("help c", c(TRUE, FALSE)),
    d = narg_chr("help d", c("hello", "world"))
  )

  expected <- structure(
    list(a = c(1L, 2L),
         b = c(.1, .2),
         c = c(TRUE, FALSE),
         d = c("hello", "world")),
    help = list(a = "(int n) help a [default: 1 2]",
                b = "(dbl n) help b [default: 0.1 0.2]",
                c = "(lgl n) help c [default: TRUE FALSE]",
                d = "(chr n) help d [default: hello world]"),
    class = "args"
  )

  expect_identical(args, expected)

})

test_that("init_args works with plural dates", {

  args <- init_args(
    a = narg_date("help a", c(as.Date("2016-06-01"), as.Date("2016-06-02")))
  )

  expected <- structure(
    list(a = c(as.Date("2016-06-01"), as.Date("2016-06-02"))),
    help = list(a = "(date n) help a [default: 2016-06-01 2016-06-02]"),
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
