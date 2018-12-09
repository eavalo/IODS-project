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

# RATS
RATSL <-  RATS %>% gather(key = WD, value = Weight, -ID, -Group)
# Extract the day
RATSL <-  RATSL %>% mutate(Time = as.integer(substr(WD, 3, 4)))
# Take a glimpse at the RATSL data
glimpse(RATSL)