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
                            lapply(children, flat)
                          },

                        fix = function(){
                          fix_identities()
                          fix_list_arguments()
                        },
#     fix_identities: (uniq=null) ->
#         """Make pattern-tree tips point to same object if they are equal."""
# 
#         if not @hasOwnProperty 'children' then return @
#         if uniq is null
#             [uniq, flat] = [{}, @flat()]
#             uniq[k] = k for k in flat
# 
#         i = 0
#         enumerate = ([i++, c] for c in @children)
#         for [i, c] in enumerate
#             if not c.hasOwnProperty 'children'
#                 @children[i] = uniq[c]
#             else
#                 c.fix_identities uniq
#         @
                        fix_identities = function(uniq=NULL){
                          stop("not implemented")
                        },
#     fix_list_arguments: ->
#         """Find arguments that should accumulate values and fix them."""
#         either = (c.children for c in @either().children)
#         for child in either
#             counts = {}
#             for c in child
#                 counts[c] = (counts[c] ? 0) + 1
#             e.value = [] for e in child \
#                 when counts[e] > 1 and e.constructor is Argument
#         @
                        fix_list_arguments = function(){
                          stop("not implemented")
                        },
#     either: ->
#         if not @hasOwnProperty 'children'
#             return new Either [new Required [@]]
#         else
#             ret = []
#             groups = [[@]]
#             while groups.length
#                 children = groups.shift()
#                 [i, indices, types] = [0, {}, {}]
#                 zip = ([i++, c] for c in children)
#                 for [i,c] in zip
#                     name = c.constructor.name
#                     if name not of types
#                         types[name] = []
#                     types[name].push c
#                     if c not of indices
#                         indices[c] = i
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
#             return new Either(new Required e for e in ret)
                        either = function(){
                          stop("Not implemented")
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
#         args = (l for l in left when l.constructor is Argument)
#         if not args.length then return [false, left, collected]
#         left = (l for l in left when l.toString() isnt args[0].toString())
#         if @value is null or @value.constructor isnt Array
#             collected = collected.concat [new Argument @name(), args[0].value]
#             return [true, left, collected]
#         same_name = (a for a in collected \
#             when a.constructor is Argument and a.name() is @name())
#         if same_name.length > 0
#             same_name[0].value.push args[0].value
#             return [true, left, collected]
#         else
#             collected = collected.concat [new Argument @name(), [args[0].value]]
#             return [true, left, collected]
                         match = function(left, collected=list()){
                           stop("not implemented")
                         }
))
# 
# 
# class Command extends Pattern
Command <- setRefClass("Command", contains="Pattern"
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
#         args = (l for l in left when l.constructor is Argument)
#         if not args.length or args[0].value isnt @name()
#             return [false, left, collected]
#         left.splice(left.indexOf(args[0]), 1)
#         collected.push new Command @name(), true
#         [true, left, collected]
                        match = function(left, collected=list()){
                          stop("Not implemented")
                        }
))
# 
# 
# class Option extends Pattern
Option <- setRefClass("Options", contains="Pattern"
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
#         left_ = (l for l in left when (l.constructor isnt Option \
#                  or @short isnt l.short or @long isnt l.long))
#         [left.join(', ') isnt left_.join(', '), left_, collected]
                       match = function(left, collected=list()){
                         stop("Not implemented")
                       }
))
# class AnyOptions extends Pattern
AnyOptions <- setRefClass("AnyOptions", contains="Pattern"
                         , methods = list(
#     match: (left, collected=[]) ->
#         left_ = (l for l in left when l.constructor isnt Option)
#         [left.join(', ') isnt left_.join(', '), left_, collected]
                           match = function(left, collected=list()){
                            stop("Not implemented") 
                           }                         
))


# class Required extends Pattern
Required <- setRefClass("Required", contains="Pattern"
                       , methods=list(
#     match: (left, collected=[]) ->
#         l = left #copy(left)
#         c = collected #copy(collected)
#         for p in @children
#             [matched, l, c] = p.match(l, c)
#             if not matched
#                 return [false, left, collected]
#         [true, l, c]
                          match = function(left, collected=list()){
                            stop("Not implemented")
                          }
))
# 
# class Optional extends Pattern
Optional <- setRefClass("Optional", contains="Pattern"
                       , methods=list(
#     match: (left, collected=[]) ->
#         #left = copy(left)
#         for p in @children
#             [m, left, collected] = p.match(left, collected)
#         [true, left, collected]
                         match = function(left, collected=list()){
                           stop("Not implemented")
                         }
))
# 
# class OneOrMore extends Pattern
OneOrMore <- setRefClass("OneOrMore", contains="Pattern"
                        , methods=list(
#     match: (left, collected=[]) ->
#         l = left #copy(left)
#         c = collected #copy(collected)
#         l_ = []
#         matched = true
#         times = 0
#         while matched
#             # could it be that something didn't match but changed l or c?
#             [matched, l, c] = @children[0].match(l, c)
#             times += if matched then 1 else 0
#             if l_.join(', ') is l.join(', ') then break
#             l_ = l #copy(l)
#         if times >= 1 then return [true, l, c]
#         [false, left, collected]
                          match = function(left, collected=list()){
                            stop("Not implemented")
                          }
))
# 
# class Either extends Pattern
Either <- setRefClass("Either", contains="Pattern"
                         , methods=list(
#     match: (left, collected=[]) ->
#         outcomes = []
#         for p in @children
#             outcome = p.match(left, collected)
#             if outcome[0] then outcomes.push(outcome)
#         if outcomes.length > 0
#             outcomes.sort((a,b) ->
#                 if a[1].length > b[1].length
#                     1
#                 else if a[1].length < b[1].length
#                     -1
#                 else
#                     0)
#             return outcomes[0]
#         [false, left, collected]
                           match = function(left, collected=list()){
                             stop("Not implemented")
                           }
                         ))

setMethod("as.character", "Pattern", function(x, ...){
 x$toString() 
})
