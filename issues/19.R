#!/usr/bin/env Rscript

'style files.
Usage:
  style_files [--arg=<arg1>] <files>...

Options:
  --arg=<arg1>  Package where the style guide is stored [default: Arg1].

' -> doc

arguments <- docopt::docopt(doc)
print(arguments)

