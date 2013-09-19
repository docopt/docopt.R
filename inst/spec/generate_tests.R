library(rjson)
library(stringr)

#TODO extract comments and introduce sections.

cases <- readLines("testcases.docopt")
cases <- paste0(cases, collapse="\n")
cases <- unlist(str_split(cases, "\nr"))

#case1 <- cases[1]

p_usage <- 'r\\"\\"\\"(.*)\\"\\"\\"\n\\$ '
p_test <- '^([^\n]+)\n(.+?)\n\n'

cases <- lapply(cases, function(x){
  case <- list()
  # extract usage text
  case$usage <- str_match(x, p_usage)[,2]
  
  # remove usage text from case
  tests <- str_replace(x, p_usage, "")
  # split in separate test cases
  tests <- unlist(str_split(tests, "\\$ "))
  
  case$tests <- lapply(tests, function(test){
    tt <- str_match(test, p_test)
    list(input=tt[,2], output=fromJSON(tt[,3]))
  })
  case
})

