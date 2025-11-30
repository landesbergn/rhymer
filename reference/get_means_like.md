# Get dataframe for words with similar meaning.

Get dataframe for words with similar meaning.

## Usage

``` r
get_means_like(word = "test", return_type = "df", limit = 10)
```

## Arguments

- word:

  to get similar meaning with.

- return_type:

  type to return. Options are:

  - 'df' for data.frame.

  - 'word' for a single word.

  - 'random_word' or 'random word' or 'rand' for a random word.

  - 'vector' for a vector of words.

- limit:

  max number of words to return.

## Value

data with words of similar meaning.

## Examples

``` r
get_means_like("test")
#>            word    score                             tags
#> 1       try out 40037136 syn, v, results_type:primary_rel
#> 2       examine 40036789                           syn, n
#> 3         trial 40035285                           syn, n
#> 4  experimental 40035026                           syn, n
#> 5   examination 40034614                           syn, n
#> 6         prove 40030884                           syn, n
#> 7         assay 40030642                           syn, n
#> 8           try 40028229                           syn, n
#> 9          quiz 40027442                      syn, n, ant
#> 10        essay 40014959                           syn, n

get_means_like("test", limit = 10)
#>            word    score                             tags
#> 1       try out 40037136 syn, v, results_type:primary_rel
#> 2       examine 40036789                           syn, n
#> 3         trial 40035285                           syn, n
#> 4  experimental 40035026                           syn, n
#> 5   examination 40034614                           syn, n
#> 6         prove 40030884                           syn, n
#> 7         assay 40030642                           syn, n
#> 8           try 40028229                           syn, n
#> 9          quiz 40027442                      syn, n, ant
#> 10        essay 40014959                           syn, n
```
