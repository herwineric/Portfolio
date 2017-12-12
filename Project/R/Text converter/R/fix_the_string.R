#'@title Takes a string and converts it to columns.
#'@description The input is a variable of strings. The function filter the data and gets the most frequent words in the variable into a vaiable. This variable is the filtered with a choosen string or just a threshold.
#'@param data_string The vaible/ string that you want to columns. Must be of class "character"
#'@param data_orginal An optional data frame to bind the columns to a data set. data_orginal and data_string must be of the same length.
#'@param match_data An optional string to filter the words in the variable.
#'@param low_tresh Ignore if match_data is given. Sets a lower threshold to filter out non-frequent words porportinal to unique words in data_string.
#'@param seperator Default values "punct" and "digit", but accept more. See https://stat.ethz.ch/R-manual/R-devel/library/base/html/regex.html for more.
#'@return Returns a data frame with class "TTC". 
#'@export

fix_the_string <- function(data_string, data_orginal = NULL, match_data = NULL, low_tresh = 0.005, seperator = c("punct","digit")){
  
  if(is.null(match_data) == FALSE){
    cat("Converting a string of length", length(data_string), "to", length(match_data),"columns", "\n")
  } else {
    cat("Converting a string of length", length(data_string), "to columns with threshold ",low_tresh, "\n")
  }
  
  Sys.sleep(0.05)
  
  pb <- txtProgressBar(0,1, label = "Hj", style = 3)
  
  setTxtProgressBar(pb, 0.1, title = "Initilizing")
  
  #1:th
  str_ing_func <- freq_word_tbl(data_string, seperator)
  
  setTxtProgressBar(pb, 0.3333, title = "Split Done!")
  
  bind <- str_ing_func[[1]]
  
  #2:th
  final_words <- filter_words(bind, match_data)
  
  setTxtProgressBar(pb, 0.6666, title = "Gathering the words!")
  
  bind2 <- str_ing_func[[2]]
  
  #3:th
  data_done <- words_to_col(data_orginal, final_words, str_ing_v = bind2)
  setTxtProgressBar(pb, 0.9999, title = "Done!")
  
  close(pb)
  
  class(data_done) <- "TTC"
  return(data_done)
}