
<!-- README.md is generated from README.Rmd. Please edit that file -->
rhymer
======

The goal of rhymer is to get rhyming and other related words through the [Datamuse API](http://www.datamuse.com/api/).

Installation
------------

You can install rhymer from GitHub with:

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

Main functions
--------------

`rhymer` has 4 main functions that allow you to get data on related words through the datamuse API.

They are:

-   `get_rhyme` - a function to get rhyming words
-   `get_means_like` - a function to get words with similar meaning
-   `get_sounds_like` - a function to get words that sound similar
-   `get_spelled_like` - a function to get words that are spelt similarly

There is also a more flexible function `get_other_related` that allows you to use the API to get data on other related words using a series of 'codes' described on the (datamuse API website)\[<http://www.datamuse.com/api/>\].
