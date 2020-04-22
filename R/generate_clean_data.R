#' generate_clean_data
#'
#' This function allows you to link your twitter to the twitter API
#' If you don't have twitter api keys, go to https://developer.twitter.com/ and
#' create an account. Then, go to create an app, fill out the form, and you should be able to access your very own keys and tokens.
#' @param text_lines Vector. A vector of lines of text that was given to us from the data collection functions `tweet_gettr()` and `read_text_file()`
#' @param sentiments DataFrame. A DataFrame of sentiments to use when attaching sentiment data to words.
#' @param twitter_name String. An optional place to store meta-data about twitter users.
#' @keywords internal
#' @importFrom magrittr "%>%"
#' @noRd

generate_clean_data <- function(text_lines, sentiments, twitter_data=NULL) {

  # remove t.co links
  text_lines <- gsub("https:\\/\\/t\\.co\\/.*","" ,text_lines)
  # add line delimiters
  text_lines <- paste(text_lines, "ENDOFLINE")
  # add a space in front of every punctuation mark, this way each punctuation mark will be a token
  text_lines <- gsub("([\\.|\\?|\\,|\\!])"," \\1 ", text_lines)
  # change newline back into escaped new line
  text_lines <- gsub("newline","\n", text_lines)
  # remove double spaces before and after words
  text_lines <- gsub("\\s+"," ", text_lines)
  # fix "&" being represented as "&amp;"
  text_lines <- gsub("&amp;","&", text_lines)
  # Remove quotation marks
  text_lines <- gsub('"',"", text_lines)

  # tokenize the lines
  token_list <- strsplit(text_lines, " ")

  # make the tokens into a vector
  raw_tokens <- unlist(token_list)

  # make a dataframe with clean(lowercase) tokens, raw tokens and a column saying if it is a first word or not
  text_data <- data.frame(raw_tokens, stringsAsFactors = F)
  text_data$lowercase_tokens <- stringr::str_to_lower(text_data$raw_tokens)

  firsts <- raw_tokens == "ENDOFLINE"
  firsts <- c(T, firsts[-length(firsts)])
  text_data$firsts <- firsts

  # add a sentiment column
  text_data <- dplyr::left_join(text_data, sentiments, by = c("lowercase_tokens" = "word"), name= "sentiment")

  # change sentiment rows with na to be some other blank option
  text_data[is.na(text_data$sentiment), "sentiment"] <- "no_sentiment"

  # create a bank of @'s
  has_at <- grepl("@", text_data$raw_tokens)
  handles <- text_data[has_at, "raw_tokens"]
  text_data[has_at,"lowercase_tokens"] <- "@"

  # create the list we want to return
  data_list <- list(text=text_lines, tokens=text_data, handles=handles, twitter_meta = twitter_data)

  return(data_list)
}
