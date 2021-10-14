###############################
# processing script

library(here) #to set path for importing data
library(dplyr) #for data wrangling and cleaning


#load data
rawdata <- readRDS(here::here("data","raw_data","SympAct_Any_Pos.Rda"))

#check the data dimension,structure and summary
dim(rawdata) # 735  63
str(rawdata)
summary(rawdata)

#look up the data
glimpse(rawdata)
View(rawdata)

# Remove all variables that have Score or Total or FluA or FluB or 
# Dxname or Activity in their name and remove the variable Unique.Visit
processeddata <- rawdata %>% 
# remove those columns that contain certain strings
	dplyr::select(-contains("Score"),-contains("Total"),-contains("FluA"),-contains("FluB"),
								-contains("Dxname"),-contains("Activity"),
# remove the variable Unique.Visit
	            	-Unique.Visit) 

# check data dimension and structure again
dim(processeddata) # 735  32
str(processeddata) 

# Remove any NA observations
processeddata <- na.omit(processeddata) 

#look up the data again
dim(processeddata) # 730  32
glimpse(processeddata)
View(processeddata)

# Save new dataset to rds file
saveRDS(processeddata,  here::here("data","processed_data","processeddata.rds"))