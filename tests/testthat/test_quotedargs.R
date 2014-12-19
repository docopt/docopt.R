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

