#!/usr/bin/env Rscript

library(docopt)
doc <- "USAGE: foo ARG"
args <- docopt(doc = doc, quoted_args = TRUE)
print(sessionInfo())
print(args$ARG)