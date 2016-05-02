#!/usr/bin/env Rscript
'usage: qtest <s> [<more>...]
' -> doc

#str(commandArgs(TRUE))
suppressPackageStartupMessages({
  ## load the docopt library
  library(docopt)
})

opt <- docopt(doc)
str(opt) 
