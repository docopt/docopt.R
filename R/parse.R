parse_shorts <- function(tokens, optionlist){
  left <- substring(tokens$move(), 2)
  parsed <- list()
  while(nchar(left) > 0){
    r <- paste0("-", substr(left, 1, 1))
    left <- substring(left, 2)
    simular <- Filter( function(o){
                 !is.null(o$short) && substring(o$short, 1, 3) == r
               }
               , optionlist$options)
    if (length(simular) > 1){
      tokens$error(r, "is specified ambiguously ", length(simular), " times")
    }
    
    if (length(simular) < 1){
      o = Option(r, NULL)
      if (tokens$strict){
        o = Option(r, value=TRUE) # needed for version and help
      } else {
        optionlist$push(o)
      }
    } else {
      simular = tail(simular, 1)[[1]]
      o <- Option(simular$short, simular$long, simular$argcount, simular$value)
      value <- ""
      if (simular$argcount != 0){ 
        if (left == ""){
          if (tokens$current() %in% c("", "--"))
            tokens$error(o$short, "requires argument")
          value <- tokens$move()
        } else {
          value <- left
        }
        left = ""
      }
      if (tokens$strict){
        o$value <- if (value != "") value else TRUE 
      }
    }
    parsed <- c(parsed, o)
  }
  parsed
}
starts_with <- function(x, start){
  identical(str_sub(x, 1, nchar(start)), start)
}

# 
# 
# parse_long = (tokens, options) ->
parse_long <- function(tokens, optionlist){
  m <- str_match(tokens$current(), "(.*?)=(.*)")
  if (!any(is.na(m))){
    raw <- m[,2]
    value <- m[,3]
  } else {
    raw <- tokens$current()
    value <- NULL
  }
  tokens$move()
  check <- if (tokens$strict) starts_with else identical
  simular <- Filter(function(o){
    (nchar(o$long) && check(o$long, raw))
  }, optionlist$options)
  if (length(simular) > 1){
    simular <- Filter(function(o){
      identical(o$long, raw)
    }, simular)
    if (length(simular) != 1){
      tokens$error(raw, " is specified ambigously")
    }
  }
  #     if simular.length < 1
  if (length(simular) < 1){
    argcount <- if (is.null(value)) 0 else 1
    o <- Option(NULL, raw, argcount)
    if (tokens$strict){
      o <- Option(NULL, raw, argcount, if (argcount > 0) value else TRUE)
    } else {
      optionlist$push(o)
    }
    return(list(o))
  }
  simular <- simular[[1]]
  o <- Option(simular$short, simular$long, simular$argcount, simular$value)
  if (o$argcount == 1){
    if (is.null(value)){
      if (tokens$current() == ""){
        tokens$error(o$name(), " requires argument")
      }
      value <- tokens$move()
    }
  } else if (!is.null(value)){
    tokens$error(o$name(), " must not have an argument")
  }
  o$value <- if (is.null(value) || identical(value, FALSE)) TRUE else value
  list(o)
}

parse_pattern <- function(src, optionlist){
  src <- gsub("([\\(\\)\\|]|\\[|\\]|\\.\\.\\.)", ' \\1 ', src)
  tokens <- Tokens(src, cat)
  result <- parse_expr(tokens, optionlist)
  if (tokens$current() != ''){
    stop("unexpected ending:'", tokens$join(" "),"'", call. = FALSE)
  }
  Required(result)
}

parse_expr <- function(tokens, optionlist){
  seq <- parse_seq(tokens, optionlist)
  if (tokens$current() != "|"){
    return(seq)
  }
  
  optional <- FALSE
  result <- if(length(seq)>1) list(Required(seq)) else seq
  if (length(seq) == 0) optional <- TRUE
  
  while(tokens$current() == "|"){
    tokens$move()
    seq <- parse_seq(tokens, optionlist)
    if (length(seq) == 0) optional <- TRUE    
    result <- c(result, if (length(seq)>1)list(Required(seq)) else seq)
  }
  
  if (length(result)>1){
    result <- list(Either(result))
  }
  
  if (optional){
    result <- list(Optional(result))
  }
  
  result
}

parse_seq <- function(tokens, optionlist){ 
# seq ::= ( atom [ '...' ] )* ;
  result <- list()
  while(!isTRUE(tokens$current() %in% c("", "]", ")", "|"))){
    atom <- parse_atom(tokens, optionlist)
    if (isTRUE(tokens$current() == '...')){
      atom <- OneOrMore(atom)
      tokens$move()
    }
    result <- c(result, atom)
  }
  result
}
 

