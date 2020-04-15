#' Import Literature or Patent Data from the Lens
#' @description Import csv files downloaded from the Lens COVID-19 collection of scientific or patent literature. If patent data specify patent in type. Otherwise
#'   leave as is.
#' @param path A path to the file to import
#' @param type The type of data to import (lit or patent), defaults to lit.
#' @details This code imports literature or patent data and converts col names to lower, replaces spaces with underscores and removes punctuation and brackets.
#' Patent publication and applicationnumber from the lens include spaces between the country code, the number and the kind code as well as "/" in the identifier. This
#' can cause problems if linking to other databases. The original Lens versions are maintained with the prefix lens_ and simplified versions are created lacking spaces
#' and punctuation are created for publication and application numbers.
#' @return data frame
#' @importFrom tibble tibble
#' @importFrom dplyr mutate
#' @importFrom readr read_csv
#' @importFrom readr cols
#' @importFrom readr col_character
#' @importFrom readr col_double
#' @importFrom dplyr rename
#' @importFrom dplyr mutate
#' @importFrom janitor clean_names
#' @importFrom stringr str_detect
#' @importFrom stringr str_replace
#' @importFrom lubridate year
#' @source \url{https://about.lens.org/covid-19/}
#' @exportcov
#' @examples {df <- import_lenslit(path = "/patentr/data/lenslit.csv")
#' df <- import_lenslit(path = "/patentr/data/lenslit.csv", type = "patent"}
import <- function(path, type = NULL){

  # identify basename to add as source column
  # useful when mapping over multiple files

  bname <- basename(path)

  years <- tibble(years = 1900:2020) %>%
    mutate(years = as.character(years))

  if(is.null(type)){
    df <- read_csv(path, col_names = TRUE, cols(
      `Lens ID` = col_character(),
      `ISSNs` = col_character(),
      `Publisher` = col_character(),
      `Source Title` = col_character(),
      `Title` = col_character(),
      `Fields of Study` = col_character(),
      `Date Published` = col_date(format = ""),
      `Publication Year` = col_double(),
      `Publication Type` = col_character(),
      `Keywords` = col_character(),
      `Funding` = col_character(),
      `Issue Number` = col_character(),
      `Start Page` = col_character(),
      `End Page` = col_character(),
      `Author/s` = col_character(),
      `Abstract` = col_character(),
      `Volume` = col_character(),
      `MeSH Terms` = col_character(),
      `Chemicals` = col_character(),
      `Source URLs` = col_character(),
      `Patent Citation Count` = col_double(),
      `PMID` = col_character(),
      `DOI` = col_character(),
      `Microsoft Academic ID` = col_character(),
      `PMCID` = col_character(),
      `References` = col_character(),
      `Scholarly Citation Count` = col_double()
    )) %>%
      rename(authors = "Author/s", issn = "ISSNs", source_urls = "Source URLs", mesh_terms = "MeSH Terms") %>%
      clean_names() %>%
      mutate(source = paste0(bname)) %>%
      mutate(source = str_replace(source, "[.]csv", ""))

  } else {

    # process the patent data this code remanes the lens version of
    # publication/application numbers with the prefix lens_. new versions are
    # created that strip out the spaces and "/" for use in other patent databases.
    # the application country is extracted from the application number
    # the kind codes are extracted to their own column for later processing
    # publication numbers may or may not contain a YYYY. They are identified.
    # the number of characters in the publication number are identified.

    # The Jurisdiction col in Lens data is commonly called the publication number.
    # the original is preserved and publication country added


    df <- read_csv(path, col_names = TRUE, cols(
      .default = col_character(),
      `#` = col_double(),
      `Publication Date` = col_date(format = ""),
      `Publication Year` = col_double(),
      `Application Date` = col_date(format = ""),
      `Earliest Priority Date` = col_date(format = ""),
      `Cited by Patent Count` = col_double(),
      `Simple Family Size` = col_double(),
      `Extended Family Size` = col_double(),
      `Sequence Count` = col_double(),
      `NPL Citation Count` = col_double(),
      `NPL Resolved Citation Count` = col_double())) %>%
      mutate(source = paste0(bname)) %>%
      mutate(source = str_replace(source, "[.]csv", "")) %>%
      clean_names() %>%
      rename(npl_resolved_lens_id = npl_resolved_lens_id_s) %>%
      rename(npl_resolved_external_id = npl_resolved_external_id_s) %>%
      mutate(lens_jurisdiction = jurisdiction) %>%
      mutate(publication_country = jurisdiction) %>%
      rename(lens_publication_number = publication_number) %>%
      rename(lens_application_number = application_number) %>%
      mutate(publication_number = str_replace_all(lens_publication_number, "[/]", "")) %>%
      mutate(publication_number = str_replace_all(publication_number, " ", "")) %>%
      mutate(application_number = str_replace_all(lens_application_number, "[/]", "")) %>%
      mutate(application_number = str_replace_all(application_number, " ", "")) %>%
      mutate(application_country = str_sub(.$application_number, 0,2)) %>%
      mutate(application_year = year(application_date)) %>%
      country_name(., col = "publication_country") %>%
      rename(publication_country_name = country_name) %>%
      country_name(., col = "application_country") %>%
      rename(application_country_name = country_name)

  }
}
