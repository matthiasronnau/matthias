#' @title Filter Read CSV
#' @description Iteratively reads in and filters a CSV file based on specified filters.
#' @param path A file path to a local csv file.
#' @param batch_size The size of each csv chunk to be read in.
#' @param filters vector of filters to be applied. Each filter should start with the column name and
#' NOT the name of the file; filter_read_csv will take care of this automatically. For example, if one
#' of the filters was to be applied on the column "Age", the filter would be included in the vector
#' as "Age < 40", NOT as "df$AGE < 40".
#' @return A filtered tibble.
#' @importFrom readr read_csv cols
#' @export

filter_read_csv <- function(path, batch_size = 100, filters){
  check_filters(filters) #Ensure at least one filter is present
  file_nrow <- length(count.fields(path)) #Get the number of rows present in the data
  size <- batch_size
  batches <- seq(from = 0, to = file_nrow + batch_size, by = size) #Prepare the batches based on the batch size and the overall file size
  dat = NULL #Initialize an empty dataframe
  cols.names <- colnames(readr::read_csv(path, skip = batches[1], n_max = 0, col_types = readr::cols())) #Get column names from data
  filter_length <- length(filters) #Count number of filters inputed

  for(i in 1:length(batches)){ #Iterate through every batch
    data_temp <- readr::read_csv(path, skip = batches[i], #Read in a batch_size amount of data
                          n_max = batch_size, col_types = readr::cols())
    colnames(data_temp) <- cols.names #Set the column names of the batch
    for(j in 1:filter_length){ #Iterate through every filter
      data_temp <- subset(data_temp, eval(parse(text = paste("data_temp$", filters[j], sep = "")))) #Subset the data based on the given filters
    }
    dat <- rbind(dat, data_temp) #rbind the filtered data to the filtered data from previous batches
    rm(data_temp_filtered) #Remove the filtered batch
    cat(round(batches[i] / size * 100, 2), "%    \r") #Print what percentage of the rows of the initial CSV file have been read and filtered through
  }
  dat #Return the filtered data
}

check_filters <- function(input){
  if(is.null(input)){ #Check that the input is not empty
    stop("\n'filters' must not be null")
  }
  TRUE
}

