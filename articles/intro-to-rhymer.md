# Intro to rhymer

Welcome to `rhymer`, an R package for getting rhyming and other related
words through the Datamuse API. I highly recommend reading through the
[Datamuse API website](https://www.datamuse.com/api/) before getting
started.

## Main functions

`rhymer` has 4 main functions that allow you to get data on related
words through the Datamuse API.

They are:

- [`get_rhyme()`](https://landesbergn.github.io/rhymer/reference/get_rhyme.md) -
  a function to get rhyming words.  
- [`get_means_like()`](https://landesbergn.github.io/rhymer/reference/get_means_like.md) -
  a function to get words with similar meaning.  
- [`get_sounds_like()`](https://landesbergn.github.io/rhymer/reference/get_sounds_like.md) -
  a function to get words that sound similar.  
- [`get_spelled_like()`](https://landesbergn.github.io/rhymer/reference/get_spelled_like.md) -
  a function to get words that are spelled similarly.

There is also a more flexible function
[`get_other_related()`](https://landesbergn.github.io/rhymer/reference/get_other_related.md)
that allows you to use the API to get data on other related words using
a series of ‘codes’ described on the [Datamuse API
website](https://www.datamuse.com/api/).

Each function is default limited to return a maximum of 10 results, but
can return more. Functions also default to return a dataframe with a row
for each word, and an associated score. Different functions will return
slightly different additional columns if returning a dataframe.

``` r
library(rhymer)
```

### `get_rhyme()`

This function was the initial inspiration behind this package. It makes
the work of finding rhyming words easy. In the background, it is
referencing the [CMU Pronouncing
Dictionary](https://en.wikipedia.org/wiki/CMU_Pronouncing_Dictionary).
At it’s simplest, you can pass in a word and
[`get_rhyme()`](https://landesbergn.github.io/rhymer/reference/get_rhyme.md)
will return a dataframe of rhyming words. For example:

``` r
get_rhyme("test")
```

    ##          word score numSyllables
    ## 1    manifest 56054            3
    ## 2       crest 41070            1
    ## 3      detest 37033            2
    ## 4  distressed 29032            2
    ## 5        jest 26039            1
    ## 6   impressed 23028            2
    ## 7  acquiesced 21013            3
    ## 8        rest 20062            1
    ## 9       chest 20057            1
    ## 10     arrest 20052            2

The function has some additional arguments that you can use to specify
the rhyme.

You can specify the number of syllables returned using `num_syl`:

``` r
get_rhyme("test", num_syl = 2)
```

    ##          word score numSyllables
    ## 3      detest 37033            2
    ## 4  distressed 29032            2
    ## 6   impressed 23028            2
    ## 10     arrest 20052            2
    ## 11    bequest 19048            2
    ## 12    request 19041            2
    ## 13    abreast 19039            2
    ## 17     attest 17049            2
    ## 18    contest 17042            2
    ## 20    protest 16048            2

You can specify the type of data returned using `return_type`:

``` r
# "df" returns a single dataframe (which is the default behavior).
get_rhyme("test", return_type = "df")
```

    ##          word score numSyllables
    ## 1    manifest 56054            3
    ## 2       crest 41070            1
    ## 3      detest 37033            2
    ## 4  distressed 29032            2
    ## 5        jest 26039            1
    ## 6   impressed 23028            2
    ## 7  acquiesced 21013            3
    ## 8        rest 20062            1
    ## 9       chest 20057            1
    ## 10     arrest 20052            2

``` r
# "word" returns the type rhyme in the form of a single word vector.
get_rhyme("test", return_type = "word")
```

    ## [1] "manifest"

``` r
# "random_word" or "rand" returns a single, random word.
get_rhyme("test", return_type = "random_word")
```

    ## [1] "acquiesced"

``` r
# "vector" returns a vector of words.
get_rhyme("test", return_type = "vector")
```

    ##  [1] "manifest"   "crest"      "detest"     "distressed" "jest"      
    ##  [6] "impressed"  "acquiesced" "rest"       "chest"      "arrest"

You can also specify the number of words returned (defaults to 10 so as
to not kill the API) using `limit`:

``` r
get_rhyme("test", limit = 5)
```

    ##         word score numSyllables
    ## 1   manifest 56054            3
    ## 2      crest 41070            1
    ## 3     detest 37033            2
    ## 4 distressed 29032            2
    ## 5       jest 26039            1

### `get_means_like()`

In the background, this function works by referencing
[WordNet](https://wordnet.princeton.edu) and other online dictionaries.
It has the same arguments as
[`get_rhyme()`](https://landesbergn.github.io/rhymer/reference/get_rhyme.md)
for limiting the number of results (`limit`) and for what data structure
to return (`return_type`). It also returns additional information about
the part of speech returned.

``` r
get_means_like("test")
```

    ##            word    score                             tags
    ## 1       try out 40037136 syn, v, results_type:primary_rel
    ## 2       examine 40036789                           syn, n
    ## 3         trial 40035285                           syn, n
    ## 4  experimental 40035026                           syn, n
    ## 5   examination 40034614                           syn, n
    ## 6         prove 40030884                           syn, n
    ## 7         assay 40030642                           syn, n
    ## 8           try 40028229                           syn, n
    ## 9          quiz 40027442                      syn, n, ant
    ## 10        essay 40014959                           syn, n

### `get_sounds_like()`

In the background, this function works by referencing referencing the
[CMU Pronouncing
Dictionary](https://en.wikipedia.org/wiki/CMU_Pronouncing_Dictionary).
It has the same arguments as
[`get_rhyme()`](https://landesbergn.github.io/rhymer/reference/get_rhyme.md)
for limiting the number of results (`limit`), for what data structure to
return (`return_type`), and for the number of syllables to limit to
(`num_syl`).

``` r
get_sounds_like("test", num_syl = 2)
```

    ##      word score numSyllables
    ## 19 attest    90            2
    ## 20  testy    90            2
    ## 21 tester    90            2
    ## 22  tessa    90            2
    ## 25 testes    90            2
    ## 29  testa    90            2
    ## 33 tessie    90            2
    ## 34 testee    90            2
    ## 36  testi    90            2
    ## 38  testo    90            2

### `get_spelled_like()`

This function has the same arguments as
[`get_rhyme()`](https://landesbergn.github.io/rhymer/reference/get_rhyme.md)
for limiting the number of results (`limit`) and for what data structure
to return (`return_type`).

``` r
get_spelled_like("test")
```

    ##   word score
    ## 1 test 13073
