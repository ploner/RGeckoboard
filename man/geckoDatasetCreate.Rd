\name{geckoDatasetCreate}
\alias{geckoDatasetCreate}

\title{Create a Dataset to be used on Geckoboard}

\description{Create a Dataset to be used on Geckoboard.}

\usage{geckoDatasetCreate(df, apiKey, dataset="dummy.by_day", types)}

\arguments{
  \item{df}{Data frame. Only column names are used during dataset creation.}
  \item{apiKey}{API key.}
  \item{dataset}{Name the Geckoboard dataset should get, e.g. name.by_day.}
  \item{types}{Either "date", "datetime", "number", "percentage" (between 0 and 1), "string" or "money".}
}
  
\value{Nothing is returned.}

\author{Meinhard Ploner}

\keyword{geckoboard}
\keyword{dataset}
