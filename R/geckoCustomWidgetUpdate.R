## Create empty data set.
geckoCustomWidgetUpdate = function(
  widgetType="barchart", # Chart Type, see https://developer-custom.geckoboard.com/#custom-widget-types.
  data,                  # For "barchart" alist of:
                         #  y: data.frame w/ 1 column per series. N rows.
                         #  y.format: Optional. "decimal", "percent" or "currency". Default to "decimal".
                         #  y.unit: Optional. For currencied "GBP", "USD" or "EUR".
                         #  x: Optional. Vector of length N with bar labels. Must be of class character or Date.
                         # For "geckometer" a list of:
                         #  min, max, current. One number each.
                         #  format: Optional. "percent" or "currency".
                         #  unit: Optional. For currencied "GBP", "USD" or "EUR".
                         # For "monitoring" a list of:
                         #  status: "up", "down" or "unreported".
                         #  downTime, responseTime: both optional; string.
  apiKey,
  widgetKey,             # Widget Key, see https://developer-custom.geckoboard.com/#pushing-to-your-widget.
  verbose=FALSE
) {
  ## Prepare Message Body.
  body = list()
  if(widgetType == "barchart") {
    k = ncol(data$y)
    if(k > 3)
      stop("Only 3 series allowed so far (2018-04).")
    
    body$series = list()
    for(i in 1:k)
      body$series[[i]] = list(name=colnames(data$y)[i], data=as.vector(data$y[, i]))
    if("x" %in% names(data)) {
      if(class(data$x) == "character")
        body$x_axis = list(labels=data$x)
      else if(class(data$x) == "Date") {
        body$x_axis = list(labels=data$x)
        body$x_axis$type = "datetime"
      }
      else
        stop("data$x must be of class <character> or <Date>.")
    }
    if("y.format" %in% names(data))
      body$y_axis$format = data$y.format
    if("y.unit" %in% names(data))
      body$y_axis$unit = data$y.unit
    
  } else if(widgetType == "geckometer") {
    body = list(
      item=data$current,
      min=list(value=data$min),
      max=list(value=data$max)
    )
    if("format" %in% names(data))
      body$format = data$format
    if("unit" %in% names(data))
      body$unit = data$unit
    
  } else if(widgetType == "monitoring") {
    body = data 
  
  } else {
    stop("widgetType not supported. Consider using <geckoPushData>.") 
  }
  
  res = geckoPushData(data, apiKey, widgetKey, verbose=verbose)
  
  if(res$status_code == 200)
    cat("Widget updated.")
  else 
    cat("Widget not updated.")
}

