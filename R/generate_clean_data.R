#' TwittR Setup
#'
#' This function allows you to link your twitter to the twitter API
#' If you don't have twitter api keys, go to https://developer.twitter.com/ and
#' create an account. Then, go to create an app, fill out the form, and you should be able to access your very own keys and tokens.
#' @keywords internal
#' @noRd
#' @examples

generate_clean_data <- function(text_lines, sentiments) {
  print("We in here!")

  # add line delimiters
  text_lines <- paste(text_lines, "ENDOFLINE")

  # tokenize the lines
  token_list <- strsplit(text_lines, " ")

  # make the tokens into a vector
  raw_tokens <- unlist(token_list)

  # make a dataframe with lowercase(clean) tokens, raw tokens and a column saying if it is a first word or not
  text_data <- data.frame(raw_tokens, stringsAsFactors = F)
  text_data$lowercase_tokens <- stringr::str_to_lower(text_data$raw_tokens)

  firsts <- raw_tokens == "ENDOFLINE"
  firsts <- c(T, firsts[-length(firsts)])
  text_data$firsts <- firsts

  # add a sentiment column
  text_data <- dplyr::left_join(text_data, sentiments, by = c("lowercase_tokens" = "word"), name= "sentiment")

  # change sentiment rows with na to be some other blank option
  text_data[is.na(text_data$sentiment), "sentiment"] <- "no_sentiment"

  # create the list we want to return
  data_list <- list(text=text_lines, tokens=text_data)

  return(data_list)
}
