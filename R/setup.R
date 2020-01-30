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

setup <- function(api_key, api_secret, token, token_secret) {
  twitteR::setup_twitter_oauth(api_key, api_secret, token, token_secret)
}