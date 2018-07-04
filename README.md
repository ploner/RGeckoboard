## RGeckoboard - Geckoboard API client for R

The package RGeckoboard makes it easy to feed Geckoboard Dashboards with data and images from R.
There are three main functionalities:

- access to the Dataset API (create, delete, update a dataset)
- create an image optimized for Geckoboard usage
- push R data to the Custom Widget API (for now Barchart only)

An image created with this package must be uploaded to an URL accessible from Geckoboard. This could be a location
on a cloud service (e.g. Dropbox, Google Drive) or a custom host. For more information see 
https://support.geckoboard.com/hc/en-us/articles/203676478#using_the_image_widget. 

### Installation

``` r
require(devtools)
devtools::install_bitbucket("ploner/RGeckoboard")
require(RGeckoboard)
```

### Dependencies

The package depends on
- jsonlite
- httr


### Examples

#### Set-up account in R

In order to use the various methods of this package, we need to save the account data of 
the Geckoboard Project into an R object of class `geckoboardAccount`. The next examples all make use of this account object. 

``` r
## Fill in here the API key found on 
## www.geckoboard.com -> 'top-right' -> Account -> API Key. 
> account = geckoboardCreateAccount("ProjectName", key="553c55...")
> class(account)
[1] "geckoboardAccount"
```


#### Upload Time Series Data

This sample code defines an R data frame with a date column and 2 custom numeric columns. To create the
data set on Geckoboard a custom name must be added plus the types of the columns. More information on the
allowed types can be found on https://developer.geckoboard.com/api-reference/curl/.

Keep in mind that `geckoDatasetCreate` only creates an empty dataset which means it only uses the column 
names of the parameter `df` but not the rows. Data is updated in the next step, using the method `geckoDatasetReplace`. 

``` r 
> data = data.frame(
    date=c("2018-03-01", "2018-03-02", "2018-03-03", "2018-03-04"), 
	KPI1=c(77, 78.1, 79, NA), 
	KPI2=c(78, 90, 91.2, 92)
)
> datasetName = "kpi.by_day"
> types = c("date", "number", "number")
> geckoDatasetCreate(data, account$apiKey, datasetName, types)
> geckoDatasetReplace(data, account$apiKey, datasetName, types)
```

Numeric columns are marked by default as `optional`. This allows to submit `NA` values, too. If a field is
optional or not can be changed using the parameter `optional` in the `geckoDatasetCreate` call.

To remove an existing dataset simply call:

``` r 
> geckoDatasetRemove(account$apiKey, datasetName)
```

#### Upload an Image to Geckoboard

The function `geckoImagePrepare` makes it easy to specify the right resolution of the rendered picture: 

``` r 
> geckoImagePrepare("folder/filename.jpg", size = "2x2", retina=TRUE, adjustTitleRow=FALSE)
> plot(100+cumsum(rnorm(50)), type="l", col="red", lwd=3, ylab="Stock Price")
> geckoImageSave()
```

#### Create a Bar Chart using the CustomWidget API

Using `geckoCustomWidgetUpdate` data from a `data.frame` is easily pushed to Geckoboard and visualized 
by a Bar Chart. First create a new CustomWidget in Geckoboard, then copy the `widget key` to paste it into R. 

``` r 
## Fill in here the widget API key found when creating a new CustomWidget on www.geckoboard.com.
> widgetKey = "..."
> df = data.frame(date=as.Date("2018-01-01", "2018-02-01"), val1=1:2, val2=rnorm(2))
> geckoCustomWidgetUpdate(
  data=list(
    y=df[, c("val1", "val2")], 
    x=df$date
  ), 
  apiKey=account$apiKey, 
  widgetKey=widgetKey
)
```


