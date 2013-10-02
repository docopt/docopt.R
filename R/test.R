
Tokens <- setRefClass( "Tokens"
                , fields=list(tokens="character")
                , methods=list(
                    initialize = function(tokens=""){
                      tokens <<- tokens
                    },
                    current = function(){head(tokens,1)}
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


# testing 1, 2, 3
t <- Tokens()
t$current()
t[1] <- "bla"
t
t[1]