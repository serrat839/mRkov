#' Tweet GettR
#'
#' This function lets you scrape the timeline of any twitter user. You MUST run the setup function before using this function in order for it to work.
#'
#' @param handle The handle of the twitter user's timeline you wish to scrape.
#' @param output The location of an output text file that you can re-use if you want a re-usable file of tweets. Defaults to a blank string, no output saved.
#' @param n Integer. Defaults to `3200`. The number of tweets to pull.
#' @param includeRts Boolean. Defaults to `FALSE`. Whether or not to include re-tweets.
#' @param excludeReplies Boolean. Defaults to `TRUE`. Wehter or not to exclude replies.
#' @param sentiments Dataframe. Dataframe containing words and their sentiments. Columns MUST be "word" and "sentiment"
#' @keywords Twitter, Scraping
#' @return Returns a properly-formatted list that you can run make_sentence on
#' @export
#' @examples
#' tweet_gettr("@realDonaldTrump", "./trump.txt")

tweet_gettr <- function(handle, output = "", n = 3200,
                        includeRts = FALSE, excludeReplies = TRUE, sentiments = NULL) {
  # Make sure that this is an @
  if (substr(handle,1,1) != '@') {
    handle <- paste('@', handle, sep = "")
  }

  # Scrape handle's timeline.
  #  Exits if the twitter api is not setup
  tweets <- tryCatch(
    {twitteR::userTimeline(handle, n = 3200, includeRts = includeRts,
                           excludeReplies = excludeReplies)},
    error = function(cond) {
      message("Error: Twitter api not setup or hastag not set up. Please use setup_twitteR in order to scrape tweets from Twitter, and make sure the handle input was correct")
      stop()
    }
  )

  tweets <- twitteR::twListToDF(tweets)
  tweets <- tweets$text
  tweets <- stringr::str_replace_all(tweets, "\n", " newline ")

  if (length(tweets) > n) {
    tweets <- tweets[1:n]
  } else {
    message("Less tweets available than the desired amount")
  }

  # export the tweets here
  if (nchar(output) > 0) {
    fileConn <- file(output)
    writeLines(tweets, fileConn, sep = "\n")
    close(fileConn)
  }

  if(is.null(sentiments)) {
    print("Using standard sentiments...")
    sentiments <- tidytext::get_sentiments("bing")
  }

  twitter_data <- c(
    handle,
    twitteR::getUser(handle)$name
  )

  return(generate_clean_data(tweets, sentiments, c(twitter_data)))
}

