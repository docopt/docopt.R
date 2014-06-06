#' docopt commandline parser
#' 
#' docopt helps you to specify a command line interface and generates a parser
#' for it.
#' @param doc \code{character} vector with command line specification
#' @param args \code{character} vector of commandline arguments. 
#' If \code{args} is missing 
#' \code{commandArgs(trailingOnly=TRUE)} will be used.
#' @param name Currently not used
#' @param help \code{logical} should "-h" or "--help" generate a usage string?
#' @param version \code{character}. If supplied the option "-v" generates 
#' the given version number and stops.
#' @export
docopt <- function(doc, args, name=NULL, help=TRUE, version=NULL){
  if (missing(args)){
    args <- commandArgs(trailingOnly=TRUE)
  }
  args <- str_c(args, collapse=" ")
  usage <- printable_usage(doc, name)
  pot_options <- parse_doc_options(doc)
  formal_pattern <- parse_pattern(formal_usage(usage), pot_options)
  
#   tryCatch({
    args <- parse_args(args, pot_options)
    extras(help, version, args, doc)
#     [matched, left, argums] = formal_pattern.fix().match argv
    #fp <- formal_pattern$fix()
    #print(fp)
    m <- formal_pattern$fix()$match(args)
    #m <- formal_pattern$match(args)
    #     if matched and left.length is 0  # better message if left?
    
    if (m$matched && length(m$left) == 0){    
      cl <- sapply(args, class)
      options <- args[cl == "Option"] 
    #         pot_arguments = (a for a in formal_pattern.flat() \
    #             when a.constructor in [Argument, Command])
      pot_arguments <- formal_pattern$flat()
      pot_arguments <- pot_arguments[sapply(pot_arguments, class) %in% 
                                       c("Argument", "Command")]
      
      arguments <- m$collected
      arguments <- arguments[sapply(arguments, class) %in% c("Argument", "Command")]
      
    #         parameters = [].concat pot_options, options, pot_arguments, argums
      dict <- list()
      for(kv in c(pot_options$options, options, pot_arguments, arguments)){
        value <- kv$value
        dict[kv$name()] <- list(value)
      }
    #         return new Dict([a.name(), a.value] for a in parameters)
      return(dict)
    }
  stop(usage)
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

extras <- function(help, version=NULL, options, doc){
  opts <- list()
  for (opt in options){
    if (!is.null(opt$value)){
      opts[opt$name()] <- TRUE
    }
  }
  if (help && any(names(opts) %in% c("-h","--help"))){
    help <- str_replace_all(doc, "^\\s*|\\s*$", "")
    cat(help)
    if (interactive()) stop() else {
      quit(save="no")
    }
  }
  if (!is.null(version) && any(names(opts) %in% "--version")){
    cat(version)
    if (interactive()) stop() else quit(save="no")
  }
}

printable_usage <- function(doc, name){
  usage_split <- str_split(doc, perl("(?i)usage:\\s*"))[[1]]
  if (length(usage_split) < 2){
    stop("'usage:' (case-insensitive) not found")
  } else if (length(usage_split) > 2){
    stop('More than one "usage:" (case-insensitive).')
  }
  usage <- str_split(usage_split[2], "\n\\s*")[[1]]
  firstword <- str_extract(usage, "^\\w+")
  progs <- which(firstword == firstword[1])
  usage <- str_c("usage: ", usage[progs])
  str_trim(usage)
}

# 
formal_usage <- function(printable_usage){
# formal_usage = (printable_usage) ->
#     pu = printable_usage.split(/\s+/)[1..]  # split and drop "usage:"
#     ((if s == pu[0] then '|' else s) for s in pu[1..]).join ' '
  formal <- str_replace(printable_usage, "^usage:\\s*", "")
  pu <- unlist(str_split(formal, "\\s+"))
  prog <- pu[1]
  pu[pu==prog] <- "|"
  formal <- str_c(tail(pu, -1), collapse=" ")
  formal
}
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
