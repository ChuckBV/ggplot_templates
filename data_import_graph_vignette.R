#===========================================================================#
# Vignette, importing and graphing data
#
# saved as "github.com/ChuckBV/data_import_graph_vignette.R"
#
# Generally scripts in this repository are intended as short minimalist
# templates. This is intended as a longer example of process when importing,
# summarizing, and graphing data
#
#===========================================================================#

library(tidyverse) # many useful packages
library(DataExplorer)
library(lubridate) # contains data data
library(DescTools) # for Desc() function
library(FSA) # for se() function

# from https://stackoverflow.com/questions/39065921/what-do-raw-githubusercontent-com-urls-represent

# The raw.githubusercontent.com domain is used to serve unprocessed versions of 
# files stored in GitHub repositories. If you browse to a file on GitHub and 
# then click the Raw link, that's where you'll go.

# Note that "ms-now-ppo-kairomone-2017-2yr" is a public repository
data <- readr::read_csv("https://raw.githubusercontent.com/ChuckBV/ms-now-ppo-kairomone-2017-2yr/master/data/Y17a_counts.csv")


# Examine the data

# See https://www.r-bloggers.com/2018/11/explore-your-dataset-in-r/ This
# blog provides various ways of getting an overview of a data set, including
#  - base::dim()  -- returns number of rows and columns (this info is aalso in 
#      the Global Environment panel of RStudio)
#  - base::names() -- Returns variable names
#  - base::summary() -- identifies character variables, and provides
#      min, quartiles, max, and number of NAs for numerical variables
#  - base::glimplse() -- shows columns as rows, provides data type, and 
#      shows a initial part of the constituent vectors (columns)
#  - DataExplorer::create_report() -- does not work for me in Jan 2022

# We can quickly see that there are 2240 rows of 13 variables. They are:
names(data)
# [1] "TrtID"     "TrtCode"   "Treatment" "Site"      "Crop"      "MD"        "Rep"       "Trap"     
# [9] "SiteID"    "Week"      "Count"     "Date"      "Days"     

data
# A tibble: 2,240 x 13
#   TrtID TrtCode Treatment  Site      Crop  MD      Rep  Trap SiteID  Week Count Date        Days
#   <dbl> <chr>   <chr>      <chr>     <chr> <chr> <dbl> <dbl>  <dbl> <dbl> <dbl> <chr>      <dbl>
# 1     1 A       NowBiolure Kettleman Alm   No        1   314      3    24     8 06/14/2017     7
# 2     1 A       NowBiolure Kettleman Alm   No        2   324      3    24     6 06/14/2017     7
# 3     1 A       NowBiolure Kettleman Alm   No        3   332      3    24     6 06/14/2017     7
# 4     1 A       NowBiolure Kettleman Alm   No        4   343      3    24     8 06/14/2017     7

    # Since this is imported as a tibble, we can learn a lot by just invoking
    # the name of the data frame. Here we see that Date was imported as a 
    # character variable, and that it is in the "mm/dd/yy" format. This tells us
    # that we will need the mdy() from lubriadate to get R to convert this to
    # the correct data type

data$Date <- as.Date(mdy(data$Date))

# Week appears to be a 1-52 orindal count of calendar weeks. The U.S. CDC 
# has a standardized form of identifying week of the year. lubridate::epiweek()
# invokes that standarized form, and I prefer to use that function to be 
# sure that is what we have

data$Week <- epiweek(data$Date)

    # This changes can be confirmed by entering "data" again

# The question of how TrtID, TrtCode, Treatment, Site, Crop, Rep, Trap, and
# SiteID are related sugggests itself. This data set came from the repository 
# "ms-now-ppo-kairomone-2017-2yr", and something in the ./doc folder within
# that repository should describe the relationship. The relationship can 
# also be deduced with tools from base R, dplyr, and other parts of tidyverse

# Are TrtID and TrtCode 2 ways of expressing the same thing?
sum(data$TrtCode == LETTERS[data$TrtID])
# [1] 0
sum(data$TrtCode == LETTERS[data$TrtID])
# [1] 2240

   # LETTERS is a vector of capital A-Z. So this says that the answer to the
   # question above is "Yes"

