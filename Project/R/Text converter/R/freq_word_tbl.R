#'@title Filtered frequent words in the string.
#'@description This is a function that can split the string and filter it and produce a table of frequent words. This is also a complemntary function to fix_the_string.
#'@param data_string The string to be analysied. 
#'@param seperator Default values "punct" and "digit", but accept more. See https://stat.ethz.ch/R-manual/R-devel/library/base/html/regex.html for more.
#'@return Returns the filtered words.
#'@export

freq_word_tbl <- function(data_string, seperator = c("punct","digit")){
  
  str_ing <- str_split(string = data_string, pattern = " ")
  
  if(length(seperator) >= 1 ){
    ##
    string_extr <- c("[")
    for(txt in 1:length(seperator)){
      string_extr[txt+1] <- paste0("[:", seperator[txt], ":]", collapse = "")
    }
    string_extr[length(string_extr)+1] <- "]+"
    
    string_of_filter <- paste0(string_extr, collapse = " ")
    ##
    
    #take away all the dots and digits and make it to lower-case
    str_ing_v <- lapply(str_ing, FUN = function(x){
      
      s1 <- gsub(string_of_filter, "", x)
      tolower(s1)
    })
    
  } else {
    str_ing_v <- tolower(str_ing)
  }

  unl_str_ing_v <- unlist(str_ing_v)
  
  str_ing_v_tabl <- table(unl_str_ing_v)
  
  return(list(str_ing_v_tabl, str_ing_v))
}