parse_atom <- function(tokens, optionlist){
  # atom ::= '(' expr ')' | '[' expr ']' | '[' 'options' ']' | '--'
  #        | long | shorts | argument | command ;
  token <- tokens$current()
  result <- list()
  if (token == '('){
    tokens$move()
    result <- list(Required(parse_expr(tokens, optionlist)))
    if (tokens$move() != ")"){
      tokens$error("Unmatched '('")
    }
    result
  } else if (token == '['){
    tokens$move()
    if (tokens$current() == 'options'){
      result = list(Optional(list(AnyOptions())))
      tokens$move()
    } else {
      result <- list(Optional(parse_expr(tokens, optionlist)))
    }
    if (tokens$move() != "]"){
      tokens$error("Unmatched '['")
    }
    result
  } else if (substr(token, 1, 2) == '--' ){
    if (token == '--'){
      list(Command(tokens$move()))
    } else {
      parse_long(tokens, optionlist)
    }
  } else if (substr(token,1,1) == '-' && token != '-'){
    parse_shorts(tokens, optionlist)
  } else if (grepl("^<.+>$", token) || grepl("^[^a-z]*[A-Z]+[^a-z]*$", token)){
    list(Argument(tokens$move()))
  } else{
    #         [new Command tokens.move()]
    list(Command(tokens$move()))
  }
}

# 
# parse_args = (source, options) ->
parse_args <- function(src, optionlist){
#     tokens = new TokenStream source, DocoptExit
  tokens <- Tokens(src)
#     #options = options.slice(0) # shallow copy, not sure if necessary
#     opts = []
  opts = list()
  #     while (token = tokens.current()) isnt null
  while ((token <- tokens$current()) != "")
    if (token == '--'){
        ## if token is '--' then this and the rest of the arguments
        ## are positional arguments.
        return(c(opts, lapply(tokens$tokens, function(x) Argument(NULL, x))))
    } else if (grepl("^--", token)){
      #         else if token[0...2] is '--'
      #             long = parse_long tokens, options
      #             opts = opts.concat long
      long <- parse_long(tokens, optionlist)
      opts <- c(opts, long)
    } else if (grepl("^-.+", token)){
      #         else if token[0] is '-' and token isnt '-'
      #             shorts = parse_shorts tokens, options
      #             opts = opts.concat shorts
      shorts = parse_shorts(tokens, optionlist)
      opts <- c(opts, shorts)
    } else {
      opts <- c(opts, Argument(NULL, tokens$move()))
    }
  return(opts)
}

parse_option <- function(description){
#         description = description.replace(/^\s*|\s*$/g, '')
  # strip whitespaces
  description <- str_trim(description)
#         [_, options,
#          description] = description.match(/(.*?)  (.*)/) ? [null, description, '']
  # split on first occurence of 2 consecutive spaces ('  ')
  m <- str_match(description, "(.*?)  (.*)")
  if (any(is.na(m))){
    options <- description
  } else {
  options <- m[,2]
  }
#         # replace ',' or '=' with ' '
#         options = options.replace /,|=/g, ' '
  options <- gsub(",|=", " ", options)
#         # set some defaults
  short <- NULL
  long <- NULL
  argcount <- 0 
  value <- FALSE
  for (s in strsplit(options, "\\s+")[[1]]){
    if (substring(s, 1, 2) == "--"){
      long <- s
    } else if (substring(s, 1,1) == '-'){
      short <- s
    } else {
      argcount <- 1
    }
  }
#         if argcount is 1
  if (argcount == 1){
    matched <- str_match(description, "(?i)\\[default:\\s+(.*)\\]")
    value <- matched[,2]
    if (is.na(value)) value <- NULL
  }
  Option(short, long, argcount, value)
#         new Option short, long, argcount, value
}

# parse_doc_options = (doc) ->
parse_doc_options <- function(doc){
  #     (Option.parse('-' + s) for s in doc.split(/^\s*-|\n\s*-/)[1..])
  OptionList(lapply(tail(unlist(str_split(doc, stringr::regex("(?i)^\\s*-|\\n\\s*-|Options:\\s*-"))),-1), function(s){
    parse_option(paste0('-', s))
  }))
}
