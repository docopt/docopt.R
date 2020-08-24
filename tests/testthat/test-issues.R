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

test_that("quotes inside options are preserved",{
  'style files.
Usage:
  style_files [--style_pkg=<style_guide_pkg>] [--stlye_guide_transformer=<style_guide_transformers>] [--style_fun=<style_guide_fun>] <files>...

Options:
  --style_pkg=<style_guide_pkg>  Package where the style guide is stored [default: styler].
  --stlye_guide_transformer=<style_guide_transformers> The `transformers` argument supplied to the styling API from the `style_pkg` namespace [default: tidyverse_style()].
  --style_fun=<style_guide_fun>  Deprecated in favor or `arg`. The styling function in style_pkg [default: tidyverse_style].
' -> doc
  
  # expected behavior
  opt = docopt(doc, c("--style_pkg=styler", "--stlye_guide_transformer='tidyverse_style(scope = \"none\")'", "R/test.R"))
  expect_equal(opt$arg, "tidyverse_style(scope = \"none\")")
  expect_equal(opt$style_pkg, "styler")
})
