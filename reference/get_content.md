# Extract content from Datamuse API call.

Extract content from Datamuse API call.

## Usage

``` r
get_content(full_path, return_type = "df", limit = 10)
```

## Arguments

- full_path:

  API path to append to Datamuse API endpoint.

- return_type:

  type to return. Options are:

  - 'df' for data.frame.

  - 'word' for a single word.

  - 'random_word' or 'random word' or 'rand' for a random word.

  - 'vector' for a vector of words.

- limit:

  max number of rows to return from the content dataframe.

## Value

content returned from API call.

## Examples

``` r
get_content("/words?rel_rhy=test", limit = 5)
#>         word score numSyllables
#> 1   manifest 56054            3
#> 2      crest 41070            1
#> 3     detest 37033            2
#> 4 distressed 29032            2
#> 5       jest 26039            1

get_content("/words?ml=test", limit = 20)
#>              word    score                             tags
#> 1         try out 40037136 syn, v, results_type:primary_rel
#> 2         examine 40036789                           syn, n
#> 3           trial 40035285                           syn, n
#> 4    experimental 40035026                           syn, n
#> 5     examination 40034614                           syn, n
#> 6           prove 40030884                           syn, n
#> 7           assay 40030642                           syn, n
#> 8             try 40028229                           syn, n
#> 9            quiz 40027442                      syn, n, ant
#> 10          essay 40014959                           syn, n
#> 11         tryout 40010527                           syn, n
#> 12      empirical 40007549                           syn, n
#> 13           exam 40003631                      syn, n, ant
#> 14            run 39999209                           syn, n
#> 15          model 39972528                           syn, n
#> 16         screen 39948440                           syn, n
#> 17          pilot 39905235                           syn, n
#> 18          check 39882132                           syn, n
#> 19    mental test 30039156                           syn, n
#> 20 mental testing 30039156                           syn, n
```
