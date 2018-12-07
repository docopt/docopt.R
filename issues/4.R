#issue 4, should be put in tests

doc <- 'Usage: do.R <dirname> [<other>...]'
docopt(doc, "some_directory '--quoted test'", quoted_args=T)

docopt(doc, "some_directory --notquoted")
