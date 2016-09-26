#!/usr/bin/env Rscript

library(args)
library(lubridate)

args <- init_args(
  zones = arg_int_n("Zones analyzed"),
  start_date = arg_date("Earliest date used", today() - 28L),
  end_date = arg_date("Latest date used", today()),
  seed = arg_int("Random seed", 1, set.seed)
)

args

runif(10)
