# Call Datamuse API and return data.

Call Datamuse API and return data.

## Usage

``` r
datamuse_api(path, limit = 10)
```

## Arguments

- path:

  path to append to Datamuse API endpoint.

- limit:

  number of results to limit the API response to.

## Value

data returned from API call.

## Examples

``` r
datamuse_api("/words?rel_rhy=test")
#> $content
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
#> 
#> $path
#> [1] "/words?rel_rhy=test&max=10"
#> 
#> $response
#> Response [https://api.datamuse.com/words?rel_rhy=test&max=10]
#>   Date: 2025-11-30 06:51
#>   Status: 200
#>   Content-Type: application/json
#>   Size: 498 B
#> 
#> 
#> attr(,"class")
#> [1] "datamuse_api"

datamuse_api("/words?ml=test")
#> $content
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
#> 
#> $path
#> [1] "/words?ml=test&max=10"
#> 
#> $response
#> Response [https://api.datamuse.com/words?ml=test&max=10]
#>   Date: 2025-11-30 06:51
#>   Status: 200
#>   Content-Type: application/json
#>   Size: 578 B
#> 
#> 
#> attr(,"class")
#> [1] "datamuse_api"
```
