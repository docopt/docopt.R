\docType{methods}
\name{[,Tokens-method}
\alias{[,Tokens-method}
\title{index tokens}
\usage{
\S4method{[}{Tokens}(x, i, drop = TRUE)
}
\arguments{
  \item{x}{ object from which to extract element(s) or in
  which to replace element(s).  }

  \item{i}{ indices specifying elements to extract or
  replace.  Indices are \code{numeric} or \code{character}
  vectors or empty (missing) or \code{NULL}.  Numeric
  values are coerced to integer as by
  \code{\link{as.integer}} (and hence truncated towards
  zero).  Character vectors will be matched to the
  \code{\link{names}} of the object (or for
  matrices/arrays, the \code{\link{dimnames}}): see
  \sQuote{Character indices} below for further details.

  For \code{[}-indexing only: \code{i}, \code{j},
  \code{\dots} can be logical vectors, indicating
  elements/slices to select.  Such vectors are recycled if
  necessary to match the corresponding extent.  \code{i},
  \code{j}, \code{\dots} can also be negative integers,
  indicating elements/slices to leave out of the selection.

  When indexing arrays by \code{[} a single argument
  \code{i} can be a matrix with as many columns as there
  are dimensions of \code{x}; the result is then a vector
  with elements corresponding to the sets of indices in
  each row of \code{i}.

  An index value of \code{NULL} is treated as if it were
  \code{integer(0)}.  }

  \item{drop}{For matrices and arrays.  If \code{TRUE} the
  result is coerced to the lowest possible dimension (see
  the examples).  This only works for extracting elements,
  not for the replacement.  See \code{\link{drop}} for
  further details.  }
}
\description{
index tokens
}
\keyword{internal}

