# Get data for words that are spelled similarly.

Get data for words that are spelled similarly.

## Usage

``` r
get_spelled_like(word = "test", return_type = "df", limit = 10)
```

## Arguments

- word:

  to get similarly spelled words with.

- return_type:

  type to return. Options are:

  - 'df' for data.frame.

  - 'word' for a single word.

  - 'random_word' or 'random word' or 'rand' for a random word.

  - 'vector' for a vector of words.

- limit:

  max number of words to return.

## Value

data with words that are spelled similarly.

## Examples

``` r
get_spelled_like("test")
#>   word score
#> 1 test 13073

get_spelled_like("test", limit = 10)
#>   word score
#> 1 test 13073
```
