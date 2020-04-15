#' @title Literature
#'
#' @description Scientific Literature for Covid-19 from the Lens database.
#'
#' @format A data table with 32 variables and 66,233 rows.
#' \describe{
#' \item{\code{lens_id}}{Lens database identifier}
#' \item{\code{title}}{Publication title}
#' \item{\code{date_published}}{Publication date}
#' \item{\code{publication_year}}{Year of Publication}
#' \item{\code{publication_type}}{Type of publication, journal article etc.}
#' \item{\code{source_title}}{Journal, series or book title}
#' \item{\code{issn}}{International Standard Serial Number}
#' \item{\code{publisher}}{Publisher}
#' \item{\code{source_country}}{Country, source of publication}
#' \item{\code{authors}}{Authors, concatenated with ";;"}
#' \item{\code{abstract}}{Abstract}
#' \item{\code{volume}}{Publication Volume Numbers}
#' \item{\code{issue_number}}{Publication issue number}
#' \item{\code{start_page}}{paper start page}
#' \item{\code{end_page}}{paper end page}
#' \item{\code{fields_of_study}}{Microsoft Academic Graph fields of study labels}
#' \item{\code{keywords}}{Author keywords}
#' \item{\code{mesh_terms}}{Medical Subject Headings (MeSH)}
#' \item{\code{chemicals}}{Chemicals in publication}
#' \item{\code{funding}}{Funding body}
#' \item{\code{source_urls}}{One or more hyperlinks to the publication source, concatenated ";;"}
#' \item{\code{external_url}}{external urls, may be concatenated}
#' \item{\code{pmid}}{PubMed document identifier}
#' \item{\code{doi}}{Digital Object Identifier}
#' \item{\code{microsoft_academic_id}}{Microsoft Academic Graph ID, may be concatenated}
#' \item{\code{pmcid}}{PubMed Central ID}
#' \item{\code{patent_citation_count}}{Count of citations by patent documents}
#' \item{\code{references}}{Lens Ids for bibliographic references}
#' \item{\code{scholarly_citation_count}}{count of scientific citations}
#' \item{\code{source}}{Lens file source}
#' \item{\code{dataset}}{Lens COVID dataset, short name}
#' \item{\code{data_type}}{type of data, literature, patent or patent sequence}
#' }
#'
#' @source  Lens Covid-19 Scholarly datasets. Created by Osmat Jefferson.
#' For further details see \url{https://about.lens.org/covid-19/}
#'
"literature"
