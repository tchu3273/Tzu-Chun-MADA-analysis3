Hello Dr. Handel,

You will find my module 11 exercise in the *code* folder, and all the outputs and results were knitted to *MLmodelscript.html*.

# Project Summary 
The purpose of this repository is to perform data wrangling, cleaning, exploratory and statistical anlaysis on the data provided by Brian McKay [original article](https://datadryad.org/stash/dataset/doi:10.5061/dryad.51c59zw4v). The exercise comprises of three major parts, data wrangling, exploratory data analysis and model fitting. The final dataset includes 730 observations and 32 variables. The outcomes of interest are **Body Temperature (continuous)** and **Nausea (categorical)**. I will focus on exploring how these six predictors, Swollen Lymph Nodes, Fatigue, Runny Nose, Diarrhea, Breathless, Wheeze can predict the main outcomes. 

# Description of datafiles and R codes
**Data folder:** 
- *SympAct_Any_Pos.Rda* is the data downloaded directly from the orginal article site 
- You can find the *processeddata.rds* under the data folder that was generated using the *processingscript.R*


**Code folder:** 
- *processingscript.R* runs the data cleaning and wrangling process
- *analysisscript.R* generated the results from linear regression model and generalized linear regression model and compare the model fits. 
- *exploration.Rmd* produces tables and plottings to explore the relation between our predictors of interests and two main outcomes. 
