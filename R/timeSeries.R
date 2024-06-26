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


# functions to handle timeSeries <--> xts conversions

`re.timeSeries` <-
function(x,...) {
  if(!requireNamespace('timeSeries', quietly=TRUE)) {
    timeSeries <- function(...) message("package 'timeSeries' is required")
  } else {
    timeSeries <- timeSeries::timeSeries
  }

  # strip all non-'core' attributes so they're not attached to the Data slot
  x.attr <- attributes(x)
  xx <- structure(x,dimnames=x.attr$dimnames,index=x.attr$index)
  original.attr <- attributes(x)[!names(attributes(x)) %in% 
                                 c("dim","dimnames","index","class")]
  for(i in names(original.attr)) {
    attr(xx,i) <- NULL
  }

  timeSeries(coredata(xx),charvec=as.POSIXct(format(index(x)),tz="GMT"),format=x.attr$format,
             zone=x.attr$FinCenter,FinCenter=x.attr$FinCenter,
             recordIDs=x.attr$recordIDs,title=x.attr$title,
             documentation=x.attr$documentation,...)
}

#' @rdname as.xts
`as.xts.timeSeries` <-
function(x,dateFormat="POSIXct",FinCenter,recordIDs,title,documentation,..., .RECLASS=FALSE) {

  if(missing(FinCenter))
    FinCenter <- x@FinCenter
  if(missing(recordIDs))
    recordIDs <- x@recordIDs
  if(missing(title)) 
    title <- x@title
  if(missing(documentation)) 
    documentation <- x@documentation

  indexBy <- structure(x@positions, class=c("POSIXct","POSIXt"), tzone=FinCenter)
  order.by <- do.call(paste('as',dateFormat,sep='.'),list(as.character(indexBy)))


  if(.RECLASS) {
  xts(as.matrix(x@.Data),  
      order.by=order.by,
      format=x@format,
      FinCenter=FinCenter,
      recordIDs=recordIDs,
      title=title,
      documentation=documentation,
      .CLASS='timeSeries',
      .CLASSnames=c('FinCenter','recordIDs','title','documentation','format'),
      .RECLASS=TRUE,
      ...)
  } else {
  xts(as.matrix(x@.Data),  
      order.by=order.by,
      ...)
  }
}

as.timeSeries.xts <- function(x, ...) {
  if(!requireNamespace('timeSeries', quietly=TRUE)) {
    timeSeries <- function(...) message("package 'timeSeries' is required")
  } else {
    timeSeries <- timeSeries::timeSeries
  }

  timeSeries(data=coredata(x), charvec=as.character(index(x)), ...)
}
