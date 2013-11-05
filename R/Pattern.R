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
                          
#     flat: ->
#         if not @hasOwnProperty 'children' then return [@]
#         res = []
#         res = res.concat child.flat() for child in @children
#         res 
        flat = function(){
            if (length(children) == 0){
              return(list(.self))
            }
            unlist(lapply(children, function(child){child$flat()}))
          },
  
        fix = function(){
          fix_identities()
          fix_list_arguments()
        },
        #Make pattern-tree tips point to same object if they are equal.
        fix_identities = function(uniq=NULL){
          #         if not @hasOwnProperty 'children' then return @
          # browser()
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
#     fix_list_arguments: ->
#         """Find arguments that should accumulate values and fix them."""
        fix_list_arguments = function(){
          #         either = (c.children for c in @either().children)
          eith <- lapply(either()$children, function(c) c$children)
            #         for child in either
          for (child in eith){
            nms <- sapply(child, as.character)
            counts <- table(nms)
            for (e in child){
              if (counts[as.character(e)] > 1 && class(e) == "Argument"){
                e$value <- list()
              }
            }
          }
          #             counts = {}
          #             for c in child
          #                 counts[c] = (counts[c] ? 0) + 1
          #             e.value = [] for e in child \
          #                 when counts[e] > 1 and e.constructor is Argument
          .self
        },
#     either: ->
        either = function(){
          #         if not @hasOwnProperty 'children'
          #             return new Either [new Required [@]]
          #browser()
          if (length(children) == 0){
            return(Either(list(Required(list(.self)))))
          }
#         else
          ret <- list()
          #             groups = [[@]]
          groups <- list(list(.self))
#             while groups.length
          while (length(groups)){
#                 children = groups.shift()
            .children <- head(groups, 1)
            groups <- tail(groups, -1)
            #                 [i, indices, types] = [0, {}, {}]
            indices <- list(); types <- list()
#                 zip = ([i++, c] for c in children)
            enum <- seq_along(.children)
            #                 for [i,c] in zip
            for (i in seq_along(.children)){
              ci <- .children[i]
              type <- class(ci)
              types[[type]] <- append(type[type], ci)
#                     name = c.constructor.name
#                     if name not of types
#                         types[name] = []
#                     types[name].push c
#                     if c not of indices
#                         indices[c] = i 
            }
#                 if either = types[Either.name]
#                     either = either[0]
#                     children.splice indices[either], 1
#                     for c in either.children
#                         group = [c].concat children
#                         groups.push group
#                 else if required = types[Required.name]
#                     required = required[0]
#                     children.splice indices[required], 1
#                     group = required.children.concat children
#                     groups.push group
#                 else if optional = types[Optional.name]
#                     optional = optional[0]
#                     children.splice indices[optional], 1
#                     group = optional.children.concat children
#                     groups.push group
#                 else if oneormore = types[OneOrMore.name]
#                     oneormore = oneormore[0]
#                     children.splice indices[oneormore], 1
#                     group = oneormore.children
#                     group = group.concat group, children
#                     groups.push group
#                 else
#                     ret.push children
          }
#             return new Either(new Required e for e in ret)
          Either(lapply(ret, function(e) Required(e)))
        }
))

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
         #         if not args.length then return [false, left, collected]
         if (!length(arg)){
           return(matched(FALSE, left, collected))
         }
         arg <- left[[arg]]
         #         left = (l for l in left when l.toString() isnt args[0].toString())
         left <- Filter(function(l){!identical(l, arg)}, left)
         #         if @value is null or @value.constructor isnt Array
         if (is.null(value) || !is.list(value)){
         #             collected = collected.concat [new Argument @name(), args[0].value]
           collected <- c(collected, Argument(name(), arg$value))
         #             return [true, left, collected]
           return(matched(TRUE, left, collected))
         }
         #         same_name = (a for a in collected \
         #             when a.constructor is Argument and a.name() is @name())
         same_name <- Filter(function(a){
                               class(a) == "Argument" && identical(a$name(), name())
                             }
                            , collected)
         #         if same_name.length > 0
         if (length(same_name)){
           same_name[[1]]$value <- c(same_name[[1]]$value, arg$value)
           return(matched(TRUE, left, collected))
         } else{
         #             collected = collected.concat [new Argument @name(), [args[0].value]]
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
        argsidx <- which(sapply(left, class) == "Arguments")
        firstarg <- head(argsidx,1)
        #         args = (l for l in left when l.constructor is Argument)
        #         if not args.length or args[0].value isnt @name()
        if (!length(firstarg) || left[[firstarg]]$value != name()){
        #             return [false, left, collected]{
          return(matched(FALSE, left, collected))
        }
        #         left.splice(left.indexOf(args[0]), 1)
        left <- left[[-firstarg]]
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
                     , fields = c("short", "long", "argcount", "value")
                     , methods = list(
#     constructor: (@short=null, @long=null, @argcount=0, @value=false) ->
                       initialize= function(short=NULL, long=NULL, argcount=0, value=FALSE){
                         short <<- short
                         long <<- long
                         argcount <<- argcount
                         value <<- value
                       },
                       toString = function(){
                         paste0("Option(",short,",",long,",",argcount,",", value,")")
                       },
# 
#     name: -> @long or @short
                       name = function(){
                         if (!is.null(long)) long else short
                       },
#     match: (left, collected=[]) ->
       match = function(left, collected=list()){
         #         left_ = (l for l in left when (l.constructor isnt Option \
         #browser()
         left_ <- Filter(function(l){
           class(l) != "Option" || short != l$short || long != l$long
         }, left)
         #                  or @short isnt l.short or @long isnt l.long))
         #         [left.join(', ') isnt left_.join(', '), left_, collected]
         matched(!identical(left_, left), left_, collected)
       }
))
# class AnyOptions extends Pattern
AnyOptions <- setRefClass("AnyOptions", contains="Pattern"
     , methods = list(
#     match: (left, collected=[]) ->
#         left_ = (l for l in left when l.constructor isnt Option)
#         [left.join(', ') isnt left_.join(', '), left_, collected]
       match = function(left, collected=list()){
         left_ = Filter(function(l){class(l) != "Option"}, left)
         matched(!identical(left, left_), left_, collected)
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
          times <- 0
          #         while matched
          while (m$matched){
          #             # could it be that something didn't match but changed l or c?
          #             [matched, l, c] = @children[0].match(l, c)
            m <- children[[1]]$match(m$left, m$collected)
          #             times += if matched then 1 else 0
            if (m$matched){
              times <- times + 1
            }
          #             if l_.join(', ') is l.join(', ') then break
            if (identical(str_c(l_, sep=", "), str_c(m$left, sep=", "))){ 
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

setMethod("as.character", "Pattern", function(x, ...){
 x$toString() 
})

# utility function for returning a tuple of a match
matched <- function(matched, left, collected){
  list(matched=matched, left=left, collected=collected)
}


# utility function for options
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