#' A test function!
#'
#' This function allows you to express your love of cats.
#' @param love Do you lvoe cats? Default to true
#' @keywords cats
#' @export
#' @examples
#' test_function()

tweet_gettr <- function(handle, output) {
  # Make sure that this is an @
  if (substr(handle,1,1) != '@') {
    handle <- paste('@', handle, sep = "")
  }
  tweets <- twitteR::userTimeline(handle, n= 3200, includeRts = TRUE, excludeReplies = FALSE)
  tweets <- twListToDF(tweets)
  tweets <- tweets$text
  tweets <- str_replace_all(tweets, "'", "")
  tweets <- str_replace_all(tweets, "\n", "newline")
  return(tweets)
}

