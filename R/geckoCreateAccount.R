geckoCreateAccount <- function(
  name,         # Arbitrary name.
  key           # API key of the Geckoboard account.
  ) {
  obj = list(name=name, apiKey=key)
  class(obj) <- "geckoboardAccount"
  obj
}
