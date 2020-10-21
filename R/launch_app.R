#' Launch shiny web application
#'
#' @import shiny
#'
#' @return run shiny web application
#' @export
#'
#' @examples
#' \dontrun{launch_app()}
#'
#'


launch_app <- function() {

  # The shiny app from previous assessment
  appDir <- system.file( "app", package = "DdyaoPackage")

  # Launch application
  shiny::runApp(appDir, display.mode = "normal")
}

