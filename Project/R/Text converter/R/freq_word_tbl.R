#'@title Filtered frequent words in the string.
#'@description This is a function that can split the string and filter it and produce a table of frequent words. This is also a complemntary function to fix_the_string.
#'@param data_string The string to be analysied. 
#'@param minSup minimum support for the words.
#'@param check_words a vector of words if you want to filter away some words manually. A pre-build in vector is in place for a small amount of common english words. Default is NULL.
#'@return Returns the frequency table of the words and the splitted original data.
#'@export

freq_word_tbl <- function(data_string, minSup, check_words = NULL){
  
  if(is.null(check_words)){
    #just some common words
    check_words <-  c("a","about",  "all", "also", "and", "as", "at" ,"be", "because", "but", "by", "can", "come", "do", "i", "it", "of", "or", "to", "so")
  } 
  
  split <- str_split(string = data_string, pattern = " ")
  
  if(.Platform$OS.type == "unix"){
    split_n_clean <- parallel::mclapply(split, FUN = function(x){
      cleaned <- gsub(x = x, pattern = "[[:punct:]]+", replacement = "")
      return(tolower(cleaned))
    })
  } else {
    split_n_clean <- lapply(split, FUN = function(x){
      cleaned <- gsub(x = x, pattern = "[[:punct:]]+", replacement = "")
      return(tolower(cleaned))
    })
  }
  
  frequent_1_items <- table(unlist(split_n_clean))
  check <- minSup * length(frequent_1_items)
  
  frequent_1_items <- frequent_1_items[frequent_1_items >= check & names(frequent_1_items) != ""]
  frequent_1_items <- frequent_1_items[(names(frequent_1_items) %in% check_words) == FALSE]
  
  ret_2 <- list(frequent_1_items = frequent_1_items, split_n_clean = split_n_clean)
  return(ret_2)
}
