# mRkov

This is a markov chain twitter package.
Using the twitteR package, it scrapes a twitter handle that you can query to randomly generate sentences from!

## Install Instructions
```
# install.packages("devtools")
library(devtools)
install_github("serrat839/package")
```

## How to use
```
# Load the package
library(thePackage) # Sorry there is not a good name for it yet, I am open to suggestions

# Select a twitter handle and save to a variable
tweets <- tweet_gettr("@realDonaldTrump")

# Query our variable to make a sentence
make_sentence(tweets)
```

## Bugs and known issues
- If prompt is in the corpus, but it only appears within other characters, it will crash. for example, `prompt = navy` but navy only is in the string (navy)
