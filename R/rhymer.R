library(httr)
library(jsonlite)

#' Call datamuse API and return data frame.
#'
#' @param path path to append to datamuse API endpoint.
#' @param limit number of results to limit the API response to.
#' @return dataframe with data returned from API call.
#' @export
#' @examples
#' datamuse_api("/words?rel_rhy=test")
#' datamuse_api("/words?ml=test")
datamuse_api <- function(path, limit = 10) {

  ua <- user_agent("http://github.com/nlandesberg/rhymer")

  if (limit > 0) {
    limit_string <- paste0("&max=", limit)
    path <- paste0(path, limit_string)
  }

  url <- modify_url("https://api.datamuse.com", path = path)

  resp <- GET(url, ua)
  if (http_type(resp) != "application/json") {
    stop("API did not return json", call. = FALSE)
  }

  parsed <- jsonlite::fromJSON(content(resp, "text", encoding = "UTF-8"))

  if (status_code(resp) != 200) {
    stop(
      sprintf(
        "Datamuse API request failed [%s]\n%s\n<%s>",
        status_code(resp),
        parsed$message,
        parsed$documentation_url
      ),
      call. = FALSE
    )
  }

  structure(
    list(
      content = parsed,
      path = path,
      response = resp
    ),
    class = "datamuse_api"
  )
}

#' Print method for data returned by API.
#'
#' @param x datamuse API return object.
#' @param ... the other stuff.
#' @export
#' @examples
#' print(datamuse_api("/words?rel_rhy=test"))
#' print(datamuse_api("/words?ml=test"))
print.datamuse_api <- function(x, ...) {
  cat("<datamuse ", x$path, ">\n", sep = "")
  str(x$content)
  invisible(x)
}

#' Extract content dataframe from datamuse API call.
#'
#' @param full_path API path to append to datamuse API endpoint.
#' @param limit max number of rows to return from the content dataframe.
#' @return dataframe with content returned from API call.
#' @export
#' @examples
#' get_content("/words?rel_rhy=test", limit = 5)
#' get_content("/words?ml=test", limit = 20)
get_content <- function(full_path, limit = 10) {
  x <- datamuse_api(full_path, limit)
  if (length(x$content) == 0) {
    warning("No results found", call. = FALSE, immediate. = TRUE)
  }
  return(x$content)
}


#' Get dataframe of rhyming words.
#'
#' @param word to rhyme with.
#' @param limit max number of words to return\.
#' @return dataframe with rhyming words.
#' @export
#' @examples
#' get_rhyme("test")
#' get_rhyme("test", limit = 10)
get_rhyme <- function(word, limit = 10) {
  get_content(paste0("/words?rel_rhy=", word), limit)
}

#' Get dataframe of words with similar meaning.
#'
#' @param word to get similar meaning with.
#' @param limit max number of words to return.
#' @return dataframe with words of similar meaning.
#' @export
#' @examples
#' get_means_like("test")
#' get_means_like("test", limit = 10)
get_means_like <- function(word = "test", limit = 10) {
  get_content(paste0("/words?ml=", word), limit)
}

#' Get dataframe of words that sound similar.
#'
#' @param word to get similar sounding words with.
#' @param limit max number of words to return.
#' @return dataframe with words that sound similar.
#' @export
#' @examples
#' get_sounds_like("test")
#' get_sounds_like("test", limit = 10)
get_sounds_like <- function(word = "test", limit = 10) {
  get_content(paste0("/words?sl=", word), limit)
}

#' Get dataframe of words that are spelled similarly.
#'
#' @param word to get similarly spelled words with.
#' @param limit max number of words to return.
#' @return dataframe with words that are spelled similarly.
#' @export
#' @examples
#' get_spelled_like("test")
#' get_spelled_like("test", limit = 10)
get_spelled_like <- function(word = "test", limit = 10) {
  get_content(paste0("/words?sp=", word), limit)
}

#' Get dataframe of words that are related according to a supplied code.
#'
#' @param word to get similarly spelled words with.
#' @param code related word code from http://www.datamuse.com/api/.
#' @param limit max number of words to return.
#' @return dataframe with words that are related.
#' @export
#' @examples
#' get_other_related("test", code = "jja", limit = 3)
#' get_other_related("test", code = "cns", limit = 10)
get_other_related <- function(word = "test", code = "jja", limit = 10) {
  if (code %in% c(
      "jja",	# Popular nouns modified by the given adjective, per Google Books Ngrams	gradual → increase
      "jjb",	# Popular adjectives used to modify the given noun, per Google Books Ngrams	beach → sandy
      "syn",	# Synonyms (words contained within the same WordNet synset)	ocean → sea
      "trg",	# "Triggers" (words that are statistically associated with the query word in the same piece of text.)	cow → milking
      "ant",	# Antonyms (per WordNet)	late → early
      "spc",	# "Kind of" (direct hypernyms, per WordNet)	gondola → boat
      "gen",	# "More general than" (direct hyponyms, per WordNet)	boat → gondola
      "com",	# "Comprises" (direct holonyms, per WordNet)	car → accelerator
      "par",	# "Part of" (direct meronyms, per WordNet)	trunk → tree
      "bga",	# Frequent followers (w′ such that P(w′|w) ≥ 0.001, per Google Books Ngrams)	wreak → havoc
      "bgb",	# Frequent predecessors (w′ such that P(w|w′) ≥ 0.001, per Google Books Ngrams)	havoc → wreak
      "rhy",	# Rhymes ("perfect" rhymes, per RhymeZone)	spade → aid
      "nry",	# Approximate rhymes (per RhymeZone)	forest → chorus
      "hom",	# Homophones (sound-alike words)	course → coarse
      "cns"   # Consonant match	sample → simple
    )
  ) {
    get_content(paste0("/words?rel_", code, "=", word), limit)
  } else {
    warning(paste0('"', code, '" is not a valid code. Please refer to the list of valid codes at http://www.datamuse.com/api/'),
            immediate. = TRUE)
  }
}


