library(shiny)
library(shinythemes)
library(plotly)
library(ggplot2)
library(dplyr)
library(lubridate)
library(bomrang)
library(readr)
library(DT)
library(markdown)
theme_set(theme_classic())

# Define UI for application that draws a histogram
ui <- fluidPage(
  br(),
  titlePanel("Covid19 Italy situation"),
  titlePanel("Covid19 analysis"),
  navbarPage(theme = shinytheme("lumen"),
             collapsible = TRUE,
             "covid19-Italy", id="nav",
  tabPanel("Covid19 analysis",
  sidebarLayout(
    # refactor to R function
    ui_element(),

    mainPanel(
      plotlyOutput("region_vs_numbers_of_cases"),
      ("For the situation of each province, we can see that from the figure. Lombardia  has always maintained the highest level of confirmed. There is a strange phenomenon is reagion Emilia-Romagna keep lower confirmed before July,but the numbers of confirmed increase sharply at June, and it keep the increase trend in the rest of the time. It more than Lombardia at July. But decrease sharply at August. As of oct 7th, Campania is the highest confirmed province in Italy.and there was negative growth in P.A Bolzano."),
      br(),br(),br(),br(),br(),br(),br(),
      titlePanel("Covid19 Italy summary table"),
      fluidRow(DT::dataTableOutput("table"),
               ("As we can see from the table. Because lack of data before Feb 14, so we can see that the covid19 case in February is few. but the situation has grown rapidly in March. And then it continued to grow in April, and pick at April, which is 101551 total patients. In the next month, the infection decrease Significantly. Because Italy has effective prevention and control measures. The downward trend has been maintained in June and July. but it started to rebound in August.and it continute to increase at September and October, it increase sharply between August and September.")),))),


      tabPanel("About",fluidRow(column(8,includeMarkdown('./About/About.rmd'))))
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

  #load data
  Total <- server_element2(unz("data/data.zip", "italy_total.csv"))
  Region <- server_element2(unz("data/data.zip", "italy_region.csv"))
  province = server_element(unz("data/data.zip", "italy_province.csv"))

  # clear data
  dat <- Total%>%
    mutate(month=month(date))%>%
    group_by(month)%>%
    filter(cumulative_cases==max(cumulative_cases))%>%
    filter(recovered == max(recovered))%>%
    filter(death == max(death))%>%
    select(month,cumulative_positive_cases,recovered,death)%>%
    rename( MonthlyTotal=cumulative_positive_cases)%>%
    mutate(recovered_rate = round(recovered/MonthlyTotal*100), death_rate = round(deathrate = death/MonthlyTotal*100))

  dat22 <- province%>%
    mutate(month=month(date))%>%
    group_by(region_name,month)%>%
    summarise(total = sum(new_cases))%>%
    arrange(-total)

  output$region_vs_numbers_of_cases <- renderPlotly({
    dat22%>%
      filter(month==input$month)%>%
      plot_ly(y = ~reorder(region_name,total),
              x = ~ total,
              orientation = 'h',
              text =  ~ total,
              textposition = 'auto',
              type = "bar",
              name = "MonthlyTotal",
              marker = list(size = 7,color = "#1f77b4"))%>%
      layout(title = "province vs numbers of cases",
             barmode = 'stack',
             hovermode = "compare",
             legend = list(x = 1, y = 0.5))

})
  output$click <- renderPlot({

    d <- event_data("plotly_click")
    if (is.null(d)) return("Click a bar")

    dat22%>%
      filter(region_name%in%d$y)%>%
      ggplot(aes(x=month,y=total))+geom_line()+geom_point(size=4,shape=20)+ggtitle("The deatil of each province")

  })


  output$table <- DT::renderDataTable(DT::datatable({
    dat
  }, rownames = FALSE))
}


# Run the application
shinyApp(ui = ui, server = server)
