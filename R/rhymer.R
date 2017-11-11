library(httr)
library(jsonlite)

ua <- user_agent("http://github.com/nlandesberg/rhymer")


#' Call datamuse API and return data frame.
#'
#' @param path path to append to datamuse API endpoint.
#' @return dataframe with data returned from API call.
#' @export
#' @examples
#' datamuse_api("/words?rel_rhy=test")
#' datamuse_api("/words?ml=test")
datamuse_api <- function(path) {
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
#' @export
#' @examples
#' print(datamuse_api("/words?rel_rhy=test"))
#' print(datamuse_api("/words?ml=test"))
print.datamuse_api <- function(x, ...) {
  cat("<datamuse ", x$path, ">\n", sep = "")
  str(x$content)
  invisible(x)
}

get_data <- function(full_path, limit = 10) {
  x <- datamuse_api(full_path)
  content <- x$content

  if ("score" %in% colnames(content)) {
    content <- content %>% head(limit)
  }

  return(content)
}

get_rhyme <- function(word = "test", limit = 10) {
  get_data(paste0("/words?rel_rhy=", word), limit)
}

get_means_like <- function(word = "test", limit = 10) {
  get_data(paste0("/words?ml=", word), limit)
}

get_sounds_like <- function(word = "test", limit = 10) {
  get_data(paste0("/words?sl=", word), limit)
}

get_spelled_like <- function(word = "test", limit = 10) {
  get_data(paste0("/words?sp=", word), limit)
}

get_other_related <- function(word = "test", code = "jja", limit = 10) {
  get_data(paste0("/words?rel_", code, "=", word), limit)
}


