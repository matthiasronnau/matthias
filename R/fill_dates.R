#' @title Fill Dates
#' @description Fill missing date values in a dataframe.
#' @param dataframe The original data with missing entries for certain dates.
#' @param identifier A unique identifier to split the data by, such as a customer ID, product ID, etc.
#' @param date_col The date column of the dataframe.
#' @param min_date The minimum date in the range that you want to fill.
#' @param max_date The maximum date in the range that you want to fill.
#' @param time_sequence The interval between dates, either "day", "week", "month", "quarter", or "year".
#' @param fill_data The data that should be filled for missing values. Default are NAs. Should be a list in the form of column_name = value.
#' @return A dataframe with missing entries filled.
#' @importFrom tidyr complete
#' @importFrom lubridate as_date
#' @export

fill_dates <- function(dataframe, identifier = NA, date_col, min_date = NA, max_date = NA, time_sequence, fill_data = list(NA)){
  inputs <- as.list(match.call()) #Retrieve inputs unevaluated
  dataframe <- as.data.frame(dataframe) #Convert object to dataframe in case it is not

  #Check the time_sequence input
  check_time_sequence(time_sequence)

  #Assign the date column a standard name and convert it to a date type
  date_col <- ifelse(deparse(substitute(date_col)) == "NA", NA, deparse(substitute(date_col)))
  check_dat_col(dataframe, date_col)
  colnames(dataframe)[colnames(dataframe) == date_col] <- "date"
  dataframe$date <- lubridate::as_date(dataframe$date)

  #Assign the appropriate dates to the min and max date parameters
  if(is.na(min_date)){
    min_date <- min(dataframe$date)
  } else {
    min_date <- lubridate::as_date(min_date)
  }
  if(is.na(max_date)){
    max_date <- max(dataframe$date)
  }
  max_date <- lubridate::as_date(max_date)

  #Ensure the identifier is valid
  id <- ifelse(deparse(substitute(identifier)) == "NA", NA, deparse(substitute(identifier)))
  check_identifier(dataframe, id)

  #Check if separate grouping needs to be done based on a category
  if(is.na(id)){
    dataframe %>% tidyr::complete(date = seq.Date(min_date, max_date, by = time_sequence), fill = fill_data)
  } else{
    split_data <- split(dataframe, dataframe[[id]]) #Split data based on grouping
    as.data.frame(data.table::rbindlist(lapply(split_data, tidyr::complete, date = seq.Date(min_date, max_date, by = time_sequence), fill = fill_data)))
  }
}

check_time_sequence <- function(x){
  if(x %nin% c("day", "week", "month", "quarter", "year")){
    stop("\'time_sequence' must be either 'day', 'week', 'month', 'quarter', or 'year'")
  }
  TRUE
}

check_identifier <- function(df, x){
  if(is.na(x)){
    TRUE
  } else if(x %nin% colnames(df)){
    stop("\n'identifier' must be blank or a column in the dataframe")
  }
  TRUE
}

check_dat_col <- function(df, x){
  if(is.na(x)){
    stop("\n 'date_col' cannot be missing")
  } else if(x %nin% colnames(df)){
    stop("\n 'date_col' needs to be a column of the dataframe")
  }
  TRUE
}
