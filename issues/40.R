#!/usr/bin/env Rscript
"style files.
Usage:
  style_files [--arg=<arg1>] <files>...

Options:
  --arg=<arg1>  Package where the style guide is stored [default: Arg1].

" -> doc

# expected behavior
#docopt::docopt(doc, c("--arg=tidyverse_style(scope= \"none\")", "R/test.R"))
docopt::docopt(doc, "--arg='tidyverse_style(scope= \'none\')' R/test.R")

opt <- docopt::docopt(doc)
print(opt)