#' TwittR Setup
#'
#' This function takes in the output from tweet_gettr or read_text_file and generates a word cloud from the most frequent words
#' words can be removed by using the stops parameter
#'
#' @param information List. The output from tweet_gettr or read_text_file
#' @param stops String or vector of strings. Words to remove from the word cloud
#' @keywords setup, api
#' @export
#' @examples
#' make_wordcloud(tweet_data)
#'

make_wordcloud <- function(information, stops = "") {
  if (is.null(information)) {
    return(NULL)
  }
  information <- information$tokens
  information <- information %>%
    dplyr::group_by(lowercase_tokens) %>%
    dplyr::summarise(n = n()) %>%
    dplyr::arrange(-n)

  stopwords <- stopwords::data_stopwords_smart$en
  stopwords <- c(stopwords, stops, "endofline")
  stopwords <- data.frame(stopwords, stringsAsFactors = F)
  information <- dplyr::anti_join(information, stopwords, by= c("lowercase_tokens" = "stopwords"))
  wordcloud::wordcloud(information$lowercase_tokens, information$n)
}
