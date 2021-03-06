#' @title Fill Dates
#' @description Fill missing date values in a dataframe.
#' @param dataframe The original data with missing entries for certain dates.
#' @param identifier A unique identifier to split the data by, such as a customer ID, product ID, etc.
#' @param date_col The date column of the dataframe.
#' @param min_date The minimum date in the range that you want to fill. If left blank, then the minimum value in the data is taken.
#' @param max_date The maximum date in the range that you want to fill. If left blank, then the maximum value in the data is taken.
#' @param time_sequence The interval between dates, either "day", "week", "month", "quarter", or "year".
#' @param fill_data The data that should be filled for missing values. Default are NAs. Should be a list in the form of column_name = value.
#' @return A dataframe with missing entries filled.
#' @importFrom magrittr %>%
#' @importFrom tidyr complete
#' @importFrom lubridate as_date
#' @importFrom data.table rbindlist
#' @export

fill_dates <- function(dataframe, identifier = NA, date_col, min_date = NA, max_date = NA, time_sequence, fill_data = list(NA)){
  inputs <- as.list(match.call()) #Retrieve inputs unevaluated
  dataframe <- as.data.frame(dataframe) #Convert object to dataframe in case it is not

  #Check the time_sequence input
  check_time_sequence(time_sequence)

  #Assign the date column a standard name and convert it to a date type
  date_col <- ifelse(is.na(deparse(substitute(date_col))), NA, deparse(substitute(date_col)))
  check_dat_col(dataframe, date_col)
  colnames(dataframe)[colnames(dataframe) == date_col] <- "date"
  dataframe$date <- as_date(dataframe$date)

  #Assign the appropriate dates to the min and max date parameters
  if(is.na(min_date)){
    min_date <- min(dataframe$date)
  } else {
    min_date <- as_date(min_date)
  }
  if(is.na(max_date)){
    max_date <- max(dataframe$date)
  }
  max_date <- as_date(max_date)

  #Ensure the identifier is valid
  id <- ifelse(is.na(deparse(substitute(identifier))), NA, deparse(substitute(identifier)))
  check_identifier(dataframe, id)

  #Check if separate grouping needs to be done based on a category
  if(is.na(id)){
    df <- dataframe %>% complete(date = seq.Date(min_date, max_date, by = time_sequence), fill = fill_data)
  } else{
    colnames(dataframe)[colnames(dataframe) == id] <- "unique_identifier"
    split_data <- split(dataframe, dataframe$unique_identifier) #Split data based on grouping
    df <- as.data.frame(rbindlist(lapply(split_data, complete, date = seq.Date(min_date, max_date, by = time_sequence), fill = fill_data)))
    df$unique_identifier <- rep(names(split_data), each = nrow(df) / length(split_data))
    colnames(df)[colnames(df) == "unique_identifier"] <- id #Reassign the name of the identifier column to the name in the original data
  }
  colnames(df)[colnames(df) == "date"] <- date_col #Reassign the name of the date column to the name in the original data
  df
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
