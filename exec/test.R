#!/usr/bin/env Rscript

library(argparse)

parser <- ArgumentParser()

parser$add_argument("--test", type = "integer", default = c(1L, 2L),
  help = "this is my help", nargs = '+')

args <- parser$parse_args()

args
length(args$test)

