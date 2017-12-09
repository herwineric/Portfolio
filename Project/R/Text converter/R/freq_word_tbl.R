#'@title Frequent words
#'@description This is a complementary function to fix_the_string. Filter the data with another database or just a threshold.
#'@param data_string data string 
#'@param leng length of data
#'@return Returns the filtered words.
#'@export

freq_word_tbl <- function(data_string, leng = 1000){
  
  str_ing <- str_split(string = data_string[1:leng],pattern = " ")
  
  #take away all the dots and digits
  str_ing_v <- lapply(str_ing, FUN = function(x){
    
    s1 <- gsub("[[:punct:] [:digit:]]+", "", x)
    tolower(s1)
  })
  
  unl_str_ing_v <- unlist(str_ing_v)
  
  
  #make it to lower-case
  df <- data.frame(list = unl_str_ing_v)
  
  
  str_ing_v_tabl <- table(df$list)
  
  return(list(str_ing_v_tabl, str_ing_v))
}
