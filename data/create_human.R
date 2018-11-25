# Erkka Valo
# 2018.11.07
# Create a dataset in exercise 4. of IODS course.
# Dataset meta information:
# http://hdr.undp.org/en/content/human-development-index-hdi
# http://hdr.undp.org/sites/default/files/hdr2015_technical_notes.pdf



# Load needed libraries
library(dplyr)

# Read in the data.
####################

# Human development dataset
hd <- read.csv(paste0("http://s3.amazonaws.com/assets.datacamp.com/production/",
                      "course_2218/datasets/human_development.csv"), 
               stringsAsFactors = F)

# Gender inequality dataset
gii <- read.csv(paste0("http://s3.amazonaws.com/assets.datacamp.com/production/",
                       "course_2218/datasets/gender_inequality.csv"), 
                stringsAsFactors = F, na.strings = "..")

# Dimensions of the datasets
dim(hd)
# [1] 195 8
dim(gii)
# [1] 195 10

# Structure of the datasets
str(hd)
# 'data.frame':	195 obs. of  8 variables:
#  $ HDI.Rank                              : int  1 2 3 4 5 6 6 8 9 9 ...
#  $ Country                               : chr  "Norway" "Australia" "Switzerland" "Denmark" ...
#  $ Human.Development.Index..HDI.         : num  0.944 0.935 0.93 0.923 0.922 0.916 0.916 0.915 0.913 0.913 ...
#  $ Life.Expectancy.at.Birth              : num  81.6 82.4 83 80.2 81.6 80.9 80.9 79.1 82 81.8 ...
#  $ Expected.Years.of.Education           : num  17.5 20.2 15.8 18.7 17.9 16.5 18.6 16.5 15.9 19.2 ...
#  $ Mean.Years.of.Education               : num  12.6 13 12.8 12.7 11.9 13.1 12.2 12.9 13 12.5 ...
#  $ Gross.National.Income..GNI..per.Capita: chr  "64,992" "42,261" "56,431" "44,025" ...
#  $ GNI.per.Capita.Rank.Minus.HDI.Rank    : int  5 17 6 11 9 11 16 3 11 23 ...

str(gii)
# 'data.frame':	195 obs. of  10 variables:
#  $ GII.Rank                                    : int  1 2 3 4 5 6 6 8 9 9 ...
#  $ Country                                     : chr  "Norway" "Australia" "Switzerland" "Denmark" ...
#  $ Gender.Inequality.Index..GII.               : num  0.067 0.11 0.028 0.048 0.062 0.041 0.113 0.28 0.129 0.157 ...
#  $ Maternal.Mortality.Ratio                    : int  4 6 6 5 6 7 9 28 11 8 ...
#  $ Adolescent.Birth.Rate                       : num  7.8 12.1 1.9 5.1 6.2 3.8 8.2 31 14.5 25.3 ...
#  $ Percent.Representation.in.Parliament        : num  39.6 30.5 28.5 38 36.9 36.9 19.9 19.4 28.2 31.4 ...
#  $ Population.with.Secondary.Education..Female.: num  97.4 94.3 95 95.5 87.7 96.3 80.5 95.1 100 95 ...
#  $ Population.with.Secondary.Education..Male.  : num  96.7 94.6 96.6 96.6 90.5 97 78.6 94.8 100 95.3 ...
#  $ Labour.Force.Participation.Rate..Female.    : num  61.2 58.8 61.8 58.7 58.5 53.6 53.1 56.3 61.6 62 ...
#  $ Labour.Force.Participation.Rate..Male.      : num  68.7 71.8 74.9 66.4 70.6 66.4 68.1 68.9 71 73.8 ...


# Summaries of the variables
summary(hd)
summary(gii)

# Rename columsn with simpler names
hd <- rename(hd,
             HDI=Human.Development.Index..HDI.,
             Life.Exp=Life.Expectancy.at.Birth,
             Edu.Exp=Expected.Years.of.Education,
             Edu.Mean=Mean.Years.of.Education,
             GNI=Gross.National.Income..GNI..per.Capita,
             GNI.m.HDI.rank=GNI.per.Capita.Rank.Minus.HDI.Rank)

gii <- rename(gii,
              GII=Gender.Inequality.Index..GII.,
              Mat.Mor=Maternal.Mortality.Ratio,
              Ado.Birth=Adolescent.Birth.Rate,
              Parli.F=Percent.Representation.in.Parliament,
              Edu2.F=Population.with.Secondary.Education..Female., 
              Edu2.M=Population.with.Secondary.Education..Male.,
              Labo.F=Labour.Force.Participation.Rate..Female.,
              Labo.M=Labour.Force.Participation.Rate..Male.)


# Define a new column alc_use by combining weekday and weekend alcohol use
gii <- mutate(gii, Edu2.FM = Edu2.F / Edu2.M)
gii <- mutate(gii, Labo.FM = Labo.F / Labo.M)

# Join the datasets by 'Country'
human <- inner_join(hd, gii, by = 'Country')

# Check the dimensions, the dataset should have 195 observations and 19 variables
dim(human)
# [1] 195 19

# Set the working directory to IODS project folder
setwd("~/git/IODS-project/")

# Write dataset to file
write.csv(human, "data/human.csv", row.names = FALSE)