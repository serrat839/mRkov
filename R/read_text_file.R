#' Tweet GettR
#'
#' This function lets you scrape the timeline of any twitter user. You MUST run the setup function before using this function in order for it to work.
#'
#' @param text_file String. Path to the text file you want to read in
#' @param delimiter String. String that dictates what is a new line
#' @keywords Twitter, Scraping
#' @return Returns a properly-formatted list that you can run make_sentence on
#' @export
#' @examples
#' read_text_file(paste0( "~/trump.txt"))

read_text_file <- function(text_file, delimiter = "\n") {
  text <- scan(text_file, character(), quote="", sep = delimiter)

  # Maybe add sentiments back one day
  #if(is.null(sentiments)) {
  #  sentiments <- tidytext::get_sentiments("bing")
  #}

  return(generate_clean_data(text, sentiments))
}
