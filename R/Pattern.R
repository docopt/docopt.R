Pattern <- setRefClass( "Pattern"   
      , fields=list(children="list")
      , methods=list(
        initialize = function(.children=list()){
            children <<- .children
          },
        toString = function(){
          formals = paste0(sapply(children, as.character), collapse=", ")
          paste0(class(.self),"(",formals,")")
        },
        show = function(){
          cat(toString())
        },
  
        match = function(){
            stop("classes inheriting from Pattern
                  must overload the match method")
        },
                          
        flat = function(...){
            types = list(...)
            if (class(.self) %in% types){
              return(list(.self))
            }
            if (length(children) == 0){
              return(list(.self))
            }
            unlist(lapply(children, function(child){child$flat(...)}))
          },
  
        fix = function(){
          fix_identities()
          fix_repeating_arguments()
        },
        #Make pattern-tree tips point to same object if they are equal.
        fix_identities = function(uniq=NULL){
          #browser()
          if (length(children) == 0) {
            return(.self)
          }
          if (is.null(uniq)){
            uniq <- flat()
            names(uniq) <- sapply(uniq, as.character)
          }
          for (i in seq_along(children)){
            child <- children[[i]]
            if (length(child$children)){
              #TODO check what uniq does.
              child$fix_identities(uniq)
            } else {
              children[[i]] <<- uniq[[child$toString()]]
            }
          }
          uniq
        },
#       Find arguments that should accumulate values and fix them.
        fix_repeating_arguments = function(){
          eith <- lapply(either()$children, function(c) c$children)
          for (child in eith){
            nms <- as.character(sapply(child, as.character))
            #browser()
            counts <- table(nms)
            for (e in child){
              if (isTRUE(unname(counts[as.character(e)] > 1))){
                if (class(e)=="Argument" ||(class(e)=="Option" && e$argcount>0)){
                  if (is.null(e$value)){
                    e$value <- list()
                  } else if (class(e$value) != "list"){
                    e$value <- as.list(e$value)
                  }
                }
                if ( class(e) == "Command" 
                  || (class(e) == "Option" && e$argcount == 0)){
                   e$value <- 0L
                }
              } 
            } 
          }
          .self
        },
        either = function(){
          if (length(children) == 0L){
            return(Either(list(Required(list(.self)))))
          }
          #browser()
         ret <- list()
          #             groups = [[@]]
          groups <- list(list(.self))
#             while groups.length
          while (length(groups)){
#                 children = groups.shift()
            .children <- head(groups, 1)[[1]]
            groups <- tail(groups, -1)
            type <- c("Either", "Required","Optional", "OneOrMore", "AnyOptions")
            childtype <- sapply(.children, class)
            m <- base::match(childtype, type, nomatch=0L)
            
            if (any(m > 0)){
              # take first child bigger than zero
              idx <- which(m > 0L)[1]
              child <- .children[[idx]]
              .children <- .children[-idx]
              if (class(child) == "Either"){
                for (ci in child$children){
                  group <- c(ci, .children)
                  groups[[length(groups)+1]] <- group
                }
              } else if (class(child) == "OneOrMore"){
                group <- c(child$children, child$children, .children)
                groups[[length(groups)+1]] <- group
              } else {
                group <- c(child$children, .children)
                groups[[length(groups)+1]] <- group                
              }
            } else{
              ret[[length(ret)+1]] <- .children
            }
          }
          Either(lapply(ret, function(e) Required(e)))
        }
))

# LeafPattern <- setRefClass( "LeafPattern"   
#   , fields=c("name", "value")
#   , methods=list(
#       flat = function(...){
#         types <- list(...)
#         if (length(l)==0 || class(.self) %in% types){
#           return(list(.self))
#         }
#         list()
#       },
#       match = function(left, collected=list()){
#         browser()
#         m <- single_match(left)
#         # if match is None:
#         #   return False, left, collected
#         if (is.null(m$match)){
#           return(matched(FALSE, left, collected))
#         }
#         # left_ = left[:pos] + left[pos + 1:]
#         left_ <- left[-m$pos]
#         # same_name = [a for a in collected if a.name == self.name]
#         same_name <- Filter(function(a){a$name == name}, collected)
#         # if type(self.value) in (int, list):
#         if (class(value) %in% c("integer", "list")){
#           browser()
#         #   if type(self.value) is int:
#           if (is.integer(value)){
#         #   increment = 1
#             increment <- 1
#           } else {
#         # else:
#         #   increment = ([match.value] if type(match.value) is str
#         #                else match.value)
#             increment <- m$match$value
#             if (is.character(increment)){
#               increment <- list(increment)
#             }
#           }
#           # if not same_name:
#           if (length(same_name)==0){
#             #   match.value = increment
#             match$value <- increment
#             # return True, left_, collected + [match]
#             return(matched(TRUE, left_, c(collected, match)))
#           }
#           val <- same_name[[1]]$value
#           # same_name[0].value += increment
#           # return True, left_, collected
#           same_name[[1]]$value <- if (is.integer(val)) val + increment else c(val, increment)
#           return(matched(TRUE, left_, collected))
#         }
#         # return True, left_, collected + [match]        
#         return(matched(TRUE, left_, c(collected, match)))
#       }
#     )
#   )
# BranchPattern <- setRefClass("BranchPattern", contains="Pattern"
#     , methods=list(
#       initialize = function(.children=list()){
#         children <<- .children
#       },
#       flat=function(...){
#         types <- list(...)
#         if (class(.self) %in% types){
#           return(list(.self))
#         }        
#         if (length(children) == 0){
#           return(list())
#         }
#         unlist(lapply(children, function(child){child$flat(...)}))
#       }
#     )
# )
# 
# class BranchPattern(Pattern):
#   
#   """Branch/inner node of a pattern tree."""
# 
# def __init__(self, *children):
#   self.children = list(children)
# 
# def __repr__(self):
#   return '%s(%s)' % (self.__class__.__name__,
#                      ', '.join(repr(a) for a in self.children))
# 
# def flat(self, *types):
#   if type(self) in types:
#   return [self]
# return sum([child.flat(*types) for child in self.children], [])

# class Argument extends Pattern
Argument <- setRefClass("Argument", contains="Pattern"
                       , fields = c("argname", "value")
                       , methods = list(
                         initialize=function(argname, value=NULL){
                           argname <<- argname
                           value <<- value
                         },                           
# 
#     name: -> @argname
                         name = function(){
                           argname
                         },
#     toString: -> "Argument(#{@argname}, #{@value})"
                         toString = function(){
                           paste0("Argument(",argname,",",value,")")
                         },
#     match: (left, collected=[]) ->
       match = function(left, collected=list()){
         #         args = (l for l in left when l.constructor is Argument)
         argsidx <- which(sapply(left, class) == "Argument")
         arg <- head(argsidx,1)       
         if (!length(arg)){
           return(matched(FALSE, left, collected))
         }
         arg <- left[[arg]]
         left <- Filter(function(l){!identical(l, arg)}, left)
         if (is.null(value) || !is.list(value)){
           collected <- c(collected, list(Argument(name(), arg$value)))
           return(matched(TRUE, left, collected))
         }
         same_name <- Filter(function(a){
                               class(a) == "Argument" && identical(a$name(), name())
                             }
                            , collected)
         if (length(same_name)){
           same_name[[1]]$value <- c(same_name[[1]]$value, arg$value)
           return(matched(TRUE, left, collected))
         } else{
           collected <- c(collected, Argument(name(), arg$value))
           return(matched(TRUE, left, collected))
         }
       }
))
# 
# 
# class Command extends Pattern
Command <- setRefClass("Command"
    , contains="Pattern"
    , fields = c("cmdname", "value")
    , methods=list(
      initialize = function(cmdname, value=FALSE){
        cmdname <<- cmdname
        value <<- value
      },
       
#     name: -> @cmdname
      name = function(){
        cmdname
      },
      toString = function(){
        paste0("Command(",cmdname,",",value,")")
      },
#     match: (left, collected=[]) ->
      match = function(left, collected=list()){
        #browser()
        argsidx <- which(sapply(left, class) == "Argument")
        firstarg <- head(argsidx,1)
        #         args = (l for l in left when l.constructor is Argument)
        #         if not args.length or args[0].value isnt @name()
        if (!length(firstarg) || left[[firstarg]]$value != name()){
        #             return [false, left, collected]{
          return(matched(FALSE, left, collected))
        }
        #         left.splice(left.indexOf(args[0]), 1)
        left <- left[-firstarg]
        #         collected.push new Command @name(), true
        collected <- c(collected, Command(name(), TRUE))
        #         [true, left, collected]
        matched(TRUE, left, collected)
      }
))
# 
# 
# class Option extends Pattern
Option <- setRefClass("Option", contains="Pattern"
                     , fields = c("short", "long", "argcount", "value", "cardinality")
                     , methods = list(
                       initialize= function(short=NULL, long=NULL, argcount=0L, value=FALSE){
                         short <<- short
                         long <<- long
                         argcount <<- argcount
                         if (argcount && missing(value)){
                           value <<- NULL
                         } else value <<- value
                         cardinality <<- 1L
                       },
                       toString = function(){
                         val <- value
                         if (length(val) > 1){
                           val <- paste0("[",paste0(val, collapse = ","),"]")
                         }
                         paste0("Option(",short,",",long,",",argcount,",", val,")")
                       },
                       name = function(){
                         if (!is.null(long)) long else short
                       },
       match = function(left, collected=list()){
         pos <- single_match(left)
         if (pos == 0){
           return(matched(FALSE, left, collected))
         }
         match = left[[pos]]
         left_ = left[-pos]
         
         same_name <- Filter( function(l) identical(name(), l$name())
                            , collected)
         if (class(value) %in% c("list", "integer")){
           
           if (is.integer(value)){
             match$value <- 1L
           }
           
           if (length(same_name)){  
             if (is.integer(value)){
               same_name[[1]]$value <- same_name[[1]]$value + match$value
             } else {
               same_name[[1]]$value <- c(same_name[[1]]$value, match$value)
             }
             #print(collected)
             return(matched(TRUE, left_, collected))
           }
         }
         #print(ls.str())
         matched(TRUE, left_, c(collected,match))
       },
       single_match = function(left){
         base::match( name()
                    , sapply(left, function(l) l$name())
                    , nomatch = 0
                    )
       }
))

# class Required extends Pattern
Required <- setRefClass("Required", contains="Pattern"
                       , methods=list(
        match = function(left, collected=list()){
          m <- matched(TRUE, left, collected)
          for (p in children){
            m <- p$match(m$left, m$collected)
            if (!m$matched){
              return(matched(FALSE, left, collected))
            }
          }
          m
        }
))
# 
# class Optional extends Pattern
Optional <- setRefClass("Optional", contains="Pattern"
                       , methods=list(
       match = function(left, collected=list()){
         m <- matched(FALSE, left, collected)
         for (p in children){
           m <- p$match(m$left, m$collected)
         }
         m$matched <- TRUE
         m
       }
))

# class AnyOptions extends Optional
AnyOptions <- setRefClass("AnyOptions", contains="Optional")

# 
# class OneOrMore extends Pattern
OneOrMore <- setRefClass("OneOrMore", contains="Pattern"
                        , methods=list(
#     match: (left, collected=[]) ->
        match = function(left, collected=list()){
          m <- matched(TRUE, left, collected)
          #         l_ = []
          l_ <- character()
          #         times = 0
          times <- 0L
          #         while matched
          while (m$matched){
          #             # could it be that something didn't match but changed l or c?
          #             [matched, l, c] = @children[0].match(l, c)
            m <- children[[1]]$match(m$left, m$collected)
          #             times += if matched then 1 else 0
            if (m$matched){
              times <- times + 1L
            }
          #             if l_.join(', ') is l.join(', ') then break
            if (identical(paste0(l_, collapse=", "), paste0(m$left, collapse=", "))){ 
              break
            }
          #             l_ = l #copy(l)
            l_ <- m$left
          }
          #         if times >= 1 then return [true, l, c]
          if (times >= 1){
            matched(TRUE, m$left, m$collected)
          } else {
            #         [false, left, collected]
            matched(FALSE, left, collected)
          }
        }
))
# 
# class Either extends Pattern
Either <- setRefClass("Either", contains="Pattern"
                         , methods=list(
#     match: (left, collected=[]) ->
       match = function(left, collected=list()){
         #         outcomes = []
         m <- matched(FALSE, left, collected)
         outcomes <- lapply(children, function(p){
           p$match(left, collected)
         })
         outcomes <- Filter(function(p){
           p$matched
         }, outcomes)
         #         if outcomes.length > 0
         if (length(outcomes)){
         #             outcomes.sort((a,b) ->
           sizes <- sapply(outcomes, function(o) length(o$left))
           #                 if a[1].length > b[1].length
           #                     1
           #                 else if a[1].length < b[1].length
           #                     -1
           #                 else
           #                     0)
           #             return outcomes[0]
           return(outcomes[[which.min(sizes)]])
         }
         #         [false, left, collected]
         matched(FALSE, left, collected)
       }
    ))

#' as.character.Pattern
#' 
#' as.character.Pattern
#' @keywords internal
setMethod("as.character", "Pattern", function(x, ...){
 x$toString() 
})

# utility function for returning a tuple of a match
matched <- function(matched, left, collected){
  list(matched=matched, left=left, collected=collected)
}


# utility function for collecting options
OptionList <- setRefClass( "OptionList"
                          , fields = list(options="list")
                          , methods=list(
  initialize = function(.options=list()){
    options <<- .options
  },
  push = function(o){
    options <<- append(options, o)
  }
))