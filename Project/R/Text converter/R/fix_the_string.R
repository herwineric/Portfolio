#'@title Filtering words
#'@description This is a complementary function to fix_the_string. Filter the data with another database or just a threshold.
#'@param data_string more data
#'@param data_orginal shall be a integer of class character or numeric
#'@param leng desired length of the data
#'@param match_data Possible data base
#'@param low_tresh lower theshold
#'@return Returns the merged data frame with columns of text
#'@export

fix_the_string <- function(data_string, data_orginal, leng = 1000, match_data = NULL, low_tresh = 0.005){
  
  pb <- txtProgressBar(0,1, label = "Hj", style = 3)
  
  setTxtProgressBar(pb, 0.1, title = "Initilizing")
  
  #1:th
  str_ing_func <- freq_word_tbl(data_string, leng)
  
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
  return(data_done)
}