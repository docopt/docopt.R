#!/usr/bin/env Rscript
"Usage: prog [options]

Options:
  -a --all    All that you need to do is
  -r --relax  Relax
  -m --more   More or not?
" -> doc
suppressPackageStartupMessages(library(docopt))

opts <- docopt(doc)
print(str(opts))

print(commandArgs())