Tokens <- setRefClass( "Tokens"
                       , fields=list(tokens="character", error="character")
                       , methods=list(
                         initialize = function(tokens=character(), error=""){
                           tokens <<- tokens
                           error <<- error
                         },
                         current = function(){head(tokens,1)},
                         shift = function(){
                           h <- head(tokens, 1)
                           tokens <<- tail(tokens, -1)
                           if (length(h)) h else NULL
                         },
                         current = function(){
                           if (length(.self)) .self[1]
                         },
                         #     toString: -> ([].slice.apply @).toString()
                         toString = function(){
                           tokens
                         },
                         # 
                         #     join: (glue) -> ([].join.apply @, glue)
                         join = function(glue){
                           paste0(tokens, collapse=glue)
                         }
        )
)

setMethod("[",
          signature(x = "Tokens"),
          function (x, i, j, ..., drop = TRUE) 
          {
            x$tokens[i]
          }
)

setMethod("[<-",
          signature(x = "Tokens"),
          function (x, i, j, ..., value) 
          {
            x$tokens[i] <- value
          }
)


# # testing 1, 2, 3
# t <- Tokens(c("a", "b"))
# t$current()
# t$shift()
# t