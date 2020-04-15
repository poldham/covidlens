#' @title raw Lens patent files
#' @description A single zipped folder containing thirteen raw csv files with patent data.
#' @source \url{https://about.lens.org/covid-19/}

library(tidyverse)
library(lubridate)
library(janitor)

# funs
source('~/covid19lens/data-raw/import.R')
source('~/covid19lens/data-raw/zzz.R')

# code for processing

fnames <- list.files("/Users/colinbarnes/coronavirus/patents/raw_patents", pattern = "*.csv", full.names = TRUE)

patents <- map(fnames, import, type = "patent") %>%
  bind_rows() %>%
  select(-number, -jurisdiction)

dataset <- fnames %>%
  tibble(path = .) %>%
  mutate(source = basename(path)) %>%
  mutate(source = str_replace(source, "[.]csv", "")) %>%
  mutate(dataset = str_replace(source, "Coronavirus-", "")) %>%
  mutate(dataset = str_replace(dataset, "-patents", "")) %>%
  mutate(dataset = str_replace(dataset, "patents-", "")) %>%
  mutate(dataset = str_replace(dataset, "-based", "")) %>%
  mutate(data_type = "patents") %>%
  select(-path)

patents <- left_join(patents, dataset, by = "source")

patents <- patents %>% select(3, everything())

save(patents, file = "data/patents.rda", compress = "xz")

nms <- names(patents)

glue::glue("#'\\item{{\\code{{{nms}}}}}") %>%
  write_lines(., "data-raw/pat_describe.txt")

usethis::use_data("raw_patents")
