#' Make Sentence
#'
#' This function allows you to create a sentence from a body of words loaded by this package
#' @param corpus List. A list output by tweet_gettr.
#' @param prompt String. A string containing a word to start the markov chain.
#' @param sentiment String. The goal sentiment of the sentence.
#' @param lazy_sentiment Boolean. The option to choose only from words that have the selected sentiment if applicable. If FALSE, it will increase words of the given sentiment by "amp" times.
#' @param amp The number of times to increase words of the appropriate sentiment when lazy_sentiment is FALSE.
#' @keywords sentence
#' @export
#' @examples
#' make_sentence(corpus, prompt = "I", sentiment = "", lazy_sentiment = T, amp = 1)

make_sentence <- function(corpus, prompt = "", sentiment = "", lazy_sentiment = T, amp = 1) {
  handles <- corpus$handles
  corpus <- corpus$tokens

  # No prompt available
  if (nchar(prompt) == 0) {
    selected_word <- sample(corpus[corpus$firsts, "raw_tokens"], 1)
  }

  # User prompted the sentence maker
  else {
    # determine if the prompt is IN our corpus
    regex_prompt <- paste('\\b', prompt, '\\b', sep = "")
    prompt_is_valid <- grepl(regex_prompt, corpus$lowercase_tokens, ignore.case = T)
    if (grepl("@", prompt)) {
      # do nothing lmfao
    }else if (!any(prompt_is_valid)) {
      return("This prompt is bad!")
    }
    selected_word <- prompt
  }

  sentence <- selected_word
  print(sentence)

  # if our first word contains an @, change our first word to an @, this allows us to search through our raw tokens.
  # Our selected word is already recorded in sentence, so we don't need to worry.
  if (grepl("@", selected_word)) {
    selected_word <- "@"
  }

  while(!grepl('[.!?]|ENDOFLINE', sentence)) {
    matches <- append(c(F), stringr::str_to_lower(selected_word) == corpus$lowercase_tokens)
    after_match <- corpus[matches, ]
    # No sentiment influence
    if (nchar(sentiment) == 0) {
      after_sentiment <- after_match$raw_tokens
      # Only choose from the chosen sentiment. If the sentiment has no followups, pick from the standard one
    } else if(lazy_sentiment) {
      after_sentiment <- after_match[after_match$sentiment == sentiment, "raw_tokens"]
      if (nrow(after_sentiment) == 0) {
        after_sentiment <- after_match$raw_tokens
      }
      # Increase the ammount of tweets of a certain sentiment by amp
    } else {
      good_words <- after_match[after_match$sentiment == sentiment, "raw_tokens"]
      after_sentiment <- c(after_match$raw_tokens, rep(good_words, amp))
      asdf <- readline(prompt="sentence")
    }

    selected_word <- sample(after_sentiment, 1)
    if (grepl("@", selected_word)) {
      # for some reason, it cannot randomly pick from our handles list???
      selected_at <- sample(handles,1, replace = T)
      sentence <- paste(sentence, selected_at)
      selected_word <- "@"
    } else {
      sentence <- paste(sentence, selected_word)
    }

  }

  sentence <- stringr::str_replace(sentence, " ENDOFLINE", "")
  return(sentence)
}
