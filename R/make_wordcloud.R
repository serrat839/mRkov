#' TwittR Setup
#'
#' This function takes in the output from tweet_gettr or read_text_file and generates a word cloud from the most frequent words
#' words can be removed by using the stops parameter
#'
#' @param information List. The output from tweet_gettr or read_text_file
#' @param stops String or vector of strings. Words to remove from the word cloud
#' @param n Int. Max number of words to be included in wordcloud. Defaults to Inf.
#' @keywords setup, api
#' @export
#' @examples
#' make_wordcloud(trump_tweets)
#'

make_wordcloud <- function(information, stops = "", n = Inf) {
  if (is.null(information)) {
    return(NULL)
  }
  lowercase_tokens <- NULL
  information <- information$tokens
  information <- information %>%
    dplyr::count(lowercase_tokens, sort =T)

  stop_words <- stopwords::data_stopwords_smart$en
  stop_words <- c(stop_words, stops, "endofline")
  stop_words <- data.frame(stop_words, stringsAsFactors = F)
  information <- dplyr::anti_join(information, stop_words, by= c("lowercase_tokens" = "stop_words"))
  wordcloud::wordcloud(information$lowercase_tokens, information$n, max.words = n)
}
