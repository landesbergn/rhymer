## -----------------------------------------------------------------------------
library(rhymer)

## -----------------------------------------------------------------------------
get_rhyme("test")

## -----------------------------------------------------------------------------
get_rhyme("test", num_syl = 2)

## -----------------------------------------------------------------------------
# "df" returns a single dataframe (which is the default behavior).
get_rhyme("test", return_type = "df")

# "word" returns the type rhyme in the form of a single word vector.
get_rhyme("test", return_type = "word")

# "random_word" or "rand" returns a single, random word.
get_rhyme("test", return_type = "random_word")
 
# "vector" returns a vector of words.
get_rhyme("test", return_type = "vector")

## -----------------------------------------------------------------------------
get_rhyme("test", limit = 5)

## -----------------------------------------------------------------------------
get_means_like("test")

## -----------------------------------------------------------------------------
get_sounds_like("test", num_syl = 2)

## -----------------------------------------------------------------------------
get_spelled_like("test")

