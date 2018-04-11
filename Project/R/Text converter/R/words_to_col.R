#'@title Words to column
#'@description This is a complementary function to fix_the_string. Filter the data with another database or just a threshold.
#'@param word_string shall be a integer of class character or numeric
#'@param str_ing_v lower threshold. Do not recommend to lower this much more due to computational reasons
#'@param parallel Make the computation parallelized.
#'@param ... Ignore. A complementary to fix_the_string.
#'@return Returns the filtered words.
#'@export

words_to_col <- function(word_string, str_ing_v, parallel = FALSE, ...){
  #data_orginal is the data you want to merge with
  
  names_data <- sort(names(word_string))
  
  #creates the matrix that is going to be filled
  store_matr <- matrix(0, ncol = length(word_string), nrow = length(str_ing_v))
  colnames(store_matr) <- names_data

  if(parallel == TRUE){
    if(.Platform$OS.type == "unix"){
      
      str_ing_v_table <- parallel::mclapply(str_ing_v, FUN = function(x){
        i_1 <- x[x %in% names_data]
        table(i_1)
      })
      
      setTxtProgressBar(..., 0.55)
      
      str_ing_v_lapply <- parallel::mclapply(str_ing_v_table, FUN = function(x){
        which(names_data %in% names(x))
      })
      
    } else if(.Platform$OS.type == "windows"){
      
      # Calculate the number of cores
      no_cores <- parallel::detectCores() - 1
      # Initiate cluster
      cl <- parallel::makeCluster(no_cores)
      
      str_ing_v_table <- parallel::parLapply(cl, X = str_ing_v, fun = function(x){
        i_1 <- x[x %in% names_data]
        table(i_1)
      })
      
      setTxtProgressBar(..., 0.55)
      
      str_ing_v_lapply <- parallel::parLapply(cl, X = str_ing_v_table, fun = function(x){
        which(names_data %in% names(x))
      })
      
    }
    
  } else {
    #creates tables of words for each cell from function freq_word_tbl with str_ing_v
    str_ing_v_table <- lapply(str_ing_v, function(x){
      i_1 <- x[x %in% names_data]
      table(i_1)
    })
    
    setTxtProgressBar(..., 0.55)
    
    #creates a vector positions for each cell from function freq_word_tbl with str_ing_v
    str_ing_v_lapply <- lapply(str_ing_v_table, function(x){
      which(names_data %in% names(x))
    })
  }
  
  setTxtProgressBar(..., 0.70)
  
  #throw everything in to the matrix
  for(i in 1:nrow(store_matr)){
    
    what_word <- str_ing_v_lapply[[i]]
    
    store_matr[i, what_word] <- str_ing_v_table[[i]]
    
  }
  
  setTxtProgressBar(..., 0.80)
  
  dat_store <- data.frame(store_matr)
  
  return(dat_store)
}
