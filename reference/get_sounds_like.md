# Get data for words that sound similar.

Get data for words that sound similar.

## Usage

``` r
get_sounds_like(word = "test", return_type = "df", limit = 10, num_syl = NULL)
```

## Arguments

- word:

  to get similar sounding words with.

- return_type:

  type to return. Options are:

  - 'df' for data.frame.

  - 'word' for a single word.

  - 'random_word' or 'random word' or 'rand' for a random word.

  - 'vector' for a vector of words.

- limit:

  max number of words to return.

- num_syl:

  number of syllables in rhymes to return.

## Value

data containing word(s) that sound similar.

## Examples

``` r
get_sounds_like("test")
#>      word score numSyllables
#> 1    test   100            1
#> 2   teste   100            1
#> 3    tist    97            1
#> 4    tust    97            1
#> 5   taste    95            1
#> 6   toast    95            1
#> 7  tossed    95            1
#> 8    tast    95            1
#> 9   teest    95            1
#> 10   tesd    95            1

get_sounds_like("test", limit = 10)
#>      word score numSyllables
#> 1    test   100            1
#> 2   teste   100            1
#> 3    tist    97            1
#> 4    tust    97            1
#> 5   taste    95            1
#> 6   toast    95            1
#> 7  tossed    95            1
#> 8    tast    95            1
#> 9   teest    95            1
#> 10   tesd    95            1
```
