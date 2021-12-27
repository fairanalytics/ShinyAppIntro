server <- function(input, output, session){
  
  output$file_characteristics <- renderText({
    paste0("The file object has a name :", input$flights_data_file$name, "and a data path", input$flights_data_file$datapath)
  })
  
  # import data from csv
  flights_data <- reactive({
    req(input$flights_data_file)
    req(input$airport_target)
    
    read_csv(input$flights_data_file$datapath)%>%
      filter(origin == !!input$airport_target)%>%
      filter(month >= input$time_period[1] & month <=  input$time_period[2])%>%
      arrange(month)%>%
      select(month, dep_delay, arr_delay, time_hour)
  })
  
  # display our dataset into data table object 
  
  output$flights_data_table <- renderDataTable({
    flights_data()
  })
  
  # create a plot/chart :  arrival delay
  output$flights_arr_del_chart <- renderPlot({
    req(flights_data())
    flights_data()%>%ggplot(data = . , aes(x = time_hour, y = arr_delay, color = arr_delay)) + geom_line() + 
      ggtitle(paste("Arrival Delay from Airport:", input$airport_target))
  })
  
  # create a plot  : departure delay 
  output$flights_dep_del_chart <- renderPlot({
    req(flights_data())
    flights_data()%>%ggplot(data = . , aes(x = time_hour, y = dep_delay, color = dep_delay)) + geom_line()+ 
      
      ggtitle(paste("Departure  Delay from Airport:", input$airport_target))
  })
  # create a statistics plot for arrival delays 
  
  output$delay_stats_plot <- renderPlot({
    req(flights_data())
    req(input$include_statistics)
    
    flights_data()%>%
      mutate(month = as.factor(month))%>%
      ggplot(data = . , aes(month, arr_delay, fill = month)) + geom_boxplot()
  })
  
  
  
  
}