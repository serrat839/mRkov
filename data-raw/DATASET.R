## code to prepare `DATASET` dataset goes here
library(mRkov)
trump_tweets <- tweet_gettr("@realdonaldtrump", includeRts = FALSE)
usethis::use_data(trump_tweets)
