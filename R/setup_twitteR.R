#' TwittR Setup
#'
#' This function allows you to link your twitter to the twitter API
#' If you don't have twitter api keys, go to https://developer.twitter.com/ and 
#' create an account. Then, go to create an app, fill out the form, and you should be able to access your very own keys and tokens.
#' @param api_key A string containing your api key
#' @param api_secret A string containing your secret api key
#' @param token A string containing your token
#' @param token_secret A string containing your secret token
#' @keywords setup, api
#' @export
#' @examples
#' setup_twitteR("api_key", "api_secret", "token", "token_secret")

setup_twitteR <- function(api_key, api_secret, token, token_secret) {
  twitteR::setup_twitter_oauth(api_key, api_secret, token, token_secret)
}