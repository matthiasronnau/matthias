#' @title Not In
#' @description Returns a logical vector detailing which elements of an object are not present in a second object.
#' @return logical vector
#' @export

"%nin%" <- function(obj1, obj2){
  Negate(match(obj1, obj1, nomatch = 0) > 0)
}
