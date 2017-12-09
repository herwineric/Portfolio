#'@title Filtering words
#'@description This is a complementary function to fix_the_string. Filter the data with another database or just a threshold.
#'@param data data is here
#'@param match_data shall be a integer of class character or numeric
#'@param low_tresh lower threshold. Do not recommend to lower this much more due to computational reasons.
#'@return Returns the filtered words.
#'@export

filter_words <- function(data, match_data = NULL, low_tresh = 0.005){
  
  sorted_s <- sort(data[data > 1], decreasing = TRUE)
  
  
  if(is.null(match_data) == FALSE){
    finns <- sorted_s[1:100]
    match_v <- c(as.character(match_data[1:100,]), "")
  } else {
    finns <- sorted_s[1:100]
    match_v <- names(sorted_s[sorted_s > length(str_ing_func)* 0.05 ])
  }
  
  
  #cleaning step of freqent/ non-frequent words
  rem <- names(finns)[(names(finns) %in% match_v) == TRUE]
  bort <- sorted_s[-which(rem %in% names(sorted_s)) ]
  #low treshold
  bort <- bort[bort > (low_tresh*length(data))]
  
  return(bort)
}