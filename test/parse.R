options <- list(a=Option("-a", "-all"), b=Option("-b", "-best"))
parse_shorts(Tokens("-ab"),options)

parse_atom(Tokens("-c help", cat), options)
parse_atom(Tokens("[ -a | -b ]"), options)
parse_atom(Tokens("( -a | -b )"), options)
parse_atom(Tokens("( -a | -b )"), options)

parse_pattern("test", options)
