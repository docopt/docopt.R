str_extract <- function(text, pattern){
  
  m <- regexpr(pattern=pattern, text = text, perl = TRUE)
  rstart <- as.integer(m)
  rstop  <- rstart + attr(m, "match.length") - 1
  
  rstart[rstart < 0] <- 0
  rstop[rstop < 0] <- 0
  substr(text, rstart, rstop)
}

str_extract_all <- function(text, pattern){
  m_all <- gregexpr(pattern=pattern, text = text, perl=TRUE)
  lapply(seq_along(m_all), function(i){
    m <- m_all[[i]]
    rstart <- as.integer(m)
    rstop  <- rstart + attr(m, "match.length") - 1
    
    rstart[rstart < 0] <- 0
    rstop[rstop < 0] <- 0
    mapply(function(start, stop){substr(text[[i]],start, stop)}
          , rstart, rstop)
  })
}

str_trim <- function(x){
  gsub("^\\s+|\\s+$","", x)
}

str_c <- function(x, ...){
  paste0(x, ...)
}

str_split <- function(string, pattern){
  strsplit(string, split, perl=TRUE)
}

str_detect <- function(string, pattern){
  grepl(pattern, string)
}

str_sub <- function(string, start=1L, stop=-1L){
  substr(string, start = start, stop = stop)
}

str_replace <- function(string, pattern, replacement){
  sub(pattern, replacement = replacement, x = string, perl = TRUE)
}

str_replace_all <- function(string, pattern, replacement){
  gsub(pattern, replacement = replacement, x = string, perl = TRUE)
}

str_match <- function(string, pattern){
  
}

# text = c("hallo", "test", "baadd")
# pattern = "(\\w)\\1"
# 
# strextract(text = text, pattern = pattern)
# strextract_all(text = text, pattern = pattern)
