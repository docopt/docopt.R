QUOTED <- "'(.*?)'"
DQUOTED <- "\"(.*?)\""

extract <- function(s, pat){
  if (length(s)) {
    stringr::str_extract_all(s, pat)[[1]]
  } else {
    s
  }
}

Tokens <- setRefClass( "Tokens"
   , fields=list( tokens="character"
                , error="function"
                , strict="logical"
                , defining=function(){!strict}
                )
   , methods=list(
     initialize = function(tokens=character(), error=stop, as_is=FALSE){
       if (as_is){
         .tokens <- tokens
       } else {
         .tokens <- gsub("^\\s+|\\s+$", "", tokens)
         if (length(.tokens)){
           args <- extract(.tokens, "<.*?>")
           args <- c(args, extract(.tokens, QUOTED))
           args <- c(args, extract(.tokens, DQUOTED))       
           args_s <- gsub("\\s", "____", args)
           for (i in seq_along(args)){
              .tokens <- gsub(args[i], args_s[i], .tokens, fixed = T)
           }
           .tokens <- strsplit(.tokens, "\\s+")[[1]]
           .tokens <- gsub("____", " ", .tokens, fixed=T)
         }
         # remove quotes from tokens...
         #.tokens <- gsub(QUOTED, "\\1", .tokens)
         #.tokens <- gsub(DQUOTED, "\\1", .tokens)
       }
       tokens <<- .tokens
       if (missing(error)){
         strict <<- TRUE
       } else {
         strict <<- FALSE
       }
       error <<- error
     },
     current = function(){
       if (length(tokens)){
         tokens[1]
        } else {
          ""
        }
     },
     shift = function(){
       h <- head(tokens, 1)
       tokens <<- tail(tokens, -1)
       if (length(h)) h else ""
     },
     move = function(){
       h <- head(tokens, 1)
       tokens <<- tail(tokens, -1)
       
       #remove optional quotes...
       h <- gsub(QUOTED, "\\1", h)
       h <- gsub(DQUOTED, "\\1", h)
       
       if (length(h)) h else ""
     },
     #     toString: -> ([].slice.apply @).toString()
     toString = function(){
       tokens
     },
     show = function(){
       cat("Tokens:", toString())
     },
     # 
     #     join: (glue) -> ([].join.apply @, glue)
     join = function(glue){
       paste0(tokens, collapse=glue)
     }
  )
)

#' index tokens
#' 
#' index tokens
#' @keywords internal
setMethod("[",
          signature(x = "Tokens"),
          function (x, i, drop = TRUE) 
          {
            x$tokens[i]
          }
)

#' index tokens
#' 
#' index tokens
#' @keywords internal
setMethod("[<-",
          signature(x = "Tokens"),
          function (x, i, value) 
          {
            x$tokens[i] <- value
          }
)

#' to character
#' 
#' to character
#' @keywords internal
setMethod("as.character", signature(x="Tokens"), function(x, ...){x$tokens})


# # testing 1, 2, 3
# t <- Tokens(c("a", "b"))
# t$current()
# t$shift()
# t