#!/usr/bin/Rscript

#suppressPackageStartupMessages(library(docopt))
devtools::load_all("..")

"docopt practice script

Usage: foo.R [-i <integers>]

Options:
-i <integers>, --integers=<integers>  Integers [default: 1]
" -> doc

"%||%" <- function(a, b) if (!is.null(a)) a else b

opts <- docopt(doc)
my_ints <- opts$integers %||% opts$i
my_ints <- as.integer(eval(parse(text = my_ints)))
cat(sprintf("integers = %s\n", paste(my_ints, collapse = ", ")))


# fails with: 
# Rscript 11.r -i 'c(1, 8)'
