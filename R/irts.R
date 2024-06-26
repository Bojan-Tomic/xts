#
#   xts: eXtensible time-series
#
#   Copyright (C) 2008  Jeffrey A. Ryan jeff.a.ryan @ gmail.com
#
#   Contributions from Joshua M. Ulrich
#
#   This program is free software: you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation, either version 2 of the License, or
#   (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program.  If not, see <http://www.gnu.org/licenses/>.


# methods for tseries::irts

`re.irts` <-
function(x,...) {
  if(!requireNamespace('tseries', quietly=TRUE)) {
    irts <- function(...) message("package 'tseries' is required for re.irts")
  } else {
    irts <- tseries::irts
  }

  tclass(x) <- "POSIXct"
  xx <- coredata(x)
#  rownames(xx) <- attr(x,'irts.rownames')
  irts(index(x),xx)
}

#' @rdname as.xts
`as.xts.irts` <-
function(x,order.by,frequency=NULL,...,.RECLASS=FALSE) {
  if(.RECLASS) {
  xx <- xts(x=x$value,
            order.by=x$time,
            frequency=frequency,
            .CLASS='irts',
#            irts.rownames=rownames(x$value),
            ...)
  } else {
  xx <- xts(x=x$value,
            order.by=x$time,
            frequency=frequency,
            ...)
  }
  xx
}
