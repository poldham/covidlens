#' Convert Country Codes to Country and Patent Instrument Names
#' @description This takes a field containing a two letter country/patent instrument code and converts it to a country or instrument name based on data from the country code packge.
#' @param x a data frame
#' @param col column containing two letter country codes
#'
#' @return data frame
#' @export
#'
#' @examples \dontrun{res <- country_name(family, "family_country")}
country_name <- function(x, col){
  # convert to tidy evaluation
  # load the country code and instrument table

  load("~/covidlens/data-raw/countrycode_data.rda")

  cc <- countrycode_data %>%
    dplyr::select(iso2c, country_name)

  # join the source and country code table
  x <- x %>% dplyr::mutate(iso2c = .data[[col]]) %>%
    dplyr::left_join(., cc, by = "iso2c") %>%
    dplyr::select(-iso2c)
}
