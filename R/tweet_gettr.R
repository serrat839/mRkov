#' Tweet GettR
#'
#' This function lets you scrape the timeline of any twitter user.
#' @param handle The handle of the twitter user's timeline you wish to scrape.
#' @param output The location of an output text file that you can re-use if you want a re-usable file of tweets. Defaults to a blank string, no output saved.
#' @keywords Twitter, Scraping
#' @return Returns a properly-formatted list that you can run make_sentence on
#' @examples
#' test_function("\@realDonaldTrump", "./trump.txt")

tweet_gettr <- function(handle, output = "") {
  # Make sure that this is an @
  if (substr(handle,1,1) != '@') {
    handle <- paste('@', handle, sep = "")
  }
  tweets <- twitteR::userTimeline(handle, n= 3200, includeRts = TRUE, excludeReplies = FALSE)
  tweets <- twitteR::twListToDF(tweets)
  tweets <- tweets$text
  tweets <- str_replace_all(tweets, "'", "")
  tweets <- str_replace_all(tweets, "\n", "newline")
  
  # export the tweets here
  if (nchar(output) > 0) {
    fileConn <- file(output)
    writeLines(tweets, fileConn, sep = "\n")
    close(fileConn)
  }
  
  # prep for make_sentencce
  #  Add delimiters
  tweets <- paste(tweets, "ENDOFTWEET")
  
  # tokenize the tweets
  token_list <- strsplit(corpus, " ")
  # get the first word of each tweet
  # create a lowercase tweet vector and a raw tweet vector
  
  return(tweets)
}

