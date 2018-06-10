#'@title Words to column
#'@description This is a complementary function to TTC function. 
#'@param frequent_1_items shall be a vector with thw frequency of the words
#'@param split_n_clean The splitted and cleaned words from freq_word_tbl
#'@return Returns the filtered words.
#'@export

words_to_col <- function(frequent_1_items, split_n_clean){
  nam_check <- names(frequent_1_items)
  
  if(.Platform$OS.type == "unix"){
    filtered_strings <- parallel::mclapply(split_n_clean, FUN = function(x){
      i_l <- x[x %in% nam_check]
      table(i_l)
    })
    
    str_ing_v_lapply <- parallel::mclapply(filtered_strings, function(x){
      which(nam_check %in% names(x))
    })
  } else {
    filtered_strings <- lapply(split_n_clean, FUN = function(x){
      i_l <- x[x %in% nam_check]
      table(i_l)
    })
    
    str_ing_v_lapply <- lapply(filtered_strings, function(x){
      which(nam_check %in% names(x))
    })
  }
  
  #creates the matrix that is going to be filled
  store_matr <- matrix(0, ncol = length(frequent_1_items), nrow = length(split_n_clean))
  colnames(store_matr) <- nam_check
  
  #throw everything in to the matrix
  for(i in 1:nrow(store_matr)){
    
    what_word <- str_ing_v_lapply[[i]]
    
    store_matr[i, what_word] <- filtered_strings[[i]]
  }
  return(store_matr)
}






