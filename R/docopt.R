#' docopt
#' 
#' docopt
#' @export
docopt <- function(doc, ...){
}
         
# print help
help <- function(doc){
  cat(doc)
}
                   
                   
#print version
version <- function(version=NULL){
  if (!is.null(version)){
    cat("Version: ", version, "\n")
  }
}