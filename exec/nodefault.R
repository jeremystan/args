#!/usr/bin/env Rscript

library(argparse)

parser <- ArgumentParser()

parser$add_argument("--test", type = "character")

args <- parser$parse_args()

args
