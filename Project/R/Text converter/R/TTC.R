#'@title Takes a string and converts it to columns.
#'@description The input is a variable of strings. The function filter the data and gets the most frequent words in the variable into a vaiable. This variable is the filtered with a choosen string or just a threshold.
#'@param data_string The vaible/ string that you want to columns. Must be of class "character"
#'@param minSup minimum support for the words.
#'@param check_words a vector of words if you want to filter away some words manually. A pre-build in vector is in place for a small amount of common english words. Default is NULL.
#'@return Returns a data frame with class "TTC". 
#'@examples 
#'data("data_TTC")
#'TTC(data_TTC$text, minSup = 0.01)
#'
#'
#'@export

TTC <- function(data_string, minSup, check_words = NULL){
  
  stopifnot(is.numeric(minSup))
  
  #1
  filtered_words <- freq_word_tbl(data_string = data_string, minSup = minSup, check_words = check_words)
  
  #2
  data_done <- words_to_col(frequent_1_items = filtered_words$frequent_1_items, split_n_clean = filtered_words$split_n_clean)
  
  class(data_done) <- c("matrix", "TTC")
  return(data_done)
}
