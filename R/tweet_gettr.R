#' Tweet GettR
#'
#' This function lets you scrape the timeline of any twitter user. You MUST run the setup function before using this function in order for it to work.
#' @param handle The handle of the twitter user's timeline you wish to scrape.
#' @param output The location of an output text file that you can re-use if you want a re-usable file of tweets. Defaults to a blank string, no output saved.
#' @param n Integer. Defaults to `3200`. The number of tweets to pull.
#' @param includeRts Boolean. Defaults to `FALSE`. Whether or not to include re-tweets.
#' @param excludeReplies Boolean. Defaults to `TRUE`. Wehter or not to exclude replies.
#' @keywords Twitter, Scraping
#' @return Returns a properly-formatted list that you can run make_sentence on
#' @export
#' @examples
#' test_function("@realDonaldTrump", "./trump.txt")

tweet_gettr <- function(handle, output = "", n = 3200,
                        includeRts = FALSE, excludeReplies = TRUE) {
  # Make sure that this is an @
  if (substr(handle,1,1) != '@') {
    handle <- paste('@', handle, sep = "")
  }

  # Scrape handle's timeline.
  #  Exits if the twitter api is not setup
  tweets <- tryCatch(
    {twitteR::userTimeline(handle, n = n, includeRts = includeRts,
                           excludeReplies = excludeReplies)},
    error = function(cond) {
      message("Error: Twitter api not setup. Please use setup_twitteR in order to scrape tweets from Twitter")
      stop()
    }
  )

  tweets <- twitteR::twListToDF(tweets)
  tweets <- tweets$text
  tweets <- stringr::str_replace_all(tweets, "'", "")
  tweets <- stringr::str_replace_all(tweets, "\n", "newline")

  # export the tweets here
  if (nchar(output) > 0) {
    fileConn <- file(output)
    writeLines(tweets, fileConn, sep = "\n")
    close(fileConn)
  }

  # prep for make_sentencce
  # Add delimiters
  tweets <- paste(tweets, "ENDOFTWEET")

  # tokenize the tweets
  token_list <- strsplit(tweets, " ")

  # get the first word of each tweet
  firsts <- c()
  for (sentence in token_list) {
    # pick the first token for each entry in token_list
    firsts <- c(firsts, sentence[1])
  }

  # make the token list into a vector
  token_vector <- unlist(token_list)

  # create a lowercase tweet vector and a raw tweet vector
  token_vector_lowercase <- stringr::str_to_lower(token_vector)

  # create the list we want to return
  data_list <- list(text=tweets, firsts=firsts, raw_tokens=token_vector, lowercase_tokens=token_vector_lowercase)

  return(data_list)
}

