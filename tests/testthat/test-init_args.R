context("init_args")

test_that("init_args works for a simple example", {

  args <- init_args(
    a = arg_int("help a", 1),
    b = arg_dbl("help b", .1),
    c = arg_lgl("help c", TRUE),
    d = arg_chr("help d", "hello")
  )
  args

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
    a = arg_int_n("help a", c(1L, 2L)),
    b = arg_dbl_n("help b", c(.1, .2)),
    c = arg_lgl_n("help c", c(TRUE, FALSE)),
    d = arg_chr_n("help d", c("hello", "world"))
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
    a = arg_date_n("help a", c(as.Date("2016-06-01"), as.Date("2016-06-02")))
  )

  expected <- structure(
    list(a = c(as.Date("2016-06-01"), as.Date("2016-06-02"))),
    help = list(a = "(date n) help a [default: 2016-06-01 2016-06-02]"),
    class = "args"
  )

  expect_identical(args, expected)

})

test_that("side effect works", {

  res <- capture.output(args <- init_args(
    a = arg_chr("help a", "this is my default", print)
  ))

  expect_identical(res, '[1] "this is my default"')

})

test_that("value must be supplied or will error", {

  # !!! Need to also test that can pass in a req argument and it works
  # !!! Also need to test that the help message is displayed

  expect_error(init_args(req = arg_chr("has no default")),
               "command line arg `--req` must be specified")

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
