\name{geckoDatasetCreate}
\alias{geckoDatasetCreate}

\title{Create a Dataset to be used on Geckoboard}

\description{Create a Dataset to be used on Geckoboard.}

\usage{geckoDatasetCreate(df, apiKey, dataset="dummy.by_day", types,
  verbose = FALSE, optional=(types == "number"))
}

\arguments{
  \item{df}{Data frame. Only column names are used during dataset creation.}
  \item{apiKey}{API key.}
  \item{dataset}{Name the Geckoboard dataset should get, e.g. name.by_day.}
  \item{types}{Either "date", "datetime", "number", "percentage" (between 0 and 1), "string" or "money".}
  \item{verbose}{If \code{TRUE}, API repsonse if printed.}
  \item{optional}{Usually numeric fields are optional. Can be modified.}
}
  
\value{Nothing is returned.}

\examples{\dontrun{
data = data.frame(
  date=c("2018-03-01", "2018-03-02", "2018-03-03", "2018-03-04"), 
	KPI1=c(77, 78.1, 79, NA), 
	KPI2=c(78, 90, 91.2, 92)
)
datasetName = "kpi.by_day"
types = c("date", "number", "number")
geckoDatasetCreate(data, account$apiKey, datasetName, types)
geckoDatasetReplace(data, account$apiKey, datasetName, types)
}}

\author{Meinhard Ploner}

\keyword{geckoboard}
\keyword{dataset}
