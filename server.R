

function(input, output, session){
  
  output$dataT <- DT::renderDataTable(DT::datatable(my_data1,options = list(lengthMenu = c(5, 10, 15), pageLength = 5)))
  
  
  # box header  
  output$head1 <- renderText(
    switch(
      input$var2,
      "Lowest.Temperature" = paste("Lowest Temperature Records in Districts [TOP]"),
      "Highest.Temperature" = paste("Highest Temperature Records in Districts [TOP]"),
      "Average.Temperature" = paste("Average Temperature Records in Districts [TOP]"),
      "Humidity" = paste("Humidity Records in 5 Districts [TOP]"),
    )
  )
  
  output$head2 <- renderText(
    switch(
      input$var2,
      "Lowest.Temperature" = paste("Lowest Temperature Records in Districts [BOTTOM]"),
      "Highest.Temperature" = paste("Highest Temperature Records in Districts [BOTTOM]"),
      "Average.Temperature" = paste("Average Temperature Records in Districts [BOTTOM]"),
      "Humidity" = paste("Humidity Records in 5 Districts [BOTTOM]"),
    )
  )
  
  output$top5 <- renderTable({
    
    top <- my_data
    
    top %>% 
      select(District, input$var2) %>% 
      arrange(desc(get(input$var2))) %>% 
      head(5)
    
  },colnames = FALSE)
  
  output$low5 <- renderTable({
    
    my_data %>% 
      select(District, input$var2) %>% 
      arrange(get(input$var2)) %>% 
      head(5)
    
    
  },colnames = FALSE)
  
  
  # structure output
  output$structure <- renderPrint({
    my_data %>% 
      str()
  })
  
  
  # summary Output
  output$summary <- renderPrint({
    my_data %>% 
      summary()
  })
  
  

  
  # Bar Charts - District wise trend
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
  
  # Scatter Charts 
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
  
  # panel data table
  output$dataT2 <-  DT::renderDataTable(DT::datatable(panels,options = list(lengthMenu = c(5, 10, 15), pageLength = 5)))

  
  # structure output
  output$panelStructure <- renderPrint({
    panels %>% 
      str()
  })
  
  
  # summary Output
  output$panelSummary <- renderPrint({
    panels %>% 
      summary()
  })
  
  # Bar Charts - Panel data
  output$panal_data <- renderPlotly({
    panels_data  %>% 
      plot_ly(x = ~Model,y = ~Efficiency.Loss.per.1.C, type = 'bar', name ="Efficiency Loss per +1 C") %>%
      add_trace( y = ~Efficiency, name ="Power Efficiency in Idial Conditions (%)") %>%
      layout(title = "Power Efficiency [%] & Efficiency Loss per +1 C",yaxis = list(title = 'Power Efficiency/ Efficiency Loss (%)'), barmode = 'stack')
  })
  
  ########################
  
  # research data table
  output$dataT3 <-  DT::renderDataTable(DT::datatable(research,options = list(lengthMenu = c(5, 10, 15), pageLength = 5), rownames = FALSE))

  
output$plot1 <- renderPlotly({
  research %>%
    ggplot(aes(x=Ambient.Temp, y=get(input$var5), color = "red")) +
    geom_line() + geom_point()+scale_color_manual(values=c("#56B4E9", "#ffffff"))+
    labs(x = "Ambient Temperature (C)",
         y = input$var5)+
    theme( plot.title = element_textbox_simple(size=10,
                                              halign=0.5),legend.position="none")
})

output$plot2 <- renderPlotly({
  research %>%
    ggplot(aes(x=Panel.Temp, y=get(input$var6), color = "red")) +
    geom_line() + geom_point()+scale_color_manual(values=c("#56B4E9", "#ffffff"))+
    labs(x = "Panel Temperature (C)",
         y = input$var6)+
    theme( plot.title = element_textbox_simple(size=10,
                                               halign=0.5),legend.position="none")
})

output$plot3 <- renderPlotly({
  research %>%
    ggplot(aes(x=get(input$var7), y=get(input$var8), color = "red")) +
    geom_line() + geom_point()+scale_color_manual(values=c("#56B4E9", "#ffffff"))+
    labs(x = input$var7,
         y = input$var8)+
    theme( plot.title = element_textbox_simple(size=10,
                                               halign=0.5),legend.position="none")
})

output$efficiency_data <- renderPlotly({
  efficiency  %>% 
    plot_ly(x = ~Model,y = ~Efficiency.Ideal , type = 'bar', name ="Ideal Efficiency (%)") %>%
    add_trace( y = ~get(input$var9), name ="Real Efficiency (%)") %>%
    layout(yaxis = list(title = 'Ideal Efficiency/ Real Efficiency (%)'), barmode = 'group')
})


}

