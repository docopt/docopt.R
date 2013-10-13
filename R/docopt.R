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

# parse_doc_options = (doc) ->
#     (Option.parse('-' + s) for s in doc.split(/^\s*-|\n\s*-/)[1..])
# 
# printable_usage = (doc, name) ->
#     usage_split = doc.split(/(usage:)/i)
#     if usage_split.length < 3
#         throw new DocoptLanguageError '"usage:" (case-insensitive) not found.'
#     else if usage_split.length > 3
#         throw new DocoptLanguageError 'More than one "usage:" (case-insensitive).'
#     return usage_split[1..].join('').split(/\n\s*\n/)[0].replace(/^\s+|\s+$/, '')
# 
# formal_usage = (printable_usage) ->
#     pu = printable_usage.split(/\s+/)[1..]  # split and drop "usage:"
#     ((if s == pu[0] then '|' else s) for s in pu[1..]).join ' '
# 
# extras = (help, version, options, doc) ->
#     opts = {}
#     opts[opt.name()] = true for opt in options when opt.value
#     if help and (opts['--help'] or opts['-h'])
#         print doc.replace /^\s*|\s*$/, ''
#         process.exit()
#     if version and opts['--version']
#         print version
#         process.exit()
# 
# class Dict extends Object
# 
#     constructor: (pairs) ->
#         (@[key] = value for [key, value] in pairs)
# 
#     toString: () ->
#         atts = (k for k of @ when k not in ['constructor', 'toString'])
#         atts.sort()
#         '{' + (k + ': ' + @[k] for k in atts).join(',\n ') + '}'
# 
# docopt = (doc, kwargs={}) ->
#     allowedargs = ['argv', 'name', 'help', 'version']
#     throw new Error "unrecognized argument to docopt: " for arg of kwargs \
#         when arg not in allowedargs
# 
#     argv    = if kwargs.argv is undefined \
#               then process.argv[2..] else kwargs.argv
#     name    = if kwargs.name is undefined \
#               then null else kwargs.name
#     help    = if kwargs.help is undefined \
#               then true else kwargs.help
#     version = if kwargs.version is undefined \
#               then null else kwargs.version
# 
#     usage = printable_usage doc, name
#     pot_options = parse_doc_options doc
#     formal_pattern   = parse_pattern formal_usage(usage), pot_options
# 
#     argv = parse_args argv, pot_options
#     extras help, version, argv, doc
#     [matched, left, argums] = formal_pattern.fix().match argv
#     if matched and left.length is 0  # better message if left?
#         options = (opt for opt in argv when opt.constructor is Option)
#         pot_arguments = (a for a in formal_pattern.flat() \
#             when a.constructor in [Argument, Command])
#         parameters = [].concat pot_options, options, pot_arguments, argums
#         return new Dict([a.name(), a.value] for a in parameters)
#     throw new DocoptExit usage