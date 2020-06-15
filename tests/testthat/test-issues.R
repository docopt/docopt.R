context("Issues")

test_that("quoted arguments work (#2)", {
  doc <- "
  Usage:
  exampleScript <arg1>
  "
  opt <- docopt(doc, "\"quoted arg\"")
  expect_equal(opt$arg1, "quoted arg")
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
  expect_equal(opt$integers, " c(1, 8)")
})

test_that("quoted options are ok (#19)",{
  '
Usage:
  style_files [--arg=<arg1>] <files>...

Options:
  --arg=<arg1>  Package where the style guide is stored [default: Arg1].

' -> doc
  
  arguments <- docopt::docopt(doc, "--arg='bla bla' f1")
  expect_equal(arguments$arg, "bla bla")
  expect_equal(arguments$files, "f1")
})

test_that("kebab case option to snake case",{
'
Usage: foo.R

Options:
  --do-the-thing=<dtt>  Do the Thing! [default: yeah].

' -> doc
  opt <- docopt::docopt(doc)
  expect_equal(names(opt), c("--do-the-thing", "do_the_thing"))
})
