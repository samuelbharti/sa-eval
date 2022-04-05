options(shiny.port = 8080)

library(auth0)
library(shiny)
library(tidyverse)
library(data.table)
library(reticulate)
library(Metrics)
library(DT)

library(bs4Dash)
library(shinyWidgets)
library(fresh)
library(plotly)
library(htmltools)
# library(markdown)
# library(dplyr)
# library(Hmisc)
# library(tidyverse)
# library(knitr)
library(shinybusy)
library(googlesheets4)


gs4_deauth()
intern_meta <- read_sheet("https://docs.google.com/spreadsheets/d/1FBHJTzG1iPXZ43e8sQ3OeQI49quekjO1G0X8BaN6F4g/edit?usp=sharing")



a0_info = auth0_info()
# path to my anaconda python binary
#path_to_python <- "C:/Users/Sam/AppData/Local/Programs/Python/Python39/python.exe"
# /Users/cy254/anaconda3/envs/r-reticualte/bin/python"

#use_python(path_to_python)

# example if you want to install a particular python package to a given conda env  
# conda_install("r-reticulate","pandas")
# conda_install("r-reticulate", "xgboost")
# conda_install("r-reticulate", "numpy")
# ensure code runs in correct conda environment 
#use_condaenv("r-reticulate")


# list all submission directories, assumes they are all copied into R project
#submissions <- list.dirs(path = 'submissions',full.names = T)[- 1] 

# read in test data and make model matrix conform to training script. In reality, every submission py_predict function # will handle any pre-processing steps necessary for test model matrix to conform to train model matrix. 
test_data <- fread('./AB_NYC_2019.csv')
label <- test_data[1001:2000,.(price)]
test_data <- test_data[1001:2000,.(minimum_nights)]