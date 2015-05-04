#' Parse \code{args} based on command-line interface described in \code{doc}.
#' 
#' \code{docopt} creates your command-line interface based on its
#' description that you pass as \code{doc}. 
#' Such description can contain
#' --options, <positional-argument>, commands, which could be
#' [optional], (required), (mutually | exclusive) or repeated...
#' 
#' @examples
#' "Usage: my_program.R [-hso FILE] [--quiet | --verbose] [INPUT ...]
#'
#' -h --help    show this
#' -s --sorted  sorted output
#' -o FILE      specify output file [default: ./test.txt]
#' --quiet      print less text
#' --verbose    print more text" -> doc
#' docopt(doc, "-s --quiet")
#' @param doc \code{character} vector with command line specification
#' @param args \code{character} vector of commandline arguments. 
#' If \code{args} is missing 
#' \code{commandArgs(trailingOnly=TRUE)} will be used.
#' @param name Currently not used
#' @param help \code{logical} should "-h" or "--help" generate a usage string?
#' @param version \code{character}. If supplied the option "-v" generates
#' the given version number and stops.
#' @param strict \code{logical} if \code{TRUE} docopt will conform to docopt.py 
#' in and output (\code{strip_names=FALSE} and \code{quoted_args=FALSE})
#' @param strip_names if \code{TRUE} it will remove dashes and angles from the 
#' resulting names and add these to the resulting list. 
#' Note that this is different from docopt standard! 
#' @param quoted_args if \code{TRUE} it will accept quoted arguments. 
#' Note that this is different from docopt standard! 
#' @return named list with all parsed options, arguments and commands.
#' @references \url{http://docopt.org},
#' @export
#' @import methods stringr
docopt <- function( doc, args=commandArgs(TRUE), name=NULL, help=TRUE, version=NULL
                  , strict=FALSE, strip_names=!strict, quoted_args=!strict
                  ){
  # littler compatibility - map argv vector to args
  if (exists("argv", where = .GlobalEnv, inherits = FALSE)) {
    args = get("argv", envir = .GlobalEnv);
  }
  
  args <- str_c(args, collapse=" ")
  usage <- printable_usage(doc, name)
  pot_options <- parse_doc_options(doc)
  pattern <- parse_pattern(formal_usage(usage), pot_options)
  
  for (anyopt in pattern$flat("AnyOptions")){
    #TODO remove options that are present in pattern
    if (class(anyopt) == "AnyOptions") anyopt$children <- pot_options$options
  }
  
  args <- parse_args(args, pot_options)
  extras(help, version, args, doc)
  m <- pattern$fix()$match(args)
  if (m$matched && length(m$left) == 0){    
    cl <- sapply(m$collected, class)
    options <- m$collected[cl == "Option"]
    
    pot_arguments <- pattern$flat()
    pot_arguments <- pot_arguments[sapply(pot_arguments, class) %in% 
                                     c("Argument", "Command")]
    
    arguments <- m$collected
    arguments <- arguments[sapply(arguments, class) %in% c("Argument", "Command")]
    dict <- list()
    
    #for(kv in c(pot_options$options, options, pattern$flat(), m$collected)){
    for(kv in c(pot_options$options, options, pot_arguments, arguments)){
      value <- kv$value
      dict[kv$name()] <- list(value)
    }
    if (isTRUE(strip_names)){
      nms <- gsub("(^<)|(^\\-\\-?)|(>$)", "", names(dict))
      dict[nms] <- dict
    }
    return(dict)
  }
  stop(paste(usage, collapse="\n  "))
}
         
# print help
help <- function(doc){
  cat(doc, "\n")
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
    cat(help,"\n")
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
  usage_split <- stringr::str_split(doc, stringr::regex("(?i)usage:\\s*"))[[1]]
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
