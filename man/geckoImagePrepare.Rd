\name{geckoImagePrepare}
\alias{geckoImagePrepare}

\title{Helper function to get an image prepared for Geckoboard Image}

\description{Helper function to get an image prepared for Geckoboard Image. Call this before creating a plot using e.g. \code{plot} or \code{ggplot}.}

\usage{geckoImagePrepare(filePath, size = "1x1", retina = FALSE, device = jpeg,
                 adjustTitleRow = FALSE, quality = 100, ...)}

\arguments{
  \item{filePath}{Full file path.}
  \item{size}{Size in Geckoboard grid lines.}
  \item{retina}{TRUE if resolution should be twice as standard.}
  \item{device}{Graphics Device used. Available: PNG or JPEG.}
  \item{adjustTitleRow}{Should image be smaller for a title row?}
  \item{quality}{For JPEG.}
  \item{...}{Additional parameters to the device function.}
}
  
\value{Nothing is returned.}

\author{Meinhard Ploner}

\keyword{geckoboard}
\keyword{image}
