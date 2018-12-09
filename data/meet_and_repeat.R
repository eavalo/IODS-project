# Erkka Valo
# 2018.12.04
# Create a dataset in exercise 6 of IODS course.
# https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt
# https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt


# Load needed libraries
library(dplyr)
library(tidyr)

# Read in the data.
####################

# BPRS
BPRS <- read.csv("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", 
               stringsAsFactors = F, header=T, sep=" ")

RATS <- read.csv("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", 
               stringsAsFactors = F, sep="\t", header=T)


# Dimensions of the datasets
dim(BPRS)
# [1] 40 11
dim(RATS)
# [1] 16 13

# Structure of the datasets
str(BPRS)
str(RATS)

# Summary of the variables
summary(BPRS)
summary(RATS)


# BPRS: factor treatment & subject
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)

# RATS: factor ID & Group
RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)


# Convert to long form
########################

# BPRS
BPRSL <-  BPRS %>% gather(key = weeks, value = bprs, -treatment, -subject)
# Extract the week number
BPRSL <-  BPRSL %>% mutate(week = as.integer(substr(weeks, 5, 5)))
# Take a glimpse at the BPRSL data
glimpse(BPRSL)
# Observations: 360
# Variables: 5
# $ treatment <fct> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, ...
# $ subject   <fct> 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 1, 2, 3, 4...
# $ weeks     <chr> "week0", "week0", "week0", "week0", "week0", "week0", "week0", "week0", "week0", ...
# $ bprs      <int> 42, 58, 54, 55, 72, 48, 71, 30, 41, 57, 30, 55, 36, 38, 66, 41, 45, 39, 24, 38, 5...
# $ week      <int> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ...

# RATS
RATSL <-  RATS %>% gather(key = WD, value = Weight, -ID, -Group)
# Extract the day
RATSL <-  RATSL %>% mutate(Time = as.integer(substr(WD, 3, 4)))
# Take a glimpse at the RATSL data
glimpse(RATSL)
# Observations: 176
# Variables: 5
# $ ID     <fct> 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10...
# $ Group  <fct> 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, ...
# $ WD     <chr> "WD1", "WD1", "WD1", "WD1", "WD1", "WD1", "WD1", "WD1", "WD1", "WD1", "WD1", "WD1", ...
# $ Weight <int> 240, 225, 245, 260, 255, 260, 275, 245, 410, 405, 445, 555, 470, 535, 520, 510, 250,...
# $ Time   <int> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, ...

# Set the working directory to IODS project folder
setwd("~/git/IODS-project/")

# Write datasets to file
write.csv(BPRSL, "data/BPRSL.csv")
write.csv(RATSL, "data/RATSL.csv")