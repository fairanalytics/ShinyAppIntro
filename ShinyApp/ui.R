library("shiny")
library("readr")
library("dplyr")
library("ggplot2")


fluidPage(
  # titlePanel("This my first App")
  titlePanel(tags$img(src = "nyc_airport_logo.png")),
  sidebarLayout(
    #this for the side bar panel/navigation
    sidebarPanel(width = 2,
                 fileInput(inputId = "flights_data_file", label = "Choose Input file (Flights)"),
                 selectInput(inputId = "airport_target", label = "Select Target Airport", choices = c("JFK","LGA","EWR"), selected = "EWR", multiple = FALSE),
                 sliderInput(inputId = "time_period" , label = "Time Period", min = 1, max = 12, value = c(1, 12)),
                 checkboxInput(inputId = "include_statistics", label = "Display Delay Stats")
                 ),
    # this will contain the content we want to display 
    mainPanel(
      
      tabsetPanel(type = "pills",
        tabPanel(title = "Info",icon = icon("info-circle"),
                 h3("This is a shinyb app that has been developed during a training session")
                 ),#info panel end 
        tabPanel(title = "Data", icon = icon("table"),
                 # data table 
                 dataTableOutput("flights_data_table")
                 ),#Data panel end
        tabPanel(title = "Chart",icon = icon("chart-line"),
                 fluidRow(
                   column(width = 4, plotOutput("flights_arr_del_chart")),
                   column(width = 8, plotOutput("flights_dep_del_chart"))
                 ),
                 plotOutput("delay_stats_plot")
                 
                 
                 )
        
      )#tabsetpanel end
      
      
      
      
      
      
      
    )
  )
  
)# fluid Page end 