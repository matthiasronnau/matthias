#' @title Fill Dates
#' @description Fill missing date values in a dataframe.
#' @param dataframe The original data with missing entries for certain dates.
#' @param identifier A unique identifier to split the data by, such as a customer ID, product ID, etc.
#' @param date_col The date column of the dataframe.
#' @param min_date The minimum date in the range that you want to fill.
#' @param max_date The maximum date in the range that you want to fill.
#' @param time_sequence The interval between dates, either "day", "week", "month", "quarter", or "year".
#' @param fill_data The data that should be filled for missing values. Default are NAs.
#' @return A dataframe with missing entries filled.
#' @importFrom tidyr complete
#' @importFrom lubridate as_date
#' @export

fill_dates <- function(dataframe, identifier = NA, date_col, min_date, max_date, time_sequence, fill_data = NA){
  inputs <- as.list(match.call()) #Retrieve inputs unevaluated
  dataframe <- as.data.frame(dataframe) #Convert object to dataframe in case it is not
  date_col <- deparse(substitute(date_col))
  colnames(dataframe)[colnames(dataframe) == date_col] <- "date"
  dataframe$date <- lubridate::as_date(dataframe$date)
  min_date <- lubridate::as_date(min_date)
  max_date <- lubridate::as_date(max_date)
  id <- ifelse(deparse(substitute(identifier)) == "NA", NA, deparse(substitute(identifier)))
  check_identifier(dataframe, id) #Ensure the identifier is valid
  #print(id)
  if(is.na(id)){ #Check if separate grouping needs to be done based on a category
    dataframe %>% tidyr::complete(date = seq.Date(min_date, max_date, by = time_sequence))
  } else{
    split_data <- split(dataframe, dataframe[[id]]) #Split data based on grouping
    as.data.frame(data.table::rbindlist(lapply(split_data, tidyr::complete, date = seq.Date(min_date, max_date, by = time_sequence))))
  }
}





