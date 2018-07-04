## Remove data set.
geckoDatasetRemove <- function(
  apiKey,
  dataset="dummy.by_day",    # Name of Geckoboard dataset.
  verbose=FALSE
) {
  ## Remove data set.
  require(httr)
  res = DELETE(
    url=paste0("https://api.geckoboard.com/datasets/", dataset),
    authenticate(apiKey, ""),
    encode="json"
  )
  if(verbose)
    print(res)
  
  if(res$status_code == 404)
    cat("Dataset does not exist. Could not remove dataset.")
  
  else 
    cat("Dataset removed.")
}
