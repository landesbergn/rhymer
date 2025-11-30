# Get data for words that are related according to a supplied code.

Get data for words that are related according to a supplied code.

## Usage

``` r
get_other_related(word = "test", code = "jja", return_type = "df", limit = 10)
```

## Arguments

- word:

  to get similarly spelled words with.

- code:

  related word code from http://www.datamuse.com/api/.

- return_type:

  type to return. Options are:

  - 'df' for data.frame.

  - 'word' for a single word.

  - 'random_word' or 'random word' or 'rand' for a random word.

  - 'vector' for a vector of words.

- limit:

  max number of words to return.

## Value

data with words that are related.

## Examples

``` r
get_other_related("test", code = "jja", limit = 3)
#>      word score
#> 1 results  1001
#> 2    tube  1000
#> 3  scores   999

get_other_related("test", code = "cns", limit = 10)
#>     word score numSyllables
#> 1  toast  8049            1
#> 2  taste  7063            1
#> 3 tossed  6019            1
#> 4  teste    19            1
#> 5  teast    NA            1
#> 6  toste    NA            1
```
