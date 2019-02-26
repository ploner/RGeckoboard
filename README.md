[![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/RGeckoboard)](https://cran.r-project.org/package=RGeckoboard)

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

The package can be installed directly from github (latest version):

``` r
require(devtools)
devtools::install_bitbucket("ploner/RGeckoboard")
require(RGeckoboard)
```

or from the package repository CRAN (latest submitted version):

``` r
install.packages("RGeckoboard")
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
> account = geckoCreateAccount("ProjectName", key="553c55...")
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

The functions provided within this package make it easy to specify the right resolution of a picture to be 
rendered on a Geckoboard dashboard. To generate an image optimized for retina display and with a 
size of 2x2 simply use `geckoImagePrepare`:

``` r 
> geckoImagePrepare("folder/filename.jpg", size = "2x2", retina=TRUE, adjustTitleRow=FALSE)
> plot(100+cumsum(rnorm(50)), type="l", col="red", lwd=3, ylab="Stock Price")
> geckoImageSave()
```

The parameter `adjustTitleRow` should be used if the user adds a title row within Geckoboard, hence lowering the
actual height of the image. The persisted JPG image must be moved to a cloud storage as described in
https://support.geckoboard.com/hc/en-us/articles/203676478-Using-the-image-widget.

#### Create a Bar Chart using the CustomWidget API

Using `geckoCustomWidgetUpdate`, data from a `data.frame` can be pushed easily to Geckoboard and visualized 
by a Bar Chart. First create a new CustomWidget in Geckoboard, then copy the `widget key` to paste it into R. 

``` r 
## Fill in here the widget API key found when creating a new CustomWidget on www.geckoboard.com.
> widgetKey = "..."
> df = data.frame(date=as.Date("2018-01-01", "2018-02-01"), val1=1:2, val2=rnorm(2))
> geckoCustomWidgetUpdate(
  widgetType="barchart",
  data=list(
    y=df[, c("val1", "val2")], 
    x=df$date
  ), 
  apiKey=account$apiKey, 
  widgetKey=widgetKey
)
```

#### Create a Monitoring Widget using the CustomWidget API

Using `geckoCustomWidgetUpdate`, it is easy to create or update a Geckoboard Monitoring widget. First create a new CustomWidget of type *Monitoring* in Geckoboard, then copy the `widget key` to paste it into R. 

``` r 
## Fill in here the widget API key found when creating a new CustomWidget on www.geckoboard.com.
> widgetKey = "..."
> df = data.frame(date=as.Date("2018-01-01", "2018-02-01"), val1=1:2, val2=rnorm(2))
> geckoCustomWidgetUpdate(
  widgetType="monitoring",
  data=list(
    status="up",
    downTime="11 days ago"
  ), 
  apiKey=account$apiKey, 
  widgetKey=widgetKey
)
```

#### Push directly data to the PUSH API of Geckoboard

``` r 
> data=list(...)
> geckoPushData(data, apiKey=account$apiKey, widgetKey=widgetKey)
```



