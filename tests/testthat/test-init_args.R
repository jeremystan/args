context("init_args")

test_that("init_args works for a simple example", {

  args <- safely(init_args)(
    a = arg_int("help a", 1),
    b = arg_int("help b", 2)
  )

  print(args)

  expected <- structure(
    list(a = 1L, b = 2L),
    help = list(
      a = "(int) help a [default: 1]",
      b = "(int) help b [default: 2]"
    ),
    class = "args"
  )

  expect_identical(args$result, expected)

})
