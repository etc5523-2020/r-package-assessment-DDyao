#' Server Element (load data) of the shiny web application
#'
#' @import readr
#' @param file A csv file to be loaded
#' @return One part of the server of the shiny web application: load data
#'
#' @examples
#' server_element("var1,var2\n  'a',1\n  'b',2")
#'
#' @export

server_element <- function(file) {

  read_csv(file)

}

server_element2 <- function(file) {

  read_csv(file, col_types = cols(total_people_tested = col_double(),positive_surveys_tests = col_double(), positive_clinical_activity = col_double()))

}

