dashboardPage(
  skin = "purple",
  
  dashboardHeader(title=span("TempSenz",style = "font-size: 40px"), titleWidth = 250
  ),
  
  dashboardSidebar(
    width = 250,
    sidebarMenu(id = "sidebar",style = 'font-size: 20px',
                menuItem(span("Dataset", style = "font-size: 25px"), tabName = "data", icon = icon("database")),
                menuItem(span("Data Analysis", style = "font-size: 25px"), tabName = "viz", icon=icon("chart-line")),
                
                conditionalPanel("input.sidebar == 'viz' && input.t2 == 'trends' ", prettyRadioButtons(inputId = "var2" , label ="Climate Reading Type" , choices = c1,plain =TRUE, status = "success")),
                conditionalPanel("input.sidebar == 'viz' && input.t2 == 'relation' ", prettyRadioButtons(inputId = "var3" , label ="Climate Data X variable" , choices = c1, selected = "Average.Temperature", status = "success")),
                conditionalPanel("input.sidebar == 'viz' && input.t2 == 'relation' ", prettyRadioButtons(inputId = "var4" , label ="Climate Data Y variable" , choices = c1, selected = "Humidity", status = "success"))
                
    )
  ),
  
  
  dashboardBody(
    style = "font-family: monospace; min-height: 2800px",

    tabItems(
      
      tabItem(tabName = "data", 
              
              h2("Climate Dataset"),
              tabBox(id="t1", width = 12,
                     tabPanel(span("Data", style = "font-size: 20px"), dataTableOutput("dataT"), icon = icon("table")), 
                     tabPanel(span("Data Structure", style = "font-size: 20px"), verbatimTextOutput("structure"), icon=icon("uncharted")),
                     tabPanel(span("Summary", style = "font-size: 20px"), verbatimTextOutput("summary"), icon=icon("chart-pie"))
              ),
              h2("Research Data For Different Climate Conditions"),
              box(width =12,withSpinner(dataTableOutput("dataT3")),solidHeader = TRUE,  collapsible = FALSE),
              h2("Solar Panel Dataset"),
              tabBox(id="t1", width = 12,
                     tabPanel(span("Data", style = "font-size: 20px"), dataTableOutput("dataT2"), icon = icon("table")), 
                     tabPanel(span("Data Structure", style = "font-size: 20px"), verbatimTextOutput("panelStructure"), icon=icon("uncharted")),
                     tabPanel(span("Summary", style = "font-size: 20px"), verbatimTextOutput("panelSummary"), icon=icon("chart-pie"))
              )
              
      ),  
      
      tabItem(tabName = "viz", 
              
              h2("Climate Data Analysis"),
              tabBox(id="t2",  width=12, 
                     tabPanel(span("Readings by District", style = "font-size: 20px"), value="trends",
                              fluidRow(column(7,withSpinner(plotlyOutput("bar"))),
                              column(5,tags$div( box(withSpinner(tableOutput("top5")), title = textOutput("head1") , collapsible = FALSE, status = "info",  collapsed = FALSE, solidHeader = TRUE)),
                                       tags$div( box(withSpinner(tableOutput("low5")), title = textOutput("head2") , collapsible = FALSE, status = "success",  collapsed = FALSE, solidHeader = TRUE))))
                     ),
                     tabPanel(span("Relation Analysis", style = "font-size: 20px"), 
                              radioButtons(inputId ="fit" , label = "Select smooth method" , choices = c("loess", "lm"), selected = "lm" , inline = TRUE), 
                              withSpinner(plotlyOutput("scatter")), value="relation"),
                     side = "left"
              ),
              h2("Research Data Analysis"),
              tabBox(id="t4",  width=12, 
                     tabPanel(span("Plots", style = "font-size: 20px"), value="panelTemp",
                              fluidRow(column(1),
                                       column(3,selectInput(inputId = "var5" , label ="Y variable" , choices = c2)),
                                       column(3),
                                       column(3,selectInput(inputId = "var6" , label ="Y variable" , choices = c3)),
                                       column(2)),
                              fluidRow(column(6,withSpinner(plotlyOutput("plot1"))),
                                       column(6,withSpinner(plotlyOutput("plot2")))),
                              hr(),
                              fluidRow(column(3),
                                       column(3,selectInput(inputId = "var7" , label ="X variable" , choices = c4, selected = "Panel.Temp")),
                                       column(3,selectInput(inputId = "var8" , label ="Y variable" , choices = c4,selected = "Current.A")),
                                       column(3)),
                              fluidRow(column(2),
                                       column(8,withSpinner(plotlyOutput("plot3"))),
                                       column(2))
                              
                     ),
                     side = "left"
              ),
              h2("Power Efficiency [%] at Ideal Conditions [24 C Panel Surface temperature]"),
              withSpinner(plotlyOutput("panal_data")),
              h2("Ideal Efficiency & Calculated Efficiency According to Average Temperature of an Area"),
              tabBox(id="t5",  width=12, 
              fluidRow(column(1),
                       column(3,selectInput(inputId = "var9" , label ="Select A District" , choices = c5)),
                       column(8)),
              fluidRow(withSpinner(plotlyOutput("efficiency_data"))))
              
      )
    )
    
  )
)




