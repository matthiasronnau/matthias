#' @title List Lengths
#' @description Returns a vector of the lengths of each element in the vector.
#' @param x a vector of lists
#' @return vector
#' @export

list_lengths <- function(x){
  valid_input(x)
  lengths <- lapply(x, length)
  unlist(lengths)
}

#Helper function to ensure inputs are specified
valid_input <- function(input){
  if(is.null(input)){
    stop("\n'x' must not be null")
  }
  TRUE
}
