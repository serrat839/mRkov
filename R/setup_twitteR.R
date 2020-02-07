#' TwittR Setup
#'
#' This function allows you to link your twitter to the twitter API
#' If you don't have twitter api keys, go to https://developer.twitter.com/ and
#' create an account. Then, go to create an app, fill out the form, and you should be able to access your very own keys and tokens.
#' @keywords setup, api
#' @export
#' @examples
#' setup_twitteR()

setup_twitteR <- function() {
  api_key <- "23YB5C8ywbEP9tkjzADC3u1fx"
  api_secret <- "SwWlFEk2DDaSjOezkcFi5b9HhR0eIicqB1kPJLgLNZOI8V6KDk"
  token <- "1223331636856573952-xGkEYLfx5oe9VxD9abTllVpUax6YQe"
  token_secret <- "A0ijbzOkW3uYUQAIy24sFP7Qbp3nM8Of2sSg4L7cPgSvi"
  twitteR::setup_twitter_oauth(api_key, api_secret, token, token_secret)
}
