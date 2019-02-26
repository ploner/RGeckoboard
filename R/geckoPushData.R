geckoPushData = function(
  data = list(
    "status"="Up",
    "downTime"="9 days ago",
    "responseTime"="593 ms"
  ),
  apiKey,
  widgetKey,
  verbose=FALSE
) {
  body = list("api_key"=apiKey, "data"=data)
  body = jsonlite::toJSON(body, auto_unbox=TRUE)
  
  res = httr::POST(
    url=paste0("https://push.geckoboard.com/v1/send/", widgetKey),
    encode="json", 
    body=body
  )
  
  if(verbose)
    print(res)
  
  invisible(res)
}
