---
title: "Model fitting"
author: "TChu"
date: "10/13/2021"
output: html_document
---
	
# Load needed packages
library(tidymodels) 
library(tidyverse)
library(magrittr)
library(rlang)
library(dotwhisker)  # for visualizing regression results



# load data
processdata <- readRDS(here::here("data","processed_data","processeddata.rds"))

###################
## Model fitting ##
###################

### Linear Linear Model ###

#First, let's set engine for performing linear regression
linear_fit <- 
	linear_reg() %>% 
	set_engine("lm")

##Fits a linear model to the continuous outcome using only the main predictor of interest
#Linear Model 1: regression body temperature on runny nose 
lm_1 <- 
	linear_fit %>% 
	fit(BodyTemp ~ RunnyNose, data = processdata)
lm_1

#summarize the results
tidy(lm_1)


#Linear Model 2: regression body temperature on all predictors
lm_2 <- linear_fit %>% 
	fit(BodyTemp ~ ., data = processdata)
lm_2

#summarize the results
tidy(lm_2)

#generate a dot-and-whisker plot of linear regression results with all predictors
dotwhisker_cont_all_pred <- tidy(lm_2) %>% 
	dotwhisker::dwplot(dot_args = list(size = 2, color = "black"),
										 whisker_args = list(color = "black"),
										 vline = geom_vline(xintercept = 0, colour = "grey50", linetype = 2))

#Compares the model results for the linear regression model with just the main predictor and all predictors.
##Analysis of deviance and model selection
res_lm_aov <-
	anova(lm_1$fit, lm_2$fit, test = "Chisq")
res_lm_aov

#The p-value is smaller than 0.05, therefore the model with all predictors had better fit than the 
#single variable model


### Logistic regression Model ###
# Let's set engine for performing linear regression
logistic_fit <- 
	logistic_reg() %>% 
	set_mode("classification") %>% 
	set_engine("glm")

#Logistic Model 1: regression body temperature on runny nose 
glm_1 <- 
	logistic_fit %>% 
	fit(Nausea ~ RunnyNose, data = processdata)
glm_1

#summarize the results
tidy(glm_1)


#Logistic Model 2: regression body temperature on all predictors
glm_2 <- logistic_fit %>% 
	fit(Nausea ~ ., data = processdata)
glm_2

#summarize the results
tidy(glm_2)


#generate a dot-and-whisker plot of logistic regression results with all predictors
dotwhisker_binary_all_pred <- tidy(glm_2) %>% 
	dotwhisker::dwplot(dot_args = list(size = 2, color = "black"),
										 whisker_args = list(color = "black"),
										 vline = geom_vline(xintercept = 0, colour = "grey50", linetype = 2))

#Compares the model results for the logistic regression model with just the main predictor and all predictors.
##Analysis of deviance and model selection
res_glm_aov <-
	anova(glm_1$fit, glm_2$fit, test = "Chisq")
res_glm_aov

#The p-value is smaller than 0.05, therefore the model with all predictors had better fit than the 
#single variable model


# save result tables and plots
saveRDS(res_lm_aov, file = here::here("results", "res_lm_aov.Rds"))
saveRDS(res_glm_aov, file = here::here("results", "res_glm_aov.Rds"))
ggsave(dotwhisker_cont_all_pred, filename = here::here("results", "dotwhisker_cont_all_pred.png"), height = 8.5, width = 11)
ggsave(dotwhisker_binary_all_pred, filename = here::here("results", "dotwhisker_binary_all_pred.png"), height = 8.5, width = 11)
