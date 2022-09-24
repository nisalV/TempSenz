library(shiny)
library(shinydashboard) 
library(DT) 
library(dplyr)  
library(plotly) 
library(ggplot2)
library(ggtext)
library(maps)
library(ggcorrplot)
library(shinycssloaders) 
library(shinyWidgets)


# importing "Climate_Data_Sri_Lanka.csv"
my_data <- read.csv("Climate_Data_Sri_Lanka.csv",sep=",") 

# create a states object from rownames
rownames(my_data) <- my_data$District

# sorting my_data
my_data <- my_data[order(my_data$District),]

# Climate Column names without District.
c1 = my_data %>% 
  select(-"District") %>% 
  names()

# data frame without "District" column
my_data1 = my_data %>% 
  select(-"District")

# importing "panel_list.csv"
panels_data <- read.csv("panel_list.csv",sep=",") 
rownames(panels_data) <- panels_data$Model

panels = panels_data %>% 
  select(-"Model")

# importing research data
research <- read.csv("panels_and_climate.csv",sep=",") 

research <- research[order(research$"Ambient.Temp"),]

# Research Column names without District
c2 = research %>% 
  select("Current.A","Voltage.V","Power","Panel.Temp","Relative.Humidity") %>% 
  names()

c3 = research %>% 
  select("Current.A","Voltage.V","Power","Relative.Humidity","Ambient.Temp") %>% 
  names()

c4 = research %>% 
  select("Current.A","Voltage.V","Power","Panel.Temp","Relative.Humidity","Ambient.Temp") %>% 
  names()

efficiency <- read.csv("panel_efficiency.csv",sep=",") 


c5 = efficiency %>% 
  select(-"Model",-"Efficiency.Ideal",-"Efficiency.Loss.per.1.C") %>% 
  names()