% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/endpoints.R
\name{endpoints}
\alias{endpoints}
\title{Locate Endpoints by Time}
\usage{
endpoints(x, on = "months", k = 1)
}
\arguments{
\item{x}{An xts object.}

\item{on}{A character string specifying the period.}

\item{k}{The number of periods each endpoint should cover.}
}
\value{
A numeric vector of beginning with 0 and ending with the number of
of observations in \code{x}.
}
\description{
Extract index locations for an xts object that correspond to the \emph{last}
observation in each period specified by \code{on} and \code{k}.
}
\details{
\code{endpoints()} returns a numeric vector that always begins with zero and ends
with the number of observations in \code{x}.

Periods are always based on the distance from the UNIX epoch (midnight
1970-01-01 UTC), \emph{not the first observation in \code{x}}. See the examples.

Valid values for the \code{on} argument are: \dQuote{us} (microseconds),
\dQuote{microseconds}, \dQuote{ms} (milliseconds), \dQuote{milliseconds},
\dQuote{secs} (seconds), \dQuote{seconds}, \dQuote{mins} (minutes),
\dQuote{minutes}, \dQuote{hours}, \dQuote{days}, \dQuote{weeks},
\dQuote{months}, \dQuote{quarters}, and \dQuote{years}.
}
\examples{

data(sample_matrix)

endpoints(sample_matrix)
endpoints(sample_matrix, "weeks")

### example of how periods are based on the UNIX epoch,
### *not* the first observation of the data series
x <- xts(1:38, yearmon(seq(2018 - 1/12, 2021, 1/12)))
# endpoints for the end of every other year
ep <- endpoints(x, "years", k = 2)
# Dec-2017 is the end of the *first* year in the data. But when you start from
# Jan-1970 and use every second year end as your endpoints, the endpoints are
# always December of every odd year.
x[ep, ]

}
\author{
Jeffrey A. Ryan
}
\keyword{utilities}
