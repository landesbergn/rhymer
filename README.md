
<!-- README.md is generated from README.Rmd. Please edit that file -->
rhymer
======

The goal of rhymer is to get rhyming and other related words through the [Datamuse API](http://www.datamuse.com/api/).

Installation
------------

You can install rhymer from github with:

``` r
# install.packages("devtools")
devtools::install_github("landesbergn/rhymer")
```

Example
-------

They say nothing rhymes with *orange*...

``` r
library(rhymer)
#> Loading required package: jsonlite
#> Loading required package: httr

get_rhyme("orange")
#>         word score numSyllables
#> 1 door hinge    74            2
```
