library(rjson)
library(stringr)
library(whisker)

#TODO extract comments and introduce sections.

cases <- readLines("testcases.docopt")
cases <- paste0(cases, collapse="\n")

# remove comments (TODO improve)
cases <- str_replace_all(cases, "#.+?\n", "")
cases <- str_replace_all(cases, ",\n", ",")
cases <- unlist(str_split(cases, "\nr"))

#case1 <- cases[1]

p_usage <- 'r?\\"\\"\\"(.*)\\"\\"\\"\n\\$ '
p_test <- '^([^\n]+)\n(.+?)\n\n'
p_prog <- '\\$ prog([^\n]*)\n([^\n]*)\n'

cases <- lapply(cases, function(x){
  case <- list()
  # extract usage text
  case$usage <- str_trim(str_match(x, p_usage)[,2])
  
  tests <- str_match_all(x, p_prog)[[1]]

  if (length(tests)==0){
    case$failed <- str_replace_all(x, "(^|\n)", "\\1\t\t#")
    return(case)
  }
  
  case$tests <- apply(tests, 1, function(r){
    if (str_sub(r[3],1,1) == "{"){
      output <- deparse(fromJSON(r[3]), control="keepNA")
    } else {
      output <- r[3]
    }
    test <- str_replace_all(str_trim(r[1]), "(^|\n)", "\\1\t\t#")
    list(test=test, args=str_trim(r[2]), output=output)
  })
  case
})



template <- "
library(testthat)
{{#cases}}
  
doc <- 
'{{{usage}}}'
  # TODO parse options
  {{#failed}}
    #
    # TEST GENERATION FAILED
    #
{{{.}}}
    test_that('failed', stop())
  {{/failed}}
  {{#tests}}
    test_that('parsing \"{{{args}}}\" works',{
{{{test}}}

      args <- parse_args('{{{args}}}', options)
      output <- {{{output}}}
      expect_equivalent(args, output)
    })
  {{/tests}}
{{/cases}}
"

writeLines(whisker.render(template), "test_specs.R")
