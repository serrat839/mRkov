# mRkov

## Functionality
This R package allows users to load in data via twitter or text file, and then perform analysis of said data.
There are two functions that allow users to load data:
```
# Scrape a twitter user's timeline
tweet_gettr()
# Read from a local text file
read_text_file()
```

After storing this data in a variable, users can then pass it to our `make_sentence()` function or `make_wordcloud` function to simulate or visualize the loaded data.

## Install Instructions
```
# install.packages("devtools")
library(devtools)
install_github("serrat839/mRkov")
```

## Short tutorial
```
# Load the package
library(mRkov)

# Select a twitter handle and save to a variable. API keys are pre-loaded for a dummy twitter account.
tweets <- tweet_gettr("@realDonaldTrump")

# Query our variable to make a sentence
make_sentence(tweets)

# Make a wordcloud
make_wordcloud(tweets)
```
