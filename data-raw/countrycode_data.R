## code to prepare `countrycode_data` dataset goes here
#' @title countrycode_data
#' @description country code and country name matching table from the country code package. iso2c and the country name field
#' have been edited to include regional and international patent offices
#' @details countrycode data is taken from the country code package and has been
#' edited to include regional and international patent offices. Where the patent
#' office is listed in the application number as "IB" for "International Bureau"
#' the receiving office is WIPO under the Patent Cooperation Treaty. These entries
#' are allocated to the Patent Cooperation Treaty. note that while includes under
#' iso2c regional and international offices are not included under iso2c

# fix to the IB entry
ib <- tibble::tibble(country_name = "Patent Cooperation Treaty",
                     iso2c = "IB")

countrycode_data <- bind_rows(countrycode_data, ib)

save(countrycode_data, file = "data-raw/countrycode_data.rda", compress = "xz")

usethis::use_data("countrycode_data")
