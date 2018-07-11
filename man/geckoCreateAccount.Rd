\name{geckoCreateAccount}
\alias{geckoCreateAccount}

\title{Create Geckoboard Account}

\description{Create object holding meta data of a Geckoboard project.}

\usage{geckoCreateAccount(name, key)}

\arguments{
  \item{name}{Can be arbitrary.}
  \item{key}{API key of Geckoboard project.}
}

\value{An object holding all the values specified as parameters.}

\examples{\dontrun{
## Fill in here the API key found on 
## https://www.geckoboard.com -> 'top-right' -> Account -> API Key. 
account = geckoboardCreateAccount("ProjectName", key="553c55...")
class(account)
}}

\author{Meinhard Ploner}

\seealso{
\code{\link{geckoDatasetCreate}}
}

\keyword{geckoboard}
\keyword{account}
