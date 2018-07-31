context("Issues")

test_that("quoted arguments work (#2)", {
  doc <- "
  Usage:
  exampleScript <arg1>
  "
  docopt(doc, "\"quoted arg\"")
})


test_that("quoted arguments work (#4)", {
  doc <- 'Usage: do.R <dirname> [<other>...]'
  opt <- docopt(doc, "some_directory '--quoted test'", quoted_args=T
        )
  
  expect_equal(opt$other, "--quoted test")
  
})

test_that("multivalued options work (#8)",{
  "
Usage:
    install.r [-r repo]...

Options:
   -r=repo  Repository
" -> doc
  opt <- docopt(doc, "-r repo1 -r repo2")
  expect_equal(opt$r, c("repo1", "repo2"))
})


test_that("strings containing spaces are passed correctly (#11)", {
  "
  Usage: foo.R [-i <integers>]
  
  Options:
    -i <integers>, --integers=<integers>  Integers [default: 1]
  " -> doc
  opt <- docopt(doc, "-i ' c(1, 8)'")
  
})
