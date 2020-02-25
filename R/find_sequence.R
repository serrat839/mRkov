#' find_sequence
#'
#' This function allows the user to search for a word that matches a sequence of words, going n-words
#' back when searching for a matching word.
#' @keywords internal
#' @noRd

find_sequence <- function(history, bank) {
  # create a list to hold word-match sequences
  aux_list <- list()
  # create boolean vectors of matching words for each word in the history word-list
  for (x in history) {
    aux_list[[x]] <- bank == x
  }

  # using the oldest word, create a preliminary boolean vector
  sequence <- aux_list[[1]]
  # remove this vector so we don't use it twice
  aux_list[[1]] <- NULL

  for (x in aux_list) {
    # Shift the sequence's values down one
    modified_sequence <- c(FALSE, sequence[-length(sequence)])
    # Take the union of these lists so that two trues = true and a
    # true false = false. This allows us to get words that are in
    # a sequence, only selecting words that are available after the xth position
    # in the sequence
    sequence <- (x & modified_sequence)
  }

  # Shift the sequence down one and now we have our bank of next words!
  sequence <- c(FALSE, sequence[-length(sequence)])
  return(sequence)
}
