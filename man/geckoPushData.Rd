\name{geckoPushData}
\alias{geckoPushData}

\title{Push data to the Geckoboard PUSH API}

\description{Usually used by \code{geckoCustomWidgetUpdate}. Updates data by Push methodology.}

\usage{geckoPushData(data, apiKey, widgetKey, verbose=FALSE)}

\arguments{
  \item{data}{The payload to be sent as a list. Will be converted to JSON by the function.}
  \item{apiKey}{API key.}
  \item{widgetKey}{Widget Key, see https://developer-custom.geckoboard.com/#pushing-to-your-widget.}
  \item{verbose}{If \code{TRUE}, API repsonse if printed.}
}
  
\value{Returns the response of the request. Invisible.}

\author{Meinhard Ploner}

\keyword{geckoboard}

