## Shiny UI component for the Dashboard

dashboardPage(

  skin = "purple",
  
  dashboardHeader(title=span("TempSenz Dashboard",style = "font-size: 40px"), titleWidth = 250
  ),
  
  dashboardSidebar(
    width = 250,
    sidebarMenu(id = "sidebar",style = 'font-size: 20px',
                menuItem("Dataset", tabName = "data", icon = icon("database")),
                menuItem("Visualization", tabName = "viz", icon=icon("chart-line")),
                
                # Conditional Panel for conditional widget appearance
                # Filter should appear only for the visualization menu and selected tabs within it
                conditionalPanel("input.sidebar == 'viz' && input.t2 == 'trends' ", selectInput(inputId = "var2" , label ="Select the reading type" , choices = c1)),
                conditionalPanel("input.sidebar == 'viz' && input.t2 == 'relation' ", selectInput(inputId = "var3" , label ="Select the X variable" , choices = c1, selected = "Average.Temperature")),
                conditionalPanel("input.sidebar == 'viz' && input.t2 == 'relation' ", selectInput(inputId = "var4" , label ="Select the Y variable" , choices = c1, selected = "Humidity"))
                
    )
  ),
  
  
  dashboardBody(
    style = "font-family: monospace; min-height: 1550px",

    tabItems(
      
      ## First tab item
      tabItem(tabName = "data", 
              h2("Climate Dataset"),
              tabBox(id="t1", width = 12,
                     tabPanel("Data", dataTableOutput("dataT"), icon = icon("table")), 
                     tabPanel("Data Structure", verbatimTextOutput("structure"), icon=icon("uncharted")),
                     tabPanel("Summary", verbatimTextOutput("summary"), icon=icon("chart-pie"))
              ),
              h2("Solar Panel Dataset"),
              tabBox(id="t1", width = 12,
                     tabPanel("Data", dataTableOutput("dataT2"), icon = icon("table")), 
                     tabPanel("Data Structure", verbatimTextOutput("panelStructure"), icon=icon("uncharted")),
                     tabPanel("Summary", verbatimTextOutput("panelSummary"), icon=icon("chart-pie"))
              )
              
      ),  
      
      # Second Tab Item
      tabItem(tabName = "viz", 
              h2("Climate Data Visualization"),
              tabBox(id="t2",  width=12, 
                     tabPanel("Readings by District", value="trends",
                              fluidRow(tags$div(align="center", box(tableOutput("top5"), title = textOutput("head1") , collapsible = TRUE, status = "primary",  collapsed = TRUE, solidHeader = TRUE)),
                                       tags$div(align="center", box(tableOutput("low5"), title = textOutput("head2") , collapsible = TRUE, status = "primary",  collapsed = TRUE, solidHeader = TRUE))
                                       
                              ),
                              withSpinner(plotlyOutput("bar"))
                     ),
                     tabPanel("Relationship Analysis", 
                              radioButtons(inputId ="fit" , label = "Select smooth method" , choices = c("loess", "lm"), selected = "lm" , inline = TRUE), 
                              withSpinner(plotlyOutput("scatter")), value="relation"),
                     side = "left"
              ),
              h2("Panel Power output"),
              withSpinner(plotlyOutput("panal_data"))
      )
    )
    
  )
)






