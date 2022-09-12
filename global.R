library(shiny) # shiny features
library(shinydashboard) # shinydashboard functions
library(DT)  # for DT tables
library(dplyr)  # for pipe operator & data manipulations
library(plotly) # for data visualization and plots using plotly 
library(ggplot2) # for data visualization & plots using ggplot2
library(ggtext) # beautifying text on top of ggplot
library(maps)
library(ggcorrplot) # for correlation plot
library(shinycssloaders) # to add a loader while graph is populating
library(shinyWidgets)


## importing "Climate_Data_Sri_Lanka.csv"
my_data <- read.csv("Climate_Data_Sri_Lanka.csv",sep=",") 

## create a states object from rownames
rownames(my_data) <- my_data$District

# sorting my_data
my_data <- my_data[order(my_data$District),]

# Column names without state. This will be used in the selectinput for choices in the shinydashboard
c1 = my_data %>% 
  select(-"District") %>% 
  names()

# dataframe without "District" column. used to create the database table
my_data1 = my_data %>% 
  select(-"District")

## importing "panel_list.csv"
panels_data <- read.csv("panel_list.csv",sep=",") 
rownames(panels_data) <- panels_data$Model

panels = panels_data %>% 
  select(-"Model")

## importing research data
research <- read.csv("panels_and_climate.csv",sep=",") 



