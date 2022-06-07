### Overview
The package "matthias" houses functions that have been developed while working on various data analysis projects. They are used to calculate quick statistics, assist with reading large data files into R, and cleaning messy data.

* **_%nin%_** is a quick way to check if an item or items are not in a vector or other collection of items.
* **_filter_read_csv_** is useful when you have a very large file, such as a multi-gigabyte CSV/ Excel file, which you will eventually need to filter down. Sometimes this can take quite a long time to do within R, or even crash your session. This function iteratively reads in and filters your data so that your memory limit is not exceeded.
* **_list_lengths_** calculates the length of items in a list/vector/etc.
* **_find_mode_** is a quick way to find the item that appears most frequently in your data. R has built in methods for finding the mean, min, max, etc., but not the mode, hence the find_mode function.
* **_fill_dates_** imputes missing data entries in a dataframe and fills the remaining columns with data specified by the users, or NAs. This can be useful when conducting data on a time series and not all consecutive dates are present.

___
### Motivation
I built this package as a place to store various functions that I have written while working on projects. Rather than constantly looking back through old code, I decided to iron out these functions and save them in a package for future use.
___
### Installation
Install the development version from GitHub via the package "devtools":
    
    Development version from GitHub:
    install.packages("devtools") 

    Install "matthias" (without vignettes)
    devtools::install_github("matthiasronnau/matthias")


    Install "matthias" (with vignettes)
    devtools::install_github("matthiasronnau/matthias", build_vignettes = TRUE)
