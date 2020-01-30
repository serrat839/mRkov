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
  # step one
  corpus <- paste(corpus, "THISISTHEENDOFTHESENTENCE") # vector of sentences
  
  token_list <- strsplit(corpus, " ") # list of vectors of tokens
  
  # No prompt available
  if (nchar(prompt) == 0) {
    # id first words and pick one
    firsts <- c()
    for (sentence in token_list) {
      # pick the first token for each entry in token_list
      firsts <- append(firsts, sentence[1])
    }
    
    # randomly select one of our first tokens, saving the word and also adding it to our sentence
    selected_word <- sample(firsts, 1)
    sentence <- selected_word
  } 
  
  # User prompted the sentence maker
  else {
    # determine if the prompt is IN our corpus
    regex_prompt <- paste('\\b', prompt, '\\b', sep = "")
    prompt_is_valid <- F
    for (sentence in token_list) {
      if(!any(prompt_is_valid)) {
        prompt_is_valid <- grepl(regex_prompt, sentence, ignore.case = T)
      } else {
        break
      }
      
    }
    if (!any(prompt_is_valid)) {
      return("This prompt is bad!")
    }
    # first word is prompt (or prompts last word)
    selected_word <- prompt
    sentence <- prompt
  }
  
  
  # convert our list of vectors into a giant vector of tokens
  token_list <- unlist(token_list)
  # add a period to the end of our vector just for saftey
  token_list <- append(token_list, ".")
  # make our giant vector lowercase to avoid case sensitivity
  lowercase_token_list <- str_to_lower(token_list) 
  words <- 0
  
  while(!grepl('[!?]|THISISTHEENDOFTHESENTENCE', sentence)) {
    matches <- append(c(F), str_to_lower(selected_word) == lowercase_token_list)
    after_match <- token_list[matches]
    selected_word <- sample(after_match, 1)
    sentence <- paste(sentence, selected_word)
    words <- words + 1
  }
  
  sentence <- str_replace(sentence, " THISISTHEENDOFTHESENTENCE", "")
  return(sentence)
}