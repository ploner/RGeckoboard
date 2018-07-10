\name{geckoDatasetReplace}
\alias{geckoDatasetReplace}

\title{Replace the data of a Geckoboard Dataset}

\description{Replace all the data of a Dataset to be used on Geckoboard.}

\usage{geckoDatasetReplace(df, apiKey, dataset="dummy.by_day", types, verbose=FALSE)}

\arguments{
  \item{df}{Data frame.}
  \item{apiKey}{API key.}
  \item{dataset}{Name of an existing Geckoboard dataset.}
  \item{types}{Either "date", "datetime", "number", "percentage" (between 0 and 1), "string" or "money".}
  \item{verbose}{If \code{TRUE}, API repsonse if printed.}
}
  
\value{Nothing is returned.}

\author{Meinhard Ploner}

\keyword{geckoboard}
\keyword{dataset}
