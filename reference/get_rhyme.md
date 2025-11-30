# Get data for rhyming words.

Get data for rhyming words.

## Usage

``` r
get_rhyme(word, return_type = "df", limit = 10, num_syl = NULL)
```

## Arguments

- word:

  to rhyme with.

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

data with rhyming words.

## Examples

``` r
get_rhyme("test")
#>          word score numSyllables
#> 1    manifest 56054            3
#> 2       crest 41070            1
#> 3      detest 37033            2
#> 4  distressed 29032            2
#> 5        jest 26039            1
#> 6   impressed 23028            2
#> 7  acquiesced 21013            3
#> 8        rest 20062            1
#> 9       chest 20057            1
#> 10     arrest 20052            2

get_rhyme("test", limit = 10)
#>          word score numSyllables
#> 1    manifest 56054            3
#> 2       crest 41070            1
#> 3      detest 37033            2
#> 4  distressed 29032            2
#> 5        jest 26039            1
#> 6   impressed 23028            2
#> 7  acquiesced 21013            3
#> 8        rest 20062            1
#> 9       chest 20057            1
#> 10     arrest 20052            2
```
