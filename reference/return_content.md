# Helper function to shape data to return to user.

Helper function to shape data to return to user.

## Usage

``` r
return_content(api_content, return_type)
```

## Arguments

- api_content:

  content returned from the API call.

- return_type:

  type to return. Options are:

  - 'df' for data.frame.

  - 'word' for a single word.

  - 'random_word' or 'random word' or 'rand' for a random word.

  - 'vector' for a vector of words.

## Value

data as specified above.
