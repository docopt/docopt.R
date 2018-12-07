#!/usr/bin/Rscript
'usage: my_program.R [-a -r -m <msg>] <file>

options:
 -a         Add
 -r         Remote
 -m <msg>   Message' -> doc

library(docopt)
docopt(doc)
