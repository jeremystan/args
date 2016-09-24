#!/usr/bin/env Rscript

suppressPackageStartupMessages(library(args))

args <- init_args(
    a = arg_int("help a", 1),
    b = arg_int("help b", 2)
  )

args
