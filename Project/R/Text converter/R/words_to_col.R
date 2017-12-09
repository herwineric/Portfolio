#'@title Words to col
#'@description This is a complementary function to fix_the_string. Filter the data with another database or just a threshold.
#'@param data_orginal data
#'@param word_string shall be a integer of class character or numeric
#'@param str_ing_v lower threshold. Do not recommend to lower this much more due to computational reasons
#'@return Returns the filtered words.
#'@export

words_to_col <- function(data_orginal, word_string, str_ing_v){
  #data_orginal is the data you want to merge with
  
  
  names_data <- sort(names(word_string))
  
  #creates the matrix that is going to be filled
  store_matr <- matrix(0, ncol = length(word_string), nrow = nrow(data_orginal))
  colnames(store_matr) <- names_data
  
  
  #creates tables of words for each cell from function freq_word_tbl with str_ing_v
  str_ing_v_table <- lapply(str_ing_v, function(x){
    i_1 <- x[x %in% names_data]
    table(i_1)
  })
  
  
  #creates a vector positions for each cell from function freq_word_tbl with str_ing_v
  str_ing_v_lapply <- lapply(str_ing_v_table, function(x){
    which(names_data %in% names(x))
  })
  
  
  #throw everything in to the matrix
  for(i in 1:nrow(store_matr)){
    
    what_word <- str_ing_v_lapply[[i]]
    
    store_matr[i, what_word] <- str_ing_v_table[[i]]
    
  }
  
  dat_store <- data.frame(store_matr)
  
  dat_final <- cbind(data_orginal,dat_store)
  
  # org_data.frame(ID = train$train_id, price = train$price,shipping = train$shipping,item_condition_id = train$item_condition_id)
  
  return(dat_final)
}
