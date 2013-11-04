parse_shorts <- function(tokens, optionlist){
  raw <- substring(tokens$shift(), 2)
  parsed <- list()
  while(nchar(raw) > 0){
    r <- substr(raw, 1, 1)
#         opt = (o for o in options when o.short isnt null and o.short[1] == raw[0])
    opt <- Filter( function(o){
                 !is.null(o$short) && substring(o$short, 2, 3) == r
               }
               , optionlist$options)
  if (length(opt) > 1){
#         if opt.length > 1
#             tokens.error "-#{raw[0]} is specified ambiguously #{opt.length} times"
    tokens$error("-", r, " is specified ambiguously ", length(opt), "times")
  } else if (length(opt) < 1){
#         if opt.length < 1
#             if tokens.error is DocoptExit
#                 throw new tokens.error "-#{raw[0]} is not recognized"
    if (tokens$strict){
      tokens$error("-", r, " is not recognized")
    } else {
      #tokens$error("-",r," is not recognized")
    #             else
    #                 o = new Option('-' + raw[0], null)
    #                 options.push(o)
    #                 parsed.push(o)
    #                 raw = raw[1..]
    #                 continue
      o = Option(paste0("-", r), NULL)
      optionlist$push(o)
      parsed <- append(parsed, o)
      raw <- substring(raw, 2)
      next
    }
  }

#         o = opt[0]
  o = opt[[1]]
#         opt = new Option o.short, o.long, o.argcount, o.value
  opt <- Option(o$short, o$long, o$argcount, o$value)
#         raw = raw[1..]
  raw <- substring(raw, 2)
#         if opt.argcount == 0
  if (opt$argcount == 0){
    value <- TRUE
  } else {
#             value = true
#         else
#             if raw in ['', null]
#                 if tokens.current() is null
#                     throw new tokens.error "-#{opt.short[0]} requires argument"
#                 raw = tokens.shift()
#             [value, raw] = [raw, '']
    if (raw == ""){
      if (length(tokens$current())==0){
        tokens$error("-", substr(opt$short,2,1)," requires argument")
      }
      raw <- tokens$shift()
      value <- raw
      raw <- ''
    }
  }
#         opt.value = value
  opt$value <- value
#         parsed.push opt
  parsed <- c(parsed, opt)
  }
  parsed
#     return parsed
}
# 
# 
# parse_long = (tokens, options) ->
parse_long <- function(tokens, optionlist){
  #     [_, raw, value] = tokens.current().match(/(.*?)=(.*)/) ? [null,
  #                                                 tokens.current(), '']
  m <- str_match(tokens$current(), "(.*?)=(.*)")
  if (!any(is.na(m))){
    raw <- m[,2]
    value <- m[,3]
  } else {
    raw <- tokens$current()
    value <- NULL
  }
  #     tokens.shift()
  tokens$shift()
  #     value = if value == '' then null else value
  #     opt = (o for o in options when o.long and o.long[0...raw.length] == raw)
  opt <- Filter(function(o){
    (nchar(o$long) && str_sub(o$long, 1, nchar(raw)) == raw)
  }, optionlist$options)
  #     if opt.length > 1
  if (length(opt) > 1){
    tokens$error(raw, " is specified ambigously")
  }
  #     if opt.length < 1
  if (length(opt) < 1){
  #         if tokens.error is DocoptExit
    if (tokens$strict){
  #             throw new tokens.error "#{raw} is not recognized"
      tokens$error(raw, " is not recognized")
    } else {
  #         else
  #             o = new Option(null, raw, +!!value)
      o <- Option(NULL, raw, as.logical(value))
  #             options.push(o)
      optionlist$push(o)
  #             return [o]
      return(list(o))
  }}
  #     o = opt[0]
  o <- opt[[1]]
  #     opt = new Option o.short, o.long, o.argcount, o.value
  opt <- Option(o$short, o$long, o$argcount, o$value)
  #     if opt.argcount == 1
  if (opt$argcount == 1){
  #         if value is null
    if (is.null(value)){
  #             if tokens.current() is null
      if (tokens$current == ""){
  #                 tokens.error "#{opt.name()} requires argument"
        tokens$error(opt$name(), " requires argument")
      }
  #             value = tokens.shift()
      value <- tokens$shift()
    }
  } else if (!is.null(value)){
  #     else if value is not null
  #         tokens.error "#{opt.name()} must not have an argument"
    tokens$error(opt$name(), " must not have an argument")
  }
  #     opt.value = value or true
  opt$value <- if (is.null(value) || identical(value, FALSE)) TRUE else value
  #     [opt]
  list(opt)
}

