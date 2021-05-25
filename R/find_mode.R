#' @title Find Mode
#' @description Returns the mode of a given series.
#' @param vector A file path to a local csv file.
#' @param remove_na Whether to remove missing values from the sequence prior to finding the mode. Default is true.
#' @return The most frequent value in the sequence.
#' @export

find_mode <- function(vector, remove_na = TRUE) {
  check_input(vector)
  check_logical(remove_na)
  if(remove_na){
    freq <- table(na.omit(vector))
    names(freq)[which.max(freq)]
  }
  else {
    freq <- table(vector)
    names(freq)[which.max(freq)]
  }
}


check_empty <- function(input){
  if(is.null(input)){ #Check that the input is not empty
    stop("\n'vector' must not be null")
  }
  TRUE
}

check_logical <- function(input){
  if(!is.logical(input)){
    stop("\n'remove_na' must be logical")
  }
  TRUE
}
