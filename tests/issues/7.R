#issue 7  
 
docs <- list()
"
Usage:

    build profile [--previous=<num>] [--time=<time>]
    build redocument
" -> docs $ master

library(docopt)
docopt(docs$master)