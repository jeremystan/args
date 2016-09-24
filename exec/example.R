#!/usr/bin/env Rscript

suppressPackageStartupMessages(library(args))

args <- init_args(
  a = arg_int("help a", 1),
  b = arg_dbl("help b", .1),
  c = arg_lgl("help c", TRUE),
  d = arg_chr("help d", "hello"),
  e = arg_date("help e", as.Date("2016-01-01"))
)

vapply(args, class, character(1))
