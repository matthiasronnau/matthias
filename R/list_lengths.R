#' @title List Lengths
#' @description Returns a vector of the lengths of each element in the vector.
#' @param x a vector of lists
#' @return vector
#' @export

list_lengths <- function(x){
  lengths <- lapply(x, length)
  unlist(lengths)
}
