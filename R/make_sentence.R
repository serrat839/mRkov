#' A test function!
#'
#' This function allows you to link your twitter to the twitter API
#' If you don't have twitter api keys, go to https://developer.twitter.com/ and 
#' create an account. Then, go to create an app, fill out the form, and you should be able to access your very own keys and tokens.
#' @param love Do you lvoe cats? Default to true
#' @keywords cats
#' @export
#' @examples
#' test_function()

make_sentence <- function(corpus, prompt = "") {
  
  # No prompt available
  if (nchar(prompt) == 0) {
    selected_word <- sample(corpus$firsts, 1)
  } 
  
  # User prompted the sentence maker
  else {
    # determine if the prompt is IN our corpus
    regex_prompt <- paste('\\b', prompt, '\\b', sep = "")
    prompt_is_valid <- grepl(regex_prompt, corpus$lowercase_tokens, ignore.case = T)
    
    if (!any(prompt_is_valid)) {
      return("This prompt is bad!")
    }
    
    selected_word <- prompt
  }
  sentence <- selected_word
  print(sentence)
  
  words <- 0
  
  while(!grepl('[!?]|ENDOFTWEET', sentence)) {
    matches <- append(c(F), stringr::str_to_lower(selected_word) == corpus$lowercase_tokens)
    print(matches)
    after_match <- corpus$raw_tokens[matches]
    selected_word <- sample(after_match, 1)
    sentence <- paste(sentence, selected_word)
    words <- words + 1
  }
  
  sentence <- stringr::str_replace(sentence, " ENDOFTWEET", "")
  return(sentence)
}