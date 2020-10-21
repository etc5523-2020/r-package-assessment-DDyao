#' UI Element (a siderbar panel) of the shiny web application
#'
#' @import shiny
#' @import ggplot2
#'
#' @return One part of the UI of the shiny web application: a sidebar panel that can be used for month selection
#' @export
#'
#' @examples
#' ui_element()
#'
#'

ui_element <- function() {

  # Refactor user interface-side logic of the shiny application
  sidebarPanel(
    selectInput("month", "Which month do you want to know?",
                choices = c("2", "3", "4", "5", "6", "7", "8", "9","10"),
                selected = "2"),
    plotOutput("click"),
  )

}

