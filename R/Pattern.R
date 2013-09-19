Pattern <- 
  setRefClass( "Pattern"
             , fields=list()
             , methods=list()
             )

LeafPattern <- 
  setRefClass( "LeafPattern"
             , contains = "Pattern"
             , fields=list()
             , methods=list(
                match = function(){ 
                }
               )
             )

BranchPattern <- 
  setRefClass( "BranchPattern"
               , contains = "Pattern"
               , fields=list()
               , methods=list(
                 match = function(){ 
                 }
               )
  )

Argument <- 
  setRefClass( "Argument"
               , contains = "LeafPattern"
               , fields=list()
               , methods=list(
                 parse = function(){ 
                 }
               )
  )

