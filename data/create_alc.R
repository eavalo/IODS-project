# Erkka Valo
# 2018.11.07
# Create a dataset for analysis in exercise 3. of IODS course.
# Datasets downloaded from: https://archive.ics.uci.edu/ml/datasets/Student+Performance

# Load needed libraries
library(dplyr)


# Read in the data.
####################

# Set the working directory to IODS project data folder
setwd("~/git/IODS-project/data")
math <- read.table("student-mat.csv", sep=";", header=T)
por <- read.table("student-por.csv", sep=";", header=T)


# Explore the dimensions and structure of the data
####################################################
dim(math)
# [1] 395 33
str(math)

dim(por)
# [1] 649  33
str(por)


# Join the two data sets
##########################

# Common columns to use as identifiers
join_by <- c("school","sex","age","address","famsize","Pstatus","Medu",
             "Fedu","Mjob","Fjob","reason","nursery","internet")

# Join the two datasets by the selected identifiers
math_por <- inner_join(mat, por, by = join_by, suffix=c(".math", ".por"))

# Explore the joined dataset
dim(math_por)
# [1] 382  53
str(math_por)

# Combine duplicated answers
#############################

# Create a new data frame with only the joined columns
alc <- select(math_por, one_of(join_by))

# the columns in the datasets which were not used for joining the data
notjoined_columns <- colnames(math)[!colnames(math) %in% join_by]

# for every column name not used for joining...
for(column_name in notjoined_columns) {
  # select two columns from 'math_por' with the same original name
  two_columns <- select(math_por, starts_with(column_name))
  # select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]

  # if that first column vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # add the first column vector to the alc data frame
    alc[column_name] <- first_column
  }
}

# Create new variables
#######################

# Define a new column alc_use by combining weekday and weekend alcohol use
alc <- mutate(alc, alc_use=(Dalc + Walc) / 2)

# Define a new logical column 'high_use'
alc <- mutate(alc, high_use = alc_use > 2)

# Check the structure of the dataset
dim(alc)
# [1] 382  35
glimpse(alc)

# Write dataset to file
########################
write.csv(alc, "alc.csv", row.names = FALSE)

