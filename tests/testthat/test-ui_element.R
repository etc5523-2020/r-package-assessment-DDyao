library(shiny)
library(plotly)
library(ggplot2)

context("Testing the ui_element.R functionality")
test_that("Whether ui_element() function works", {

  expect_true(!is.null(ui_element()))

})
