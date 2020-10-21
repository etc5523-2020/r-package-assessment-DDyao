library(dplyr)

context("Testing the server_element.R functionality")
test_that("Whether the server element function load file", {

  text = "var1,var2
  'a',1
  'b',2"

  expect_true(!is.null(server_element(text)))

})
