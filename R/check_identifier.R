#' @title Check Identifier
#' @description Helper function for fill_dates. Ensures that the identifier variable is a valid input from the user.
#' @param dataframe The original data from the user.
#' @param identifier A unique identifier to split the data by, such as a customer ID, product ID, etc.
#' @return Nothing if valid, an error message if an invalid input.

check_identifier <- function(df, x){
  if(is.na(x)){
    TRUE
  } else if(x %nin% colnames(df)){
    stop("\n'identifier' must be blank or a column in the dataframe")
  }
  TRUE
}





