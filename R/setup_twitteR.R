#' TwittR Setup
#'
#' This function allows you to link your twitter to the twitter API
#' If you don't have twitter api keys, go to https://developer.twitter.com/ and
#' create an account. Then, go to create an app, fill out the form, and you should be able to access your very own keys and tokens.
#' @param api_key String. Defaults to NULL. User's api key if they don't wish to use ours
#' @param api_secret String. Defaults to NULL. User's secret api if they don't wish to use ours
#' @param token String. Defaults to NULL. User's token if they don't wish to use ours
#' @param token_secret String. Defaults to NULL. User's secret token if they don't wish to use ours
#' @keywords setup, api
#' @export
#' @examples
#' setup_twitteR()

setup_twitteR <- function(api_key = NULL, api_secret = NULL, token = NULL, token_secret = NULL) {
  # if any of the parameters are not fulfilled, use our api keys
  if (is.null(api_key) | is.null(api_secret) | is.null(token) | is.null(token_secret)) {
  print("Using mRkov api...")
  api_key <- "23YB5C8ywbEP9tkjzADC3u1fx"
  api_secret <- "SwWlFEk2DDaSjOezkcFi5b9HhR0eIicqB1kPJLgLNZOI8V6KDk"
  token <- "1223331636856573952-xGkEYLfx5oe9VxD9abTllVpUax6YQe"
  token_secret <- "A0ijbzOkW3uYUQAIy24sFP7Qbp3nM8Of2sSg4L7cPgSvi"
  }
  twitteR::setup_twitter_oauth(api_key, api_secret, token, token_secret)
}
