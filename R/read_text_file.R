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
#' test_function("@realDonaldTrump", "./trump.txt")

read_text_file <- function(text_file, delimiter = "\n", sentiments = NULL) {
  text <- scan(text_file, character(), quote="", sep = delimiter)

  if(is.null(sentiments)) {
    sentiments <- tidytext::get_sentiments("bing")
  }

  return(generate_clean_data(text, sentiments))
}
