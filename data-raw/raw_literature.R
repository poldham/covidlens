## code to prepare `raw_literature` dataset goes here
#' @title Raw literature files on covid-19 from the Lens
#' @description  A set of 9 files containing scientific literture from queries of the Lens on covid-19
#' @source \url{https://about.lens.org/covid-19/}
#'
#'

library(tidyverse)
library(lubridate)
library(janitor)

fnames <- list.files("/Users/colinbarnes/coronavirus/literature/raw_literature", pattern = "*.csv", full.names = TRUE)

literature <- map(fnames, import) %>%
  bind_rows()

dataset <- fnames %>%
  tibble(path = .) %>%
  mutate(source = basename(path)) %>%
  mutate(source = str_replace(source, "[.]csv", "")) %>%
  mutate(dataset = source) %>%
  mutate(data_type = "literature") %>%
  select(-path)

literature <- left_join(literature, dataset, by = "source")

save(literature, file = "data/literature.rda", compress = "xz")

nms <- names(literature)

glue::glue("#'\\item{{\\code{{{nms}}}}}") %>%
  write_lines(., "data-raw/lit_describe.txt")
#' \item{\code{lens_id}}{Lens database identifier}
#' \item{\code{lens_id}}{Lens database identifier}

usethis::use_data("raw_literature")
