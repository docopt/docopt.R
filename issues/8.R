#issue 8  
 
"
Usage:
    install.r [-r repo...]

Options:
   -r=repo   Repo [default: my_url]
" -> doc

library(docopt)
docopt(doc, '-r repo1 -r repo2')