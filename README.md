
<!-- README.md is generated from README.Rmd. Please edit that file -->

# readSX

<!-- badges: start -->

[![Lifecycle:
experimental](https://lifecycle.r-lib.org/articles/figures/lifecycle-stable.svg)](https://lifecycle.r-lib.org/articles/stages.html#stable)
[![CRAN
status](https://www.r-pkg.org/badges/version/readSX)](https://CRAN.R-project.org/package=readSX)
<!-- badges: end -->

The goal of readSX is to import survey data collected from the
proprietary service SurveyXact.

## Installation

You can install the development version of readSX like so:

``` r
library(devtools)
devtools::install_github("sda030/readSX")
```

## Example

``` r
library(readSX)
ex_survey2_xlsx <-
      read_surveyxact(filepath =
                      system.file("extdata", "ex_survey2.xlsx",
                      package = "readSX", mustWork = TRUE))
```

## Future work

-   Currently 17 total imports (including nested), all of which are
    tidyverse, or r-lib.
-   Will attempt to reduce reliance on labelled package
