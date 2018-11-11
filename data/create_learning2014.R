# Erkka Valo
# 2018.11.07
# Create a dataset for analysis in exercise 2. of IODS course.
# Dataset to modify: http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt

# Load needed libraries
library(dplyr)

# Read in the data.
data_full <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt",
                       sep="\t", header=T)

# Dimensions of the data set
dim(data_full)
# [1] 183  60

str(data_full)
# 59 integer variables, 1 factor (gender)

# questions related to deep, surface and strategic learning
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30",
                    "D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21",
                       "SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20",
                         "ST28")

# Create combination variables by taking the mean
data_full$deep <- rowMeans(select(data_full, one_of(deep_questions)))
data_full$surf <- rowMeans(select(data_full, one_of(surface_questions)))
data_full$stra <- rowMeans(select(data_full, one_of(strategic_questions)))

# Select needed columns and rename some columns
data <- select(data_full, gender, age=Age, attitude=Attitude, deep, surf, 
               stra, points=Points)

# Remove rows with 0 points (students not participating in the exam).
data <- filter(data, points > 0)

# Check if the dimensions match the expected (rows=166, cols=7)
dim(data)
# [1] 166   7

# Set the working directory to IODS project folder
setwd("~/git/IODS-project/")

# Write dataset to file
write.csv(data, "data/learning2014.csv", row.names = FALSE)

# Read the dataset from file
data_read <- read.csv("data/learning2014.csv")

# Check the data looks good
str(data_read)
# 'data.frame':	166 obs. of  7 variables:
#  $ gender  : Factor w/ 2 levels "F","M": 1 2 1 2 2 1 2 1 2 1 ...
#  $ age     : int  53 55 49 53 49 38 50 37 37 42 ...
#  $ attitude: int  37 31 25 35 37 38 35 29 38 21 ...
#  $ deep    : num  3.58 2.92 3.5 3.5 3.67 ...
#  $ surf    : num  2.58 3.17 2.25 2.25 2.83 ...
#  $ stra    : num  3.38 2.75 3.62 3.12 3.62 ...
#  $ points  : int  25 12 24 10 22 21 21 31 24 26 ...

head(data_read)
#   gender age attitude     deep     surf  stra points
# 1      F  53       37 3.583333 2.583333 3.375     25
# 2      M  55       31 2.916667 3.166667 2.750     12
# 3      F  49       25 3.500000 2.250000 3.625     24
# 4      M  53       35 3.500000 2.250000 3.125     10
# 5      M  49       37 3.666667 2.833333 3.625     22
# 6      F  38       38 4.750000 2.416667 3.625     21