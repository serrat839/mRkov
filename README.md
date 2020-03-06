# mRkov

This is a markov chain twitter package.
Using the twitteR package, it scrapes a twitter handle that you can query to randomly generate sentences from!

## Install Instructions
```
# install.packages("devtools")
library(devtools)
install_github("serrat839/mRkov")
```

## How to use
```
# Load the package
library(mRkov)

# Connect to dummy twitter account
setup_twittR()

# Select a twitter handle and save to a variable
tweets <- tweet_gettr("@realDonaldTrump")

# Query our variable to make a sentence
make_sentence(tweets)
```
