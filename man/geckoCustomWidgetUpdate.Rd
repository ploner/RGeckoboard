\name{geckoCustomWidgetUpdate}
\alias{geckoCustomWidgetUpdate}

\title{Update or Create a Custom Widget}

\description{Update the data of a Custom Widget by Push methodology. If not existing, create a new one. If x axis values are of class \code{Date}, x axis format is auto-adjusted therefore.}

\usage{geckoCustomWidgetUpdate(widgetType="barchart", data, apiKey, widgetKey, 
verbose=FALSE)}

\arguments{
  \item{widgetType}{Chart Type, see https://developer-custom.geckoboard.com/#custom-widget-types.}
  \item{data}{For "barchart" a list with the following elements (mostly optional): 
    \describe{
     \item{y}{data.frame w/ 1 column per series. N rows.}
     \item{y.format}{Optional. "decimal", "percent" or "currency". Defaults to "decimal".}
     \item{y.unit}{Optional. For currencied "GBP", "USD" or "EUR".}
     \item{x}{Optional. Vector of length N with bar labels.}
   }
   For "geckometer" a list with the following elements:
   \describe{
     \item{current}{Current value. Numeric.}
     \item{min}{Min (left) value. Numeric.}
     \item{max}{Max (right) value. Numeric.}
     \item{format}{Optional. "percent" or "currency". Defaults is "decimal".}
     \item{unit}{Optional. For currencied "GBP", "USD" or "EUR".}
    }
  }
  \item{apiKey}{API key.}
  \item{widgetKey}{Widget Key, see https://developer-custom.geckoboard.com/#pushing-to-your-widget.}
  \item{verbose}{If \code{TRUE}, API repsonse if printed.}
}
  
\value{Nothing is returned.}

\author{Meinhard Ploner}

\keyword{geckoboard}
\keyword{customwidget}
\keyword{widget}
