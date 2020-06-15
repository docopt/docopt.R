QUOTED <- "'(.*?)'"
DQUOTED <- "\"(.*?)\""

# utility function
store_ws <- function(x, invert=FALSE){
  if (invert){
    gsub("___", " ", x, fixed = TRUE)
  } else {
    gsub(" ", "___", x, fixed = TRUE)
  }
}

# replaces values with white spaces
ws_replace <- function(pattern, x){
#  pattern <- "'(.*?)'"
  m <- gregexpr(pattern, x)
  ms <- regmatches(x, m)
  ms <- lapply(ms, store_ws)
  regmatches(x, m) <- ms
  x
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
         # trimws
         .tokens <- gsub("^\\s+|\\s+$", "", tokens)
         
         if (length(.tokens)){
           .tokens <- ws_replace("(<.*?>)", .tokens)
           .tokens <- ws_replace(QUOTED, .tokens)
           .tokens <- ws_replace(DQUOTED, .tokens)
           .tokens <- strsplit(.tokens, "\\s+")[[1]]
           .tokens <- store_ws(.tokens, invert = TRUE)
           # remove quotation
           # .tokens <- gsub("^'(.*)'$", "\\1", .tokens)
           # .tokens <- gsub('^"(.*)"$', "\\1", .tokens)
         }
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