## Shiny Server component for dashboard

function(input, output, session){
  
  # Data table Output
  output$dataT <- DT::renderDataTable(DT::datatable(my_data1,options = list(lengthMenu = c(5, 10, 15), pageLength = 5)))
  
  
  # Rendering the box header  
  output$head1 <- renderText(
    switch(
      input$var2,
      "Lowest.Temperature" = paste("Lowest Temperature Records in 5 Districts [TOP]"),
      "Highest.Temperature" = paste("Highest Temperature Records in 5 Districts [TOP]"),
      "Average.Temperature" = paste("Average Temperature Records in 5 Districts [TOP]"),
      "Humidity" = paste("Humidity Records in 5 Districts [TOP]"),
    )
  )
  
  # Rendering the box header 
  output$head2 <- renderText(
    switch(
      input$var2,
      "Lowest.Temperature" = paste("Lowest Temperature Records in 5 Districts [BOTTOM]"),
      "Highest.Temperature" = paste("Highest Temperature Records in 5 Districts [BOTTOM]"),
      "Average.Temperature" = paste("Average Temperature Records in 5 Districts [BOTTOM]"),
      "Humidity" = paste("Humidity Records in 5 Districts [BOTTOM]"),
    )
  )
  
  
  # Rendering table with 5 states with high arrests for specific crime type
  output$top5 <- renderTable({
    
    top <- my_data
    
    top %>% 
      select(District, input$var2) %>% 
      arrange(desc(get(input$var2))) %>% 
      head(5)
    
  },colnames = FALSE)
  
  # Rendering table with 5 states with low arrests for specific crime type
  output$low5 <- renderTable({
    
    my_data %>% 
      select(District, input$var2) %>% 
      arrange(get(input$var2)) %>% 
      head(5)
    
    
  },colnames = FALSE)
  
  
  # For Structure output
  output$structure <- renderPrint({
    my_data %>% 
      str()
  })
  
  
  # For Summary Output
  output$summary <- renderPrint({
    my_data %>% 
      summary()
  })
  
  

  
  ### Bar Charts - District wise trend
  output$bar <- renderPlotly({
    
    if (input$var2 =="Highest.Temperature"){
      my_data %>% 
        plot_ly() %>% 
        add_bars(x=~District, y=~get(input$var2)) %>% 
        layout(title = paste("Highest Temperature readings for each district"),
               xaxis = list(title = "District"),
               yaxis = list(title = paste("Highest Temperature Readings") ))
    }
    else if (input$var2 =="Average.Temperature"){
      my_data %>% 
        plot_ly() %>% 
        add_bars(x=~District, y=~get(input$var2)) %>% 
        layout(title = paste("Average Temperature readings for each district"),
               xaxis = list(title = "District"),
               yaxis = list(title = paste("Average Temperature Readings") ))
    }
    else if (input$var2 =="Humidity"){
      my_data %>% 
        plot_ly() %>% 
        add_bars(x=~District, y=~get(input$var2)) %>% 
        layout(title = paste("Humidity readings for each district"),
               xaxis = list(title = "District"),
               yaxis = list(title = paste("Humidity Readings") ))
    }else{
      my_data %>% 
        plot_ly() %>% 
        add_bars(x=~District, y=~get(input$var2)) %>% 
        layout(title = paste("Lowest Temperature readings for each district"),
               xaxis = list(title = "District"),
               yaxis = list(title = paste("Lowest Temperature Readings") ))
    }
    
  })
  
  ### Scatter Charts 
  output$scatter <- renderPlotly({
    p = my_data %>% 
      ggplot(aes(x=get(input$var3), y=get(input$var4))) +
      geom_point() +
      geom_smooth(method=get(input$fit)) +
      labs(title = paste("Relation between", input$var3 , "and" , input$var4),
           x = input$var3,
           y = input$var4) +
      theme(  plot.title = element_textbox_simple(size=10,
                                                  halign=0.5))
    
    
    # applied ggplot to make it interactive
    ggplotly(p)
    
    
  
    
  })
  ########################
  
  # render panel data table
  output$dataT2 <-  DT::renderDataTable(DT::datatable(panels,options = list(lengthMenu = c(5, 10, 15), pageLength = 5)))

  
  # For Structure output
  output$panelStructure <- renderPrint({
    panels %>% 
      str()
  })
  
  
  # For Summary Output
  output$panelSummary <- renderPrint({
    panels %>% 
      summary()
  })
  
  ### Bar Charts - Panel data
  output$panal_data <- renderPlotly({
    panels_data  %>% 
      plot_ly(x = ~Model,y = ~Power.Loss.per.1.C, type = 'bar', name ="Loss per +1 C") %>%
      add_trace( y = ~Power.Watt, name ="Power Output") %>%
      layout(yaxis = list(title = 'Ideal Power Output/ Power Loss'), barmode = 'stack')
  })
  
  ########################
  
  # render panel data table
  output$dataT3 <-  DT::renderDataTable(DT::datatable(research,options = list(lengthMenu = c(5, 10, 15), pageLength = 5), rownames = FALSE))

}

