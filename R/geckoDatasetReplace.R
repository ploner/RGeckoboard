## Replace data of data set.
geckoDatasetReplace <- function(
  df,                        # Data frame.
  apiKey,
  dataset="dummy.by_day",    # Name of Geckoboard dataset.
  types,                     # "date, "datetime", "number", "percentage", "string", "money".
  verbose=FALSE
) {
  if(ncol(df) > 10)
    stop("Dataset should not have more than 10 columns.")
  
  ## Prepare Message Body.
  rownames(df) <- NULL
  for(i in seq(along=df)) {
    if(types[i] == "datetime")
      df[, i] <- format(as.Date(df[, i]), "%Y-%m-%dT%H:%M:%SZ")
    else if(types[i] == "date")
      df[, i] <- format(as.Date(df[, i]), "%Y-%m-%d")
    else if(types[i] == "percentage") {
      if(any(df[, i] > 1, na.rm=T) || any(df[, i] < 0, na.rm=T)) 
        stop("Percentages must be within [0, 1].")
    }
    else if(types[i] == "number") {
      df[, i] <- ifelse(is.finite(df[, i]), df[, i], NA) # NA converts to 'null'.
    }
  }
  body <- jsonlite::toJSON(df, auto_unbox=TRUE)
  gsub("NaN", '"null"', body)
  body = paste('{ "data" : ', body, ' }')
  
  ## Replace data set.
  require(httr)
  res = PUT(
    url=paste0("https://api.geckoboard.com/datasets/", dataset, "/data"),
    authenticate(apiKey, ""),
    encode="json",
    body=body
  )
  if(verbose)
    print(res)
  
  if(res$status_code == 200)
    cat("Dataset updated.")
  
  else 
    cat("Dataset not updated.")
}
