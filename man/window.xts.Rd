% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/xts.methods.R
\name{window.xts}
\alias{window.xts}
\title{Extract Time Windows from xts Objects}
\usage{
\method{window}{xts}(x, index. = NULL, start = NULL, end = NULL, ...)
}
\arguments{
\item{x}{An xts object.}

\item{index.}{A user defined time index (default \code{.index(x)}).}

\item{start}{A start time coercible to POSIXct.}

\item{end}{An end time coercible to POSIXct.}

\item{\dots}{Unused.}
}
\value{
The subset of \code{x} that matches the time window.
}
\description{
Method for extracting time windows from xts objects.
}
\details{
The xts \code{window()} method provides an efficient way to subset an xts object
between a start and end date using a binary search algorithm. Specifically,
it converts \code{start} and \code{end} to POSIXct and then does a binary search of
the index to quickly return a subset of \code{x} between \code{start} and \code{end}.

Both \code{start} and \code{end} may be any class that is convertible to POSIXct, such
as a character string in the format \sQuote{yyyy-mm-dd}. When \code{start = NULL}
the returned subset will begin at the first value of \code{index.}. When
\code{end = NULL} the returned subset will end with the last value of \code{index.}.
Otherwise the subset will contain all timestamps where \code{index.} is between
\code{start} and \code{end}, inclusive.

When \code{index.} is specified, \code{\link[=findInterval]{findInterval()}} is used to quickly retrieve
large sets of sorted timestamps. For the best performance, \code{index.} must be
a \emph{sorted} POSIXct vector or a numeric vector of seconds since the epoch.
\code{index.} is typically a subset of the timestamps in \code{x}.
}
\examples{

## xts example
x.date <- as.Date(paste(2003, rep(1:4, 4:1), seq(1,19,2), sep = "-"))
x <- xts(matrix(rnorm(20), ncol = 2), x.date)
x

window(x, start = "2003-02-01", end = "2003-03-01")
window(x, start = as.Date("2003-02-01"), end = as.Date("2003-03-01"))
window(x, index. = x.date[1:6], start = as.Date("2003-02-01"))
window(x, index. = x.date[c(4, 8, 10)])

## Assign to subset
window(x, index. = x.date[c(4, 8, 10)]) <- matrix(1:6, ncol = 2)
x

}
\seealso{
\code{\link[=subset.xts]{subset.xts()}}, \code{\link[=findInterval]{findInterval()}}, \code{\link[=xts]{xts()}}
}
\author{
Corwin Joy
}
\keyword{ts}
