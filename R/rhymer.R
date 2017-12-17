library(httr)
library(jsonlite)

#' Call Datamuse API and return data.
#'
#' @param path path to append to Datamuse API endpoint.
#' @param limit number of results to limit the API response to.
#' @return data returned from API call.
#' @export
#' @examples
#' datamuse_api("/words?rel_rhy=test")
#'
#' datamuse_api("/words?ml=test")
datamuse_api <- function(path, limit = 10) {

  ua <- httr::user_agent("http://github.com/nlandesberg/rhymer")

  if (limit > 0) {
    limit_string <- paste0("&max=", limit)
    path <- paste0(path, limit_string)
  }

  url <- httr::modify_url("https://api.datamuse.com", path = path)

  resp <- httr::GET(url, ua)
  if (httr::http_type(resp) != "application/json") {
    stop("API did not return json", call. = FALSE)
  }

  parsed <- jsonlite::fromJSON(httr::content(resp, "text", encoding = "UTF-8"))

  if (httr::status_code(resp) != 200) {
    stop(
      sprintf(
        "Datamuse API request failed [%s]\n%s\n<%s>",
        httr::status_code(resp),
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

#' Extract content from Datamuse API call.
#'
#' @param full_path API path to append to Datamuse API endpoint.
#' @param return_type type to return. Options are:
#'  * 'df' for data.frame.
#'  * 'word' for a single word.
#'  * 'random_word' or 'random word' or 'rand' for a random word.
#'  * 'vector' for a vector of words.
#' @param limit max number of rows to return from the content dataframe.
#' @return content returned from API call.
#' @export
#' @examples
#' get_content("/words?rel_rhy=test", limit = 5)
#'
#' get_content("/words?ml=test", limit = 20)
get_content <- function(full_path, return_type = "df", limit = 10) {

  # Modify return type to lowercase and change spaces to underscores
  return_type <- tolower(gsub(" ", "_", return_type))

  # If the just want a single word, only ping API for 1 word
  if (tolower(return_type) == "word") {
    limit <- 1
  }

  x <- datamuse_api(full_path, limit)
  if (length(x$content) == 0) {
    warning("No results found", call. = FALSE, immediate. = TRUE)
  }

  return(return_content(x$content, return_type))
}

#' Helper function to shape data to return to user.
#'
#' @param api_content content returned from the API call.
#' @param return_type type to return. Options are:
#'  * 'df' for data.frame.
#'  * 'word' for a single word.
#'  * 'random_word' or 'random word' or 'rand' for a random word.
#'  * 'vector' for a vector of words.
#' @return data as specified above.
#' @export
return_content <- function(api_content, return_type) {
  if (return_type == "df") {
    return(api_content)
  } else if (return_type == "vector") {
    return(api_content$word)
  } else if (return_type == "word") {
    return(api_content$word[1])
  } else if (return_type == "random_word" || return_type == "rand") {
    return(sample(api_content$word, 1))
  } else {
    warning(
        "Invalid return type. Valid options are: 'df' for a dataframe, 'vector'
        for a vector, and 'word' for a single word. Returning a data.frame until
        otherwise specified.",
      immediate. = TRUE)
    return(api_content)
  }
}

#' Get data for rhyming words.
#'
#' @param word to rhyme with.
#' @param return_type type to return. Options are:
#'  * 'df' for data.frame.
#'  * 'word' for a single word.
#'  * 'random_word' or 'random word' or 'rand' for a random word.
#'  * 'vector' for a vector of words.
#' @param limit max number of words to return.
#' @param num_syl number of syllables in rhymes to return.
#' @return data with rhyming words.
#' @export
#' @examples
#' get_rhyme("test")
#'
#' get_rhyme("test", limit = 10)
get_rhyme <- function(word, return_type = "df", limit = 10, num_syl = NULL) {
  if (is.null(num_syl)) {
    data_to_return <- get_content(paste0("/words?rel_rhy=", word), return_type, limit)
  } else {
    data_to_return <- get_content(paste0("/words?rel_rhy=", word), return_type = "df", 100)
    # Remove NA's
    data_to_return <- data_to_return[!is.na(data_to_return$score), ]
    # Filter to words with corret number of syllables
    data_to_return <- data_to_return[data_to_return$numSyllables == num_syl, ]
    # Return only the number of words specified by the limit
    data_to_return <- utils::head(data_to_return, limit)
    if (nrow(data_to_return) < 1) {
      msg <- paste0("No ", num_syl, " syllable rhymes for ", word, ".")
      stop(msg, call. = FALSE)
    }
    data_to_return <- return_content(data_to_return, return_type)
  }
  return(data_to_return)
}

#' Get dataframe for words with similar meaning.
#'
#' @param word to get similar meaning with.
#' @param return_type type to return. Options are:
#'  * 'df' for data.frame.
#'  * 'word' for a single word.
#'  * 'random_word' or 'random word' or 'rand' for a random word.
#'  * 'vector' for a vector of words.
#' @param limit max number of words to return.
#' @return data with words of similar meaning.
#' @export
#' @examples
#' get_means_like("test")
#'
#' get_means_like("test", limit = 10)
get_means_like <- function(word = "test", return_type = "df", limit = 10) {
  get_content(paste0("/words?ml=", word), return_type, limit)
}

#' Get data for words that sound similar.
#'
#' @param word to get similar sounding words with.
#' @param return_type type to return. Options are:
#'  * 'df' for data.frame.
#'  * 'word' for a single word.
#'  * 'random_word' or 'random word' or 'rand' for a random word.
#'  * 'vector' for a vector of words.
#' @param limit max number of words to return.
#' @param num_syl number of syllables in rhymes to return.
#' @return data containing word(s) that sound similar.
#' @export
#' @examples
#' get_sounds_like("test")
#'
#' get_sounds_like("test", limit = 10)
get_sounds_like <- function(word = "test", return_type = "df", limit = 10, num_syl = NULL) {
  if (is.null(num_syl)) {
    data_to_return <- get_content(paste0("/words?sl=", word), return_type, limit)
  } else {
    data_to_return <- get_content(paste0("/words?sl=", word), return_type = "df", 100)
    # Remove NA's
    data_to_return <- data_to_return[!is.na(data_to_return$score), ]
    # Filter to words with corret number of syllables
    data_to_return <- data_to_return[data_to_return$numSyllables == num_syl, ]
    # Return only the number of words specified by the limit
    data_to_return <- utils::head(data_to_return, limit)
    if (nrow(data_to_return) < 1) {
      msg <- paste0("No ", num_syl, " syllable rhymes for ", word, ".")
      stop(msg, call. = FALSE)
    }
    data_to_return <- return_content(data_to_return, return_type)
  }
  return(data_to_return)
}

#' Get data for words that are spelled similarly.
#'
#' @param word to get similarly spelled words with.
#' @param return_type type to return. Options are:
#'  * 'df' for data.frame.
#'  * 'word' for a single word.
#'  * 'random_word' or 'random word' or 'rand' for a random word.
#'  * 'vector' for a vector of words.
#' @param limit max number of words to return.
#' @return data with words that are spelled similarly.
#' @export
#' @examples
#' get_spelled_like("test")
#'
#' get_spelled_like("test", limit = 10)
get_spelled_like <- function(word = "test", return_type = "df", limit = 10) {
  get_content(paste0("/words?sp=", word), return_type, limit)
}

#' Get data for words that are related according to a supplied code.
#'
#' @param word to get similarly spelled words with.
#' @param code related word code from http://www.datamuse.com/api/.
#' @param return_type type to return. Options are:
#'  * 'df' for data.frame.
#'  * 'word' for a single word.
#'  * 'random_word' or 'random word' or 'rand' for a random word.
#'  * 'vector' for a vector of words.
#' @param limit max number of words to return.
#' @return data with words that are related.
#' @export
#' @examples
#' get_other_related("test", code = "jja", limit = 3)
#'
#' get_other_related("test", code = "cns", limit = 10)
get_other_related <- function(word = "test", code = "jja", return_type = "df", limit = 10) {
  if (code %in% c(
      "jja",	# Popular nouns modified by the given adj. (gradual -> increase)
      "jjb",	# Popular adjectives used to modify the given noun (beach -> sandy)
      "syn",	# Synonyms (ocean -> sea)
      "trg",	# "Triggers" (cow -> milking)
      "ant",	# Antonyms (late -> early)
      "spc",	# "Kind of" (gondola -> boat)
      "gen",	# "More general than" (boat -> gondola)
      "com",	# "Comprises" (car -> accelerator)
      "par",	# "Part of" (trunk -> tree)
      "bga",	# Frequent followers (wreak -> havoc)
      "bgb",	# Frequent predecessors (havoc -> wreak)
      "rhy",	# Rhymes - Perfect (spade -> aid)
      "nry",	# Approximate rhymes (forest -> chorus)
      "hom",	# Homophones - sound-alike words (course -> coarse)
      "cns"   # Consonant match	(sample -> simple)
    )
  ) {
    get_content(paste0("/words?rel_", code, "=", word), return_type, limit)
  } else {
    warning(
      paste0('"', code, '" is not a valid code. Please refer to the list of
             valid codes at http://www.datamuse.com/api/'),
      immediate. = TRUE
      )
  }
}
