## Create empty data set.
geckoDatasetCreate <- function(
  df,                        # Data frame. Only Column names are really used.
  apiKey,
  dataset="dummy.by_day",    # Name of Geckoboard dataset.
  types,                     # "date, "datetime", "number", "percentage", "string", "money".
  verbose=FALSE,
  optional=(types == "number") # Allows numbers to be NA.
) {
  initials = substr(colnames(df), 1, 1)
  if(!all(initials == tolower(initials)))
    stop("Column Names must start with lower case letter.")
  
  if(min(nchar(colnames(df))) < 2)
    stop("Column names must have length 2 or more.")
  
  ## Prepare Message Body.
  cn <- colnames(df)
  data <- list(Fields=list())
  for(i in 1:ncol(df))
    data$Fields[[cn[i]]] <- list(type=types[i], name=cn[i], optional=optional[i])
  body = jsonlite::toJSON(data, auto_unbox=TRUE)
  
  ## Create data set.
  res = httr::PUT(
    url=paste0("https://api.geckoboard.com/datasets/", dataset),
    httr::authenticate(apiKey, ""),
    encode="json",
    body=body
  )
  if(verbose)
    print(res)
  
  if(res$status_code == 201)
    cat("Dataset created.")
  else 
    cat("Dataset not created.")
}

