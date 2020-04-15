library(rvest)
baseurl <- "https://about.lens.org/covid-19/"

patent_table <- read_html(baseurl) %>%
  html_nodes(., ".div-table-cell")

dataset <- patent_table %>%
  html_nodes("h5") %>%
  html_text() %>%
  tibble::tibble()

query <- patent_table %>%
  html_nodes(".showlesscontent , .readMore") %>%
  html_text() %>%
  tibble::tibble()

documents <- patent_table %>%
  html_nodes(".div-table-cell , h5") %>%
  html_text()


html_table(patent_table)


pt <- html_nodes(patent_table, css = xpath)

html_table(pt)
