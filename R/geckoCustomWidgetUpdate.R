## Create empty data set.
geckoCustomWidgetUpdate <- function(
  widgetType="barchart", # Chart Type, see https://developer-custom.geckoboard.com/#custom-widget-types.
  data,                  # For "barchart" alist of:
                         # y: data.frame w/ 1 column per series. N rows.
                         # y.format: Optional. "decimal", "percent" or "currency". Default to "decimal".
                         # y.unit: Optional. For currencied "GBP", "USD" or "EUR".
                         # x: Optional. Vector of length N with bar labels. Must be of class character or Date.
                         # For "geckometer" a list of:
                         # min, max, current. One number each.
                         # format: Optional. "percent" or "currency".
                         # unit: Optional. For currencied "GBP", "USD" or "EUR".
  apiKey,
  widgetKey,             # Widget Key, see https://developer-custom.geckoboard.com/#pushing-to-your-widget.
  verbose=FALSE
) {
  ## Prepare Message Body.
  body <- list("api_key"=apiKey, "data"=list())
  if(widgetType == "barchart") {
    k = ncol(data$y)
    if(k > 3)
      stop("Only 3 series allowed so far (2018-04).")
    
    body$data$series = list()
    for(i in 1:k)
      body$data$series[[i]] = list(name=colnames(data$y)[i], data=as.vector(data$y[, i]))
    if("x" %in% names(data)) {
      if(class(data$x) == "character")
        body$data$x_axis = list(labels=data$x)
      else if(class(data$x) == "Date") {
        body$data$x_axis = list(labels=data$x)
        body$data$x_axis$type = "datetime"
      }
      else
        stop("data$x must be of class <character> or <Date>.")
    }
    if("y.format" %in% names(data))
      body$data$y_axis$format = data$y.format
    if("y.unit" %in% names(data))
      body$data$y_axis$unit = data$y.unit
    
  } else if(widgetType == "geckometer") {
    body$data = list(
      item=data$current,
      min=list(value=data$min),
      max=list(value=data$max)
    )
    if("format" %in% names(data))
      body$data$format = data$format
    if("unit" %in% names(data))
      body$data$unit = data$unit
    
  } else {
    stop("widgetType not supported.") 
  }
  
  body = jsonlite::toJSON(body, auto_unbox=TRUE)
  
  ## Create data set.
  res = httr::POST(
    url=paste0("https://push.geckoboard.com/v1/send/", widgetKey),
    encode="json", 
    body=body
  )
  
  if(verbose)
    print(res)
  
  if(res$status_code == 200)
    cat("Widget updated.")
  else 
    cat("Widget not updated.")
}

