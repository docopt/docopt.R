context("Issues")


test_that("quoted arguments work (#2)", {
  doc <- '
  Usage:
  exampleScript <arg1>
  '
  docopt(doc, "'quoted arg'")
})