parse_pattern <- function(src, optionlist){
  src <- gsub("([\\(\\)\\|]|\\[|\\]|\\.\\.\\.)", ' \\1 ', src)
  tokens <- Tokens(src, cat)
  result <- parse_expr(tokens, optionlist)
  if (tokens$current() != ''){
    stop("unexpected ending:'", tokens$join(" "),"'")
  }
  Required(result)
}

parse_expr <- function(tokens, optionlist){
  seq <- parse_seq(tokens, optionlist)
  if (tokens$current() != "|"){
    return(seq)
  }
  
  result <- if(length(seq)>1) list(Required(seq)) else seq
  while(tokens$current() == "|"){
    tokens$shift()
    seq <- parse_seq(tokens, optionlist)
    result <- c(result, if (length(seq)>1)list(Required(seq)) else seq)
  }
  
  if (length(result)>1){
    list(Either(result))
  } else result
}

parse_seq <- function(tokens, optionlist){ 
# seq ::= ( atom [ '...' ] )* ;
  result <- list()
  while(!isTRUE(tokens$current() %in% c("", "]", ")", "|"))){
    atom <- parse_atom(tokens, optionlist)
    if (isTRUE(tokens$current() == '...')){
      atom <- OneOrMore(atom)
      tokens$shift()
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
    tokens$shift()
    result <- list(Required(parse_expr(tokens, optionlist)))
    if (tokens$shift() != ")"){
      tokens$error("Unmatched '('")
    }
    result
  } else if (token == '['){
    tokens$shift()
    if (tokens$current() == 'options'){
      result = list(Optional(list(AnyOptions())))
      tokens$shift()
    } else {
      result <- list(Optional(parse_expr(tokens, optionlist)))
    }
    if (tokens$shift() != "]"){
      tokens$error("Unmatched '['")
    }
    result
  } else if (substr(token, 1, 2) == '--' ){
    #     else if token[0..1] is '--'
    #         if token is '--'
    #             [new Command tokens.shift()]
    #         else
    #             parse_long tokens, options
    if (token == '--'){
      list(Command(tokens$shift()))
    } else {
      parse_long(tokens, optionlist)
    }
  } else if (substr(token,1,1) == '-' && token != '-'){
  #     else if token[0] is '-' and token isnt '-'
  #         parse_shorts tokens, options
    parse_shorts(tokens, optionlist)
  } else if (grepl("^<.+>$", token) || grepl("^[^a-z]*[A-Z]+[^a-z]*$", token)){
    #     else if (token[0] is '<' and
    #           token[token.length-1] is '>') or /^[^a-z]*[A-Z]+[^a-z]*$/.test(token)
    #         [new Argument tokens.shift()]
    list(Argument(tokens$shift()))
  } else{
    #         [new Command tokens.shift()]
    list(Command(tokens$shift()))
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
    #         if token is '--'
    #             #tokens.shift()
    #             return opts.concat(new Argument null, tokens.shift() while tokens.length)
    if (token == '--'){
      # ????
      return(c(opts, Argument(NULL, tokens$shift())))
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
      opts <- c(opts, Argument(NULL, tokens$shift()))
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
  options <- m[,2]
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
    matched <- str_match(description, "\\[default:\\s+(.*)\\]")
    value <- matched[,2]
    if (is.na(value)) value <- FALSE
  }
  Option(short, long, argcount, value)
#         new Option short, long, argcount, value
}

# parse_doc_options = (doc) ->
parse_doc_options <- function(doc){
  #     (Option.parse('-' + s) for s in doc.split(/^\s*-|\n\s*-/)[1..])
  OptionList(lapply(tail(unlist(str_split(doc, perl("(?i)^\\s*-|\\n\\s*-|Options:\\s*-"))),-1), function(s){
    parse_option(paste0('-', s))
  }))
}